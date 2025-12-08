package com.devduel.challenge_service.repository;

import com.devduel.challenge_service.entity.MatchResult;
import org.springframework.data.jpa.repository.JpaRepository;
import java.util.List;
import java.util.UUID;

public interface MatchResultRepository extends JpaRepository<MatchResult, UUID> {
    List<MatchResult> findByWinnerIdOrLoserIdOrderByCreatedAtDesc(String winnerId, String loserId);
    List<MatchResult> findTop10ByWinnerIdOrLoserIdOrderByCreatedAtDesc(String winnerId, String loserId);
}
