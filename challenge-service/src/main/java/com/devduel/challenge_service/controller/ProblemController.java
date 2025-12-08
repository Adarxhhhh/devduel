package com.devduel.challenge_service.controller;

import com.devduel.challenge_service.dto.*;
import com.devduel.challenge_service.service.ProblemService;
import jakarta.validation.Valid;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.UUID;

@RestController
@RequestMapping("/problems")
@RequiredArgsConstructor
public class ProblemController {
    private final ProblemService problemService;

    @GetMapping
    public ResponseEntity<List<ProblemDto>> listProblems(
            @RequestParam(required = false) String difficulty,
            @RequestParam(required = false) String category) {
        return ResponseEntity.ok(problemService.listProblems(difficulty, category));
    }

    @GetMapping("/{id}")
    public ResponseEntity<ProblemDto> getProblem(@PathVariable UUID id) {
        return ResponseEntity.ok(problemService.getProblem(id));
    }

    @GetMapping("/slug/{slug}")
    public ResponseEntity<ProblemDto> getProblemBySlug(@PathVariable String slug) {
        return ResponseEntity.ok(problemService.getProblemBySlug(slug));
    }

    @GetMapping("/random")
    public ResponseEntity<ProblemDto> getRandomProblem(@RequestParam(required = false) String difficulty) {
        return ResponseEntity.ok(problemService.getRandomProblem(difficulty));
    }

    @PostMapping("/{id}/submit")
    public ResponseEntity<SubmitResponse> submitCode(@PathVariable UUID id, @Valid @RequestBody SubmitRequest request) {
        return ResponseEntity.ok(problemService.submitCode(id, request));
    }
}
