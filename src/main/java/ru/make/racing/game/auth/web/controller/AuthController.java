package ru.make.racing.game.auth.web.controller;

import io.swagger.v3.oas.annotations.tags.Tag;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;
import ru.make.racing.game.auth.web.dto.GameUserDto;

@Tag(name = "Auth controller")
@RestController("/auth")
public class AuthController {
    @GetMapping("/user")
    public GameUserDto getUser() {
        return new GameUserDto();
    }
}
