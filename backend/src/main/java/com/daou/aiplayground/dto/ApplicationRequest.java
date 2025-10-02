package com.daou.aiplayground.dto;

import jakarta.validation.constraints.NotBlank;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;

@Getter
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class ApplicationRequest {

    @NotBlank(message = "Application name is required")
    private String name;

    private String description;

    @NotBlank(message = "URL is required")
    private String url;

    private String coverImage;

    @NotBlank(message = "Creator is required")
    private String creator;
}
