package com.devduel.challenge_service.service;

import com.devduel.challenge_service.dto.MatchResultDto;
import com.devduel.challenge_service.entity.MatchResult;
import com.devduel.challenge_service.repository.MatchResultRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
@RequiredArgsConstructor
public class MatchResultService {
    private final MatchResultRepository matchResultRepository;

    public MatchResult saveResult(MatchResultDto dto) {
        MatchResult result = MatchResult.builder()
                .winnerId(dto.getWinnerId())
                .loserId(dto.getLoserId())
                .problemId(dto.getProblemId())
                .durationSeconds(dto.getDurationSeconds())
                .eloDelta(dto.getEloDelta())
                .build();
        return matchResultRepository.save(result);
    }

    public List<MatchResult> getMatchHistory(String userId) {
        return matchResultRepository.findTop10ByWinnerIdOrLoserIdOrderByCreatedAtDesc(userId, userId);
    }
}
