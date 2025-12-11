package com.devduel.match_service.service;

import com.devduel.match_service.dto.*;
import com.fasterxml.jackson.databind.ObjectMapper;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.data.redis.core.RedisTemplate;
import org.springframework.messaging.simp.SimpMessagingTemplate;
import org.springframework.stereotype.Service;
import org.springframework.web.reactive.function.client.WebClient;

import java.time.Instant;
import java.util.*;
import java.util.concurrent.TimeUnit;

@Service
@RequiredArgsConstructor
@Slf4j
public class MatchService {
    private final RedisTemplate<String, Object> redisTemplate;
    private final SimpMessagingTemplate messagingTemplate;
    private final WebClient.Builder webClientBuilder;
    private final ObjectMapper objectMapper;

    @Value("${services.challenge-url}")
    private String challengeUrl;

    @Value("${services.leaderboard-url}")
    private String leaderboardUrl;

    private static final String MATCH_PREFIX = "match:";
    private static final String WINNER_PREFIX = "winner:";
    private static final long MATCH_TTL = 7200;

    public MatchState createSoloMatch(String playerId, CreateMatchRequest request) {
        String difficulty = request.getDifficulty() != null ? request.getDifficulty() : "MEDIUM";

        // Fetch random problem from challenge-service
        Map problemResponse = webClientBuilder.build()
                .get()
                .uri(challengeUrl + "/problems/random?difficulty=" + difficulty)
                .retrieve()
                .bodyToMono(Map.class)
                .block();

        String problemId = (String) problemResponse.get("id");

        String matchId = UUID.randomUUID().toString();
        MatchState state = MatchState.builder()
                .matchId(matchId)
                .player1Id(playerId)
                .player2Id("solo")
                .problemId(problemId)
                .status("ACTIVE")
                .startedAt(Instant.now().toString())
                .difficulty(difficulty)
                .build();

        // Store in Redis
        Map<String, String> hash = new HashMap<>();
        hash.put("matchId", state.getMatchId());
        hash.put("player1Id", state.getPlayer1Id());
        hash.put("player2Id", state.getPlayer2Id());
        hash.put("problemId", state.getProblemId());
        hash.put("status", state.getStatus());
        hash.put("startedAt", state.getStartedAt());
        hash.put("difficulty", state.getDifficulty());

        String key = MATCH_PREFIX + matchId;
        redisTemplate.opsForHash().putAll(key, hash);
        redisTemplate.expire(key, MATCH_TTL, TimeUnit.SECONDS);

        // Notify via WebSocket
        messagingTemplate.convertAndSend("/topic/match/" + matchId,
                MatchEvent.builder().type("MATCH_STARTED").matchId(matchId).payload(state).build());

        return state;
    }

    public MatchState getMatch(String matchId) {
        String key = MATCH_PREFIX + matchId;
        Map<Object, Object> hash = redisTemplate.opsForHash().entries(key);
        if (hash.isEmpty()) return null;

        return MatchState.builder()
                .matchId((String) hash.get("matchId"))
                .player1Id((String) hash.get("player1Id"))
                .player2Id((String) hash.get("player2Id"))
                .problemId((String) hash.get("problemId"))
                .status((String) hash.get("status"))
                .winnerId((String) hash.get("winnerId"))
                .startedAt((String) hash.get("startedAt"))
                .finishedAt((String) hash.get("finishedAt"))
                .difficulty((String) hash.get("difficulty"))
                .build();
    }

    public Map<String, Object> submitCode(String matchId, MatchSubmitRequest request) {
        MatchState match = getMatch(matchId);
        if (match == null) {
            throw new RuntimeException("Match not found");
        }
        if ("FINISHED".equals(match.getStatus())) {
            throw new RuntimeException("Match already finished");
        }

        // Forward to challenge-service
        Map<String, String> submitBody = Map.of(
                "language", request.getLanguage(),
                "code", request.getCode()
        );

        Map submitResponse = webClientBuilder.build()
                .post()
                .uri(challengeUrl + "/problems/" + match.getProblemId() + "/submit")
                .bodyValue(submitBody)
                .retrieve()
                .bodyToMono(Map.class)
                .block();

        boolean allPassed = (Boolean) submitResponse.get("allPassed");

        // Send submission result via WebSocket
        messagingTemplate.convertAndSend("/topic/match/" + matchId,
                MatchEvent.builder()
                        .type("SUBMISSION_RESULT")
                        .matchId(matchId)
                        .payload(Map.of(
                                "playerId", request.getPlayerId(),
                                "allPassed", allPassed,
                                "results", submitResponse
                        ))
                        .build());

        if (allPassed) {
            // Atomically claim winner using SETNX
            Boolean isWinner = redisTemplate.opsForValue()
                    .setIfAbsent(WINNER_PREFIX + matchId, request.getPlayerId(), MATCH_TTL, TimeUnit.SECONDS);

            if (Boolean.TRUE.equals(isWinner)) {
                finishMatch(matchId, request.getPlayerId());
            }
        }

        submitResponse.put("isWinner", allPassed && Boolean.TRUE.equals(
                redisTemplate.opsForValue().get(WINNER_PREFIX + matchId) != null &&
                redisTemplate.opsForValue().get(WINNER_PREFIX + matchId).equals(request.getPlayerId())));

        return submitResponse;
    }

    public void claimWinner(String matchId, String playerId) {
        Boolean isWinner = redisTemplate.opsForValue()
                .setIfAbsent(WINNER_PREFIX + matchId, playerId, MATCH_TTL, TimeUnit.SECONDS);
        if (Boolean.TRUE.equals(isWinner)) {
            finishMatch(matchId, playerId);
        }
    }

    private void finishMatch(String matchId, String winnerId) {
        String key = MATCH_PREFIX + matchId;
        redisTemplate.opsForHash().put(key, "status", "FINISHED");
        redisTemplate.opsForHash().put(key, "winnerId", winnerId);
        redisTemplate.opsForHash().put(key, "finishedAt", Instant.now().toString());

        MatchState finalState = getMatch(matchId);

        String loserId = winnerId.equals(finalState.getPlayer1Id()) ?
                finalState.getPlayer2Id() : finalState.getPlayer1Id();

        // Notify via WebSocket
        messagingTemplate.convertAndSend("/topic/match/" + matchId,
                MatchEvent.builder()
                        .type("MATCH_FINISHED")
                        .matchId(matchId)
                        .payload(Map.of(
                                "winnerId", winnerId,
                                "loserId", loserId,
                                "matchId", matchId
                        ))
                        .build());

        // Post result to leaderboard-service
        try {
            Instant start = Instant.parse(finalState.getStartedAt());
            int duration = (int) java.time.Duration.between(start, Instant.now()).getSeconds();

            webClientBuilder.build()
                    .post()
                    .uri(leaderboardUrl + "/leaderboard/results")
                    .bodyValue(Map.of(
                            "winnerId", winnerId,
                            "loserId", loserId,
                            "problemId", finalState.getProblemId(),
                            "durationSeconds", duration,
                            "eloDelta", 25
                    ))
                    .retrieve()
                    .bodyToMono(Void.class)
                    .subscribe();
        } catch (Exception e) {
            log.error("Failed to post match result to leaderboard", e);
        }
    }

    public void sendTypingEvent(String matchId, String playerId, String code) {
        messagingTemplate.convertAndSend("/topic/match/" + matchId,
                MatchEvent.builder()
                        .type("OPPONENT_TYPING")
                        .matchId(matchId)
                        .payload(Map.of("playerId", playerId, "code", code))
                        .build());
    }
}
