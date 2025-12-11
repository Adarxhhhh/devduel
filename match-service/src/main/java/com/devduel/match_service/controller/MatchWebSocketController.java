package com.devduel.match_service.controller;

import com.devduel.match_service.dto.MatchEvent;
import com.devduel.match_service.service.MatchService;
import lombok.RequiredArgsConstructor;
import org.springframework.messaging.handler.annotation.DestinationVariable;
import org.springframework.messaging.handler.annotation.MessageMapping;
import org.springframework.messaging.handler.annotation.SendTo;
import org.springframework.stereotype.Controller;

import java.util.Map;

@Controller
@RequiredArgsConstructor
public class MatchWebSocketController {
    private final MatchService matchService;

    @MessageMapping("/match/{matchId}/typing")
    @SendTo("/topic/match/{matchId}")
    public MatchEvent handleTyping(@DestinationVariable String matchId, Map<String, String> payload) {
        return MatchEvent.builder()
                .type("OPPONENT_TYPING")
                .matchId(matchId)
                .payload(payload)
                .build();
    }
}
