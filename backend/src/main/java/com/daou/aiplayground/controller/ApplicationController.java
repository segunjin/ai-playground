package com.daou.aiplayground.controller;

import com.daou.aiplayground.dto.ApplicationRequest;
import com.daou.aiplayground.dto.ApplicationResponse;
import com.daou.aiplayground.service.ApplicationService;
import jakarta.validation.Valid;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/api/applications")
@RequiredArgsConstructor
@CrossOrigin(origins = "*")
public class ApplicationController {

    private final ApplicationService applicationService;

    @GetMapping
    public ResponseEntity<List<ApplicationResponse>> getAllApplications() {
        return ResponseEntity.ok(applicationService.getAllApplications());
    }

    @GetMapping("/{id}")
    public ResponseEntity<ApplicationResponse> getApplication(@PathVariable Long id) {
        return ResponseEntity.ok(applicationService.getApplication(id));
    }

    @PostMapping
    public ResponseEntity<ApplicationResponse> createApplication(@Valid @RequestBody ApplicationRequest request) {
        return ResponseEntity.ok(applicationService.createApplication(request));
    }

    @PutMapping("/{id}")
    public ResponseEntity<ApplicationResponse> updateApplication(
            @PathVariable Long id,
            @Valid @RequestBody ApplicationRequest request) {
        return ResponseEntity.ok(applicationService.updateApplication(id, request));
    }

    @DeleteMapping("/{id}")
    public ResponseEntity<Void> deleteApplication(@PathVariable Long id) {
        applicationService.deleteApplication(id);
        return ResponseEntity.noContent().build();
    }

    @PostMapping("/{id}/like")
    public ResponseEntity<ApplicationResponse> likeApplication(@PathVariable Long id) {
        return ResponseEntity.ok(applicationService.likeApplication(id));
    }

    @PostMapping("/{id}/unlike")
    public ResponseEntity<ApplicationResponse> unlikeApplication(@PathVariable Long id) {
        return ResponseEntity.ok(applicationService.unlikeApplication(id));
    }
}
