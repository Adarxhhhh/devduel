package com.devduel.challenge_service.dto;

import lombok.*;
import java.util.UUID;

@Data @Builder @NoArgsConstructor @AllArgsConstructor
public class MatchResultDto {
    private String winnerId;
    private String loserId;
    private UUID problemId;
    private int durationSeconds;
    private int eloDelta;
}
