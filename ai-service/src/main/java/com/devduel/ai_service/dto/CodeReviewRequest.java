package com.devduel.ai_service.dto;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class CodeReviewRequest {
    private String code;
    private String language;
    private String problemDescription;
    private String difficulty;
    private boolean allTestsPassed;
}
