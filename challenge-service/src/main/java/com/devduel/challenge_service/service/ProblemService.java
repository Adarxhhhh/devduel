package com.devduel.challenge_service.service;

import com.devduel.challenge_service.dto.*;
import com.devduel.challenge_service.entity.*;
import com.devduel.challenge_service.repository.*;
import lombok.RequiredArgsConstructor;
import org.springframework.http.HttpStatus;
import org.springframework.stereotype.Service;
import org.springframework.web.server.ResponseStatusException;

import java.util.ArrayList;
import java.util.List;
import java.util.UUID;

@Service
@RequiredArgsConstructor
public class ProblemService {
    private final ProblemRepository problemRepository;
    private final TestCaseRepository testCaseRepository;
    private final Judge0Service judge0Service;

    public List<ProblemDto> listProblems(String difficulty, String category) {
        List<Problem> problems;
        if (difficulty != null && !difficulty.isEmpty()) {
            problems = problemRepository.findByDifficulty(difficulty.toUpperCase());
        } else if (category != null && !category.isEmpty()) {
            problems = problemRepository.findByCategory(category);
        } else {
            problems = problemRepository.findAll();
        }
        return problems.stream().map(this::toDtoWithoutTestCases).toList();
    }

    public ProblemDto getProblem(UUID id) {
        Problem problem = problemRepository.findById(id)
                .orElseThrow(() -> new ResponseStatusException(HttpStatus.NOT_FOUND, "Problem not found"));
        return toDto(problem, false);
    }

    public ProblemDto getProblemBySlug(String slug) {
        Problem problem = problemRepository.findBySlug(slug)
                .orElseThrow(() -> new ResponseStatusException(HttpStatus.NOT_FOUND, "Problem not found"));
        return toDto(problem, false);
    }

    public ProblemDto getRandomProblem(String difficulty) {
        Problem problem;
        if (difficulty != null && !difficulty.isEmpty()) {
            problem = problemRepository.findRandomByDifficulty(difficulty.toUpperCase())
                    .orElseThrow(() -> new ResponseStatusException(HttpStatus.NOT_FOUND, "No problems found"));
        } else {
            problem = problemRepository.findRandom()
                    .orElseThrow(() -> new ResponseStatusException(HttpStatus.NOT_FOUND, "No problems found"));
        }
        return toDto(problem, false);
    }

    public SubmitResponse submitCode(UUID problemId, SubmitRequest request) {
        Problem problem = problemRepository.findById(problemId)
                .orElseThrow(() -> new ResponseStatusException(HttpStatus.NOT_FOUND, "Problem not found"));

        List<TestCase> testCases = testCaseRepository.findByProblemId(problemId);
        int languageId = Judge0Service.getLanguageId(request.getLanguage());

        List<SubmitResponse.TestResult> results = new ArrayList<>();
        int passed = 0;

        for (TestCase tc : testCases) {
            Judge0Service.ExecutionResult execResult = judge0Service.execute(
                    request.getCode(), languageId, tc.getInput());

            String actual = execResult.getStdout() != null ? execResult.getStdout().trim() : "";
            String expected = tc.getExpectedOutput().trim();
            boolean testPassed = actual.equals(expected);
            if (testPassed) passed++;

            SubmitResponse.TestResult.TestResultBuilder resultBuilder = SubmitResponse.TestResult.builder()
                    .testCaseId(tc.getId().toString())
                    .passed(testPassed)
                    .hidden(Boolean.TRUE.equals(tc.getIsHidden()));

            if (!Boolean.TRUE.equals(tc.getIsHidden())) {
                resultBuilder.input(tc.getInput())
                        .expectedOutput(expected)
                        .actualOutput(actual);
            }

            if (execResult.getError() != null && !execResult.getError().isEmpty()) {
                resultBuilder.error(execResult.getError());
            }

            results.add(resultBuilder.build());
        }

        return SubmitResponse.builder()
                .allPassed(passed == testCases.size())
                .totalTests(testCases.size())
                .passedTests(passed)
                .results(results)
                .build();
    }

    private ProblemDto toDtoWithoutTestCases(Problem p) {
        return ProblemDto.builder()
                .id(p.getId()).title(p.getTitle()).slug(p.getSlug())
                .description(p.getDescription()).difficulty(p.getDifficulty())
                .category(p.getCategory())
                .starterCodeJava(p.getStarterCodeJava())
                .starterCodePython(p.getStarterCodePython())
                .starterCodeJavascript(p.getStarterCodeJavascript())
                .build();
    }

    private ProblemDto toDto(Problem p, boolean includeHiddenAnswers) {
        List<TestCase> testCases = testCaseRepository.findByProblemId(p.getId());
        List<TestCaseDto> testCaseDtos = testCases.stream()
                .filter(tc -> !Boolean.TRUE.equals(tc.getIsHidden()))
                .map(tc -> TestCaseDto.builder()
                        .id(tc.getId())
                        .input(tc.getInput())
                        .expectedOutput(tc.getExpectedOutput())
                        .hidden(false)
                        .build())
                .toList();

        return ProblemDto.builder()
                .id(p.getId()).title(p.getTitle()).slug(p.getSlug())
                .description(p.getDescription()).difficulty(p.getDifficulty())
                .category(p.getCategory())
                .starterCodeJava(p.getStarterCodeJava())
                .starterCodePython(p.getStarterCodePython())
                .starterCodeJavascript(p.getStarterCodeJavascript())
                .testCases(testCaseDtos)
                .build();
    }
}
