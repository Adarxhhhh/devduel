package com.devduel.auth_service.dto;

import lombok.*;
import java.util.UUID;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class EloUpdateRequest {
    private UUID userId;
    private int eloDelta;
}
