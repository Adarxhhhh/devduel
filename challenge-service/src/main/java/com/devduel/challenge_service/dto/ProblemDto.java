package com.devduel.challenge_service.dto;

import lombok.*;
import java.util.List;
import java.util.UUID;

@Data @Builder @NoArgsConstructor @AllArgsConstructor
public class ProblemDto {
    private UUID id;
    private String title;
    private String slug;
    private String description;
    private String difficulty;
    private String category;
    private String starterCodeJava;
    private String starterCodePython;
    private String starterCodeJavascript;
    private List<TestCaseDto> testCases;
}
