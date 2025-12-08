package com.devduel.leaderboard_service.service;

import com.devduel.leaderboard_service.dto.*;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.data.redis.core.RedisTemplate;
import org.springframework.data.redis.core.ZSetOperations;
import org.springframework.stereotype.Service;
import org.springframework.web.reactive.function.client.WebClient;

import java.util.*;

@Service
@RequiredArgsConstructor
@Slf4j
public class LeaderboardService {
    private final RedisTemplate<String, String> redisTemplate;
    private final WebClient.Builder webClientBuilder;

    @Value("${services.auth-url}")
    private String authUrl;

    private static final String LEADERBOARD_KEY = "leaderboard:global";
    private static final String WINS_PREFIX = "stats:wins:";
    private static final String LOSSES_PREFIX = "stats:losses:";

    public void processMatchResult(MatchResultRequest request) {
        String winnerId = request.getWinnerId();
        String loserId = request.getLoserId();
        int eloDelta = request.getEloDelta() > 0 ? request.getEloDelta() : 25;

        if (!"solo".equals(winnerId)) {
            updateElo(winnerId, eloDelta);
            redisTemplate.opsForValue().increment(WINS_PREFIX + winnerId);
            Double currentElo = redisTemplate.opsForZSet().score(LEADERBOARD_KEY, winnerId);
            double newElo = (currentElo != null ? currentElo : 1000) + eloDelta;
            redisTemplate.opsForZSet().add(LEADERBOARD_KEY, winnerId, newElo);
        }

        if (!"solo".equals(loserId)) {
            updateElo(loserId, -eloDelta);
            redisTemplate.opsForValue().increment(LOSSES_PREFIX + loserId);
            Double currentElo = redisTemplate.opsForZSet().score(LEADERBOARD_KEY, loserId);
            double newElo = (currentElo != null ? currentElo : 1000) - eloDelta;
            redisTemplate.opsForZSet().add(LEADERBOARD_KEY, loserId, newElo);
        }
    }

    public List<LeaderboardEntry> getTopPlayers(int limit) {
        Set<ZSetOperations.TypedTuple<String>> topPlayers =
                redisTemplate.opsForZSet().reverseRangeWithScores(LEADERBOARD_KEY, 0, limit - 1);

        if (topPlayers == null || topPlayers.isEmpty()) {
            return Collections.emptyList();
        }

        List<LeaderboardEntry> entries = new ArrayList<>();
        int rank = 1;
        for (ZSetOperations.TypedTuple<String> tuple : topPlayers) {
            String userId = tuple.getValue();
            double elo = tuple.getScore() != null ? tuple.getScore() : 1000;
            String username = fetchUsername(userId);
            String winsStr = redisTemplate.opsForValue().get(WINS_PREFIX + userId);
            String lossesStr = redisTemplate.opsForValue().get(LOSSES_PREFIX + userId);

            entries.add(LeaderboardEntry.builder()
                    .rank(rank++)
                    .userId(userId)
                    .username(username != null ? username : "Player-" + userId.substring(0, Math.min(8, userId.length())))
                    .elo((int) elo)
                    .wins(winsStr != null ? Long.parseLong(winsStr) : 0)
                    .losses(lossesStr != null ? Long.parseLong(lossesStr) : 0)
                    .build());
        }
        return entries;
    }

    public LeaderboardEntry getPlayerRank(String userId) {
        Long rank = redisTemplate.opsForZSet().reverseRank(LEADERBOARD_KEY, userId);
        Double elo = redisTemplate.opsForZSet().score(LEADERBOARD_KEY, userId);
        String username = fetchUsername(userId);
        String winsStr = redisTemplate.opsForValue().get(WINS_PREFIX + userId);
        String lossesStr = redisTemplate.opsForValue().get(LOSSES_PREFIX + userId);

        return LeaderboardEntry.builder()
                .rank(rank != null ? rank.intValue() + 1 : -1)
                .userId(userId)
                .username(username != null ? username : "Unknown")
                .elo(elo != null ? elo.intValue() : 1000)
                .wins(winsStr != null ? Long.parseLong(winsStr) : 0)
                .losses(lossesStr != null ? Long.parseLong(lossesStr) : 0)
                .build();
    }

    private void updateElo(String userId, int delta) {
        try {
            webClientBuilder.build()
                    .post()
                    .uri(authUrl + "/internal/users/elo")
                    .bodyValue(Map.of("userId", userId, "eloDelta", delta))
                    .retrieve()
                    .bodyToMono(Void.class)
                    .block();
        } catch (Exception e) {
            log.error("Failed to update ELO for user {}", userId, e);
        }
    }

    private String fetchUsername(String userId) {
        try {
            Map response = webClientBuilder.build()
                    .get()
                    .uri(authUrl + "/internal/users/" + userId)
                    .retrieve()
                    .bodyToMono(Map.class)
                    .block();
            return response != null ? (String) response.get("username") : null;
        } catch (Exception e) {
            return null;
        }
    }
}
