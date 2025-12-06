package com.devduel.ai_service.service;

import com.devduel.ai_service.dto.CodeReviewResponse;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.web.reactive.function.client.WebClient;

import java.util.*;

@Service
@Slf4j
public class GeminiService {
    private final WebClient webClient;
    private final String model;

    @Value("${gemini.api-key:}")
    private String apiKey;

    public GeminiService(@Value("${gemini.model:gemini-2.0-flash}") String model) {
        this.model = model;
        this.webClient = WebClient.builder()
                .baseUrl("https://generativelanguage.googleapis.com/v1beta")
                .defaultHeader("Content-Type", "application/json")
                .build();
    }

    public boolean isAvailable() {
        return apiKey != null && !apiKey.isBlank();
    }

    public CodeReviewResponse reviewCode(String code, String language, String problemDescription,
                                          String difficulty, boolean allTestsPassed) {
        if (!isAvailable()) {
            log.error("Gemini API key is not configured!");
            return CodeReviewResponse.builder()
                    .status("error")
                    .errorMessage("AI service is not configured. Please set a valid Gemini API key.")
                    .build();
        }

        String prompt = buildReviewPrompt(code, language, problemDescription, difficulty, allTestsPassed);

        Map<String, Object> request = Map.of(
                "contents", List.of(
                        Map.of("role", "user", "parts", List.of(Map.of("text", prompt)))
                ),
                "generationConfig", Map.of(
                        "temperature", 0.3,
                        "maxOutputTokens", 4096
                )
        );

        try {
            log.info("Calling Gemini API for code review (language: {}, difficulty: {})", language, difficulty);
            @SuppressWarnings("unchecked")
            Map<String, Object> response = webClient.post()
                    .uri(uriBuilder -> uriBuilder
                            .path("/models/{model}:generateContent")
                            .queryParam("key", apiKey)
                            .build(model))
                    .bodyValue(request)
                    .retrieve()
                    .bodyToMono(Map.class)
                    .block();

            if (response == null) {
                return errorResponse("No response from AI service");
            }
            if (response.containsKey("error")) {
                log.error("Gemini API error: {}", response.get("error"));
                return errorResponse("AI service temporarily unavailable. Try again later.");
            }

            String text = extractTextFromResponse(response);
            if (text == null) {
                return errorResponse("Failed to parse AI response");
            }

            return parseReviewResponse(text);
        } catch (Exception e) {
            log.error("Gemini API call failed: {}", e.getMessage());
            return errorResponse("AI service error: " + e.getMessage());
        }
    }

    private String buildReviewPrompt(String code, String language, String problemDescription,
                                      String difficulty, boolean allTestsPassed) {
        return String.format("""
                You are an expert code reviewer for a competitive programming platform.

                Review the following %s code submitted for this problem:

                --- PROBLEM ---
                %s
                --- END PROBLEM ---

                Difficulty: %s
                All tests passed: %s

                --- CODE ---
                %s
                --- END CODE ---

                Respond in EXACTLY this format (keep the labels, fill in values):

                QUALITY_SCORE: [number 1-100]
                TIME_COMPLEXITY: [big-O notation]
                SPACE_COMPLEXITY: [big-O notation]
                SUMMARY: [1-2 sentence overall assessment]
                STRENGTHS:
                - [strength 1]
                - [strength 2]
                - [strength 3]
                IMPROVEMENTS:
                - [improvement 1]
                - [improvement 2]
                - [improvement 3]
                IMPROVED_CODE:
                ```
                [your improved version of the code]
                ```

                Be specific and constructive. If the code is already optimal, say so.
                If tests failed, focus on correctness first.
                """,
                language, problemDescription, difficulty, allTestsPassed, code);
    }

