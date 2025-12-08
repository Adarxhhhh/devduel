package com.devduel.challenge_service.repository;

import com.devduel.challenge_service.entity.Problem;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import java.util.List;
import java.util.Optional;
import java.util.UUID;

public interface ProblemRepository extends JpaRepository<Problem, UUID> {
    List<Problem> findByDifficulty(String difficulty);
    Optional<Problem> findBySlug(String slug);

    @Query(value = "SELECT * FROM problems WHERE difficulty = :difficulty ORDER BY RANDOM() LIMIT 1", nativeQuery = true)
    Optional<Problem> findRandomByDifficulty(String difficulty);

    @Query(value = "SELECT * FROM problems ORDER BY RANDOM() LIMIT 1", nativeQuery = true)
    Optional<Problem> findRandom();

    List<Problem> findByCategory(String category);
}
