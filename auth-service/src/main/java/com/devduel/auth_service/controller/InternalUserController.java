package com.devduel.auth_service.controller;

import com.devduel.auth_service.dto.EloUpdateRequest;
import com.devduel.auth_service.dto.UserDto;
import com.devduel.auth_service.entity.User;
import com.devduel.auth_service.repository.UserRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.UUID;

@RestController
@RequestMapping("/internal")
@RequiredArgsConstructor
public class InternalUserController {
    private final UserRepository userRepository;

    @GetMapping("/users/{id}")
    public ResponseEntity<UserDto> getUser(@PathVariable UUID id) {
        return userRepository.findById(id)
                .map(u -> ResponseEntity.ok(UserDto.builder()
                        .id(u.getId()).username(u.getUsername())
                        .email(u.getEmail()).elo(u.getElo()).build()))
                .orElse(ResponseEntity.notFound().build());
    }

    @PostMapping("/users/elo")
    public ResponseEntity<Void> updateElo(@RequestBody EloUpdateRequest request) {
        User user = userRepository.findById(request.getUserId()).orElse(null);
        if (user == null) return ResponseEntity.notFound().build();
        user.setElo(user.getElo() + request.getEloDelta());
        userRepository.save(user);
        return ResponseEntity.ok().build();
    }

    @GetMapping("/users/top")
    public ResponseEntity<?> getTopUsers(@RequestParam(defaultValue = "20") int limit) {
        var users = userRepository.findAll().stream()
                .sorted((a, b) -> Integer.compare(b.getElo(), a.getElo()))
                .limit(limit)
                .map(u -> UserDto.builder().id(u.getId()).username(u.getUsername())
                        .email(u.getEmail()).elo(u.getElo()).build())
                .toList();
        return ResponseEntity.ok(users);
    }
}
