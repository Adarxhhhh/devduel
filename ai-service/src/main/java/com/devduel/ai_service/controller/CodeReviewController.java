package com.devduel.ai_service.controller;

import com.devduel.ai_service.dto.*;
import com.devduel.ai_service.service.CodeReviewService;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.Map;

@RestController
@RequestMapping("/review")
@CrossOrigin(origins = "*")
@RequiredArgsConstructor
public class CodeReviewController {
    private final CodeReviewService codeReviewService;

    @PostMapping
    public ResponseEntity<CodeReviewResponse> reviewCode(@RequestBody CodeReviewRequest request) {
        CodeReviewResponse response = codeReviewService.reviewCode(request);
        return ResponseEntity.ok(response);
    }

    @GetMapping("/health")
    public ResponseEntity<Map<String, Object>> health() {
        return ResponseEntity.ok(Map.of(
                "service", "ai-service",
                "status", "UP",
                "aiAvailable", codeReviewService.isAvailable()
        ));
    }
}
