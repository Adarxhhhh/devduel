package com.devduel.match_service.dto;

import lombok.*;

@Data @NoArgsConstructor @AllArgsConstructor
public class MatchSubmitRequest {
    private String language;
    private String code;
    private String playerId;
}
