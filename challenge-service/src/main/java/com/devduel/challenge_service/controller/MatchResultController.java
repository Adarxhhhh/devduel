package com.devduel.challenge_service.controller;

import com.devduel.challenge_service.dto.MatchResultDto;
import com.devduel.challenge_service.entity.MatchResult;
import com.devduel.challenge_service.service.MatchResultService;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequiredArgsConstructor
public class MatchResultController {
    private final MatchResultService matchResultService;

    @PostMapping("/results")
    public ResponseEntity<MatchResult> postResult(@RequestBody MatchResultDto dto) {
        return ResponseEntity.ok(matchResultService.saveResult(dto));
    }

    @GetMapping("/results/{userId}")
    public ResponseEntity<List<MatchResult>> getHistory(@PathVariable String userId) {
        return ResponseEntity.ok(matchResultService.getMatchHistory(userId));
    }
}
