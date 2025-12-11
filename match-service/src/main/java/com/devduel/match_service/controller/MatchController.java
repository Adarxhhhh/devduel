package com.devduel.match_service.controller;

import com.devduel.match_service.dto.*;
import com.devduel.match_service.service.MatchService;
import lombok.RequiredArgsConstructor;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.Map;

@RestController
@RequestMapping("/matches")
@RequiredArgsConstructor
public class MatchController {
    private final MatchService matchService;

    @PostMapping("/solo")
    public ResponseEntity<MatchState> createSoloMatch(
            @RequestHeader(value = "X-User-Id", required = false) String userId,
            @RequestBody CreateMatchRequest request) {
        String playerId = userId != null ? userId : "anonymous";
        return ResponseEntity.status(HttpStatus.CREATED).body(matchService.createSoloMatch(playerId, request));
    }

    @GetMapping("/{id}")
    public ResponseEntity<MatchState> getMatch(@PathVariable String id) {
        MatchState state = matchService.getMatch(id);
        if (state == null) return ResponseEntity.notFound().build();
        return ResponseEntity.ok(state);
    }

    @PostMapping("/{id}/submit")
    public ResponseEntity<Map<String, Object>> submitCode(
            @PathVariable String id,
            @RequestBody MatchSubmitRequest request) {
        return ResponseEntity.ok(matchService.submitCode(id, request));
    }

    @PostMapping("/{id}/typing")
    public ResponseEntity<Void> sendTyping(
            @PathVariable String id,
            @RequestBody Map<String, String> body) {
        matchService.sendTypingEvent(id, body.get("playerId"), body.get("code"));
        return ResponseEntity.ok().build();
    }

    @PostMapping("/{id}/winner")
    public ResponseEntity<Void> claimWinner(
            @PathVariable String id,
            @RequestBody Map<String, String> body) {
        matchService.claimWinner(id, body.get("playerId"));
        return ResponseEntity.ok().build();
    }
}
