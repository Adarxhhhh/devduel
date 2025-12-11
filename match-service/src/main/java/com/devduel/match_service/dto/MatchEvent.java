package com.devduel.match_service.dto;

import lombok.*;

@Data @Builder @NoArgsConstructor @AllArgsConstructor
public class MatchEvent {
    private String type; // MATCH_STARTED, OPPONENT_TYPING, SUBMISSION_RESULT, MATCH_FINISHED
    private String matchId;
    private Object payload;
}
