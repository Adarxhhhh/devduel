package com.devduel.leaderboard_service.dto;

import lombok.*;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class MatchResultRequest {
    private String winnerId;
    private String loserId;
    private String problemId;
    private int durationSeconds;
    private int eloDelta;
}
