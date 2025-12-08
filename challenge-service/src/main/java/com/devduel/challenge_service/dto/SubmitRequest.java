package com.devduel.challenge_service.dto;

import jakarta.validation.constraints.NotBlank;
import lombok.*;

@Data @NoArgsConstructor @AllArgsConstructor
public class SubmitRequest {
    @NotBlank private String language;
    @NotBlank private String code;
}
