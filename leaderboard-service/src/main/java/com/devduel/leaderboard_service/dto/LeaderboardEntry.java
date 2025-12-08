package com.devduel.leaderboard_service.dto;

import lombok.*;

@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class LeaderboardEntry {
    private int rank;
    private String userId;
    private String username;
    private int elo;
    private long wins;
    private long losses;
}
