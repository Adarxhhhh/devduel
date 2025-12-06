package com.devduel.ai_service.service;

import com.devduel.ai_service.dto.CodeReviewRequest;
import com.devduel.ai_service.dto.CodeReviewResponse;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;

@Service
@RequiredArgsConstructor
@Slf4j
public class CodeReviewService {
    private final GeminiService geminiService;

    public CodeReviewResponse reviewCode(CodeReviewRequest request) {
        log.info("Code review requested for {} code (difficulty: {}, tests passed: {})",
                request.getLanguage(), request.getDifficulty(), request.isAllTestsPassed());

        if (request.getCode() == null || request.getCode().isBlank()) {
            return CodeReviewResponse.builder()
                    .status("error")
                    .errorMessage("No code provided for review")
                    .qualityScore(0)
                    .build();
        }

        return geminiService.reviewCode(
                request.getCode(),
                request.getLanguage(),
                request.getProblemDescription(),
                request.getDifficulty(),
                request.isAllTestsPassed()
        );
    }

    public boolean isAvailable() {
        return geminiService.isAvailable();
    }
}
