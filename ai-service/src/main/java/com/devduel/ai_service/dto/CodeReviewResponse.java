package com.devduel.ai_service.dto;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.List;

@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class CodeReviewResponse {
    private int qualityScore;          // 1-100
    private String timeComplexity;     // e.g. "O(n)"
    private String spaceComplexity;    // e.g. "O(1)"
    private String summary;            // 1-2 sentence overall assessment
    private List<String> strengths;    // what's good
    private List<String> improvements; // what to improve
    private String improvedCode;       // AI-suggested better version
    private String status;             // "success" or "error"
    private String errorMessage;       // only if status=error
}
