package com.devduel.challenge_service.service;

import lombok.Data;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.MediaType;
import org.springframework.stereotype.Service;
import org.springframework.web.reactive.function.client.WebClient;

import java.util.Base64;
import java.util.Map;

@Service
@Slf4j
public class Judge0Service {
    private final WebClient webClient;

    public Judge0Service(@Value("${judge0.url}") String judge0Url,
                        @Value("${judge0.api-key:}") String apiKey) {
        WebClient.Builder builder = WebClient.builder().baseUrl(judge0Url);
        if (apiKey != null && !apiKey.isEmpty()) {
            builder.defaultHeader("X-RapidAPI-Key", apiKey);
            builder.defaultHeader("X-RapidAPI-Host", "judge0-ce.p.rapidapi.com");
        }
        this.webClient = builder.build();
    }

    public ExecutionResult execute(String sourceCode, int languageId, String stdin) {
        try {
            String encodedSource = Base64.getEncoder().encodeToString(sourceCode.getBytes());
            String encodedStdin = Base64.getEncoder().encodeToString(stdin.getBytes());

            Map<String, Object> body = Map.of(
                "source_code", encodedSource,
                "language_id", languageId,
                "stdin", encodedStdin,
                "base64_encoded", true,
                "wait", true
            );

            Map response = webClient.post()
                    .uri("/submissions?base64_encoded=true&wait=true")
                    .contentType(MediaType.APPLICATION_JSON)
                    .bodyValue(body)
                    .retrieve()
                    .bodyToMono(Map.class)
                    .block();

            if (response == null) {
                return new ExecutionResult(null, "No response from judge", false);
            }

            String stdout = response.get("stdout") != null ?
                    new String(Base64.getDecoder().decode((String) response.get("stdout"))).trim() : null;
            String stderr = response.get("stderr") != null ?
                    new String(Base64.getDecoder().decode((String) response.get("stderr"))).trim() : null;
            String compileOutput = response.get("compile_output") != null ?
                    new String(Base64.getDecoder().decode((String) response.get("compile_output"))).trim() : null;

            Map status = (Map) response.get("status");
            int statusId = status != null ? ((Number) status.get("id")).intValue() : 0;
            boolean accepted = statusId == 3; // 3 = Accepted

            String error = stderr != null ? stderr : compileOutput;
            return new ExecutionResult(stdout, error, accepted);
        } catch (Exception e) {
            log.error("Judge0 execution failed", e);
            return new ExecutionResult(null, "Execution failed: " + e.getMessage(), false);
        }
    }

    public static int getLanguageId(String language) {
        return switch (language.toLowerCase()) {
            case "java" -> 62;
            case "python", "python3" -> 71;
            case "javascript", "js" -> 63;
            default -> throw new IllegalArgumentException("Unsupported language: " + language);
        };
    }

    @Data
    public static class ExecutionResult {
        private final String stdout;
        private final String error;
        private final boolean success;

        public ExecutionResult(String stdout, String error, boolean success) {
            this.stdout = stdout;
            this.error = error;
            this.success = success;
        }
    }
}
