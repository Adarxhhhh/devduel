package com.devduel.challenge_service.repository;

import com.devduel.challenge_service.entity.TestCase;
import org.springframework.data.jpa.repository.JpaRepository;
import java.util.List;
import java.util.UUID;

public interface TestCaseRepository extends JpaRepository<TestCase, UUID> {
    List<TestCase> findByProblemId(UUID problemId);
    List<TestCase> findByProblemIdAndIsHidden(UUID problemId, Boolean isHidden);
}
