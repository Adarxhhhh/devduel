package com.devduel.match_service.dto;

import lombok.*;
import java.io.Serializable;

@Data @Builder @NoArgsConstructor @AllArgsConstructor
public class MatchState implements Serializable {
    private String matchId;
    private String player1Id;
    private String player2Id;
    private String problemId;
    private String status; // WAITING, ACTIVE, FINISHED
    private String winnerId;
    private String startedAt;
    private String finishedAt;
    private String difficulty;
}
