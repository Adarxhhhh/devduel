package com.devduel.challenge_service.dto;

import lombok.*;
import java.util.UUID;

@Data @Builder @NoArgsConstructor @AllArgsConstructor
public class TestCaseDto {
    private UUID id;
    private String input;
    private String expectedOutput;
    private boolean hidden;
}
