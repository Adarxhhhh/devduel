package com.devduel.leaderboard_service.controller;

import com.devduel.leaderboard_service.dto.*;
import com.devduel.leaderboard_service.service.LeaderboardService;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/leaderboard")
@RequiredArgsConstructor
public class LeaderboardController {
    private final LeaderboardService leaderboardService;

    @PostMapping("/results")
    public ResponseEntity<Void> postResult(@RequestBody MatchResultRequest request) {
        leaderboardService.processMatchResult(request);
        return ResponseEntity.ok().build();
    }

    @GetMapping
    public ResponseEntity<List<LeaderboardEntry>> getTop(
            @RequestParam(defaultValue = "20") int limit) {
        return ResponseEntity.ok(leaderboardService.getTopPlayers(limit));
    }

    @GetMapping("/me/{userId}")
    public ResponseEntity<LeaderboardEntry> getMyRank(@PathVariable String userId) {
        return ResponseEntity.ok(leaderboardService.getPlayerRank(userId));
    }
}
