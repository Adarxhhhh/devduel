package com.devduel.challenge_service.entity;

import jakarta.persistence.*;
import lombok.*;
import java.time.LocalDateTime;
import java.util.UUID;

@Entity
@Table(name = "match_results")
@Data @NoArgsConstructor @AllArgsConstructor @Builder
public class MatchResult {
    @Id @GeneratedValue(strategy = GenerationType.UUID)
    private UUID id;

    @Column(name = "winner_id", nullable = false)
    private String winnerId;

    @Column(name = "loser_id", nullable = false)
    private String loserId;

    @Column(name = "problem_id", nullable = false)
    private UUID problemId;

    @Column(name = "duration_seconds", nullable = false)
    private Integer durationSeconds;

    @Column(name = "elo_delta", nullable = false)
    private Integer eloDelta;

    @Column(name = "created_at", updatable = false)
    private LocalDateTime createdAt;

    @PrePersist
    public void prePersist() { this.createdAt = LocalDateTime.now(); }
}
