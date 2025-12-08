package com.devduel.challenge_service.dto;

import lombok.*;
import java.util.List;

@Data @Builder @NoArgsConstructor @AllArgsConstructor
public class SubmitResponse {
    private boolean allPassed;
    private int totalTests;
    private int passedTests;
    private List<TestResult> results;

    @Data @Builder @NoArgsConstructor @AllArgsConstructor
    public static class TestResult {
        private String testCaseId;
        private boolean passed;
        private String input;
        private String expectedOutput;
        private String actualOutput;
        private boolean hidden;
        private String error;
    }
}
