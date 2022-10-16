package ru.make.racing.game.auth.web.dto;

import lombok.Data;

import java.time.OffsetDateTime;
import java.util.UUID;

@Data
public class GameUserDto {
    private UUID id;
    private OffsetDateTime creationDt;
}