    @SuppressWarnings("unchecked")
    private String extractTextFromResponse(Map<String, Object> response) {
        try {
            List<Map<String, Object>> candidates = (List<Map<String, Object>>) response.get("candidates");
            if (candidates == null || candidates.isEmpty()) return null;
            Map<String, Object> content = (Map<String, Object>) candidates.get(0).get("content");
            if (content == null) return null;
            List<Map<String, Object>> parts = (List<Map<String, Object>>) content.get("parts");
            if (parts == null || parts.isEmpty()) return null;
            return (String) parts.get(0).get("text");
        } catch (Exception e) {
            log.error("Failed to extract text from Gemini response: {}", e.getMessage());
            return null;
        }
    }

    private CodeReviewResponse parseReviewResponse(String text) {
        try {
            int score = extractInt(text, "QUALITY_SCORE:");
            String timeCx = extractLine(text, "TIME_COMPLEXITY:");
            String spaceCx = extractLine(text, "SPACE_COMPLEXITY:");
            String summary = extractLine(text, "SUMMARY:");
            List<String> strengths = extractBulletList(text, "STRENGTHS:");
            List<String> improvements = extractBulletList(text, "IMPROVEMENTS:");
            String improvedCode = extractCodeBlock(text);

            return CodeReviewResponse.builder()
                    .qualityScore(Math.max(1, Math.min(100, score)))
                    .timeComplexity(timeCx != null ? timeCx : "Unknown")
                    .spaceComplexity(spaceCx != null ? spaceCx : "Unknown")
                    .summary(summary != null ? summary : "Review completed.")
                    .strengths(strengths.isEmpty() ? List.of("Code submitted successfully") : strengths)
                    .improvements(improvements.isEmpty() ? List.of("No major issues found") : improvements)
                    .improvedCode(improvedCode)
                    .status("success")
                    .build();
        } catch (Exception e) {
            log.error("Failed to parse review response: {}", e.getMessage());
            // Return the raw text as summary if parsing fails
            return CodeReviewResponse.builder()
                    .qualityScore(50)
                    .timeComplexity("Unknown")
                    .spaceComplexity("Unknown")
                    .summary(text.length() > 500 ? text.substring(0, 500) + "..." : text)
                    .strengths(List.of("Review completed"))
                    .improvements(List.of("See summary for details"))
                    .status("success")
                    .build();
        }
    }

    private int extractInt(String text, String label) {
        String line = extractLine(text, label);
        if (line == null) return 50;
        try {
            return Integer.parseInt(line.replaceAll("[^0-9]", ""));
        } catch (NumberFormatException e) {
            return 50;
        }
    }

    private String extractLine(String text, String label) {
        int idx = text.indexOf(label);
        if (idx < 0) return null;
        int start = idx + label.length();
        int end = text.indexOf('\n', start);
        if (end < 0) end = text.length();
        return text.substring(start, end).trim();
    }

    private List<String> extractBulletList(String text, String label) {
        List<String> items = new ArrayList<>();
        int idx = text.indexOf(label);
        if (idx < 0) return items;

        String[] lines = text.substring(idx + label.length()).split("\n");
        for (String line : lines) {
            String trimmed = line.trim();
            if (trimmed.startsWith("- ")) {
                items.add(trimmed.substring(2).trim());
            } else if (!trimmed.isEmpty() && !trimmed.startsWith("-") && !items.isEmpty()) {
                break; // Hit a non-bullet line after bullets, stop
            }
        }
        return items;
    }

    private String extractCodeBlock(String text) {
        int idx = text.indexOf("IMPROVED_CODE:");
        if (idx < 0) return null;
        String after = text.substring(idx);
        int codeStart = after.indexOf("```");
        if (codeStart < 0) return null;
        // Skip the ``` and optional language identifier
        int lineEnd = after.indexOf('\n', codeStart);
        if (lineEnd < 0) return null;
        int codeEnd = after.indexOf("```", lineEnd);
        if (codeEnd < 0) return after.substring(lineEnd + 1).trim();
        return after.substring(lineEnd + 1, codeEnd).trim();
    }

    private CodeReviewResponse errorResponse(String message) {
        return CodeReviewResponse.builder()
                .status("error")
                .errorMessage(message)
                .qualityScore(0)
                .build();
    }
}
