package com.daou.aiplayground.service;

import com.daou.aiplayground.dto.ApplicationRequest;
import com.daou.aiplayground.dto.ApplicationResponse;
import jakarta.annotation.PostConstruct;
import org.springframework.stereotype.Service;

import java.time.LocalDateTime;
import java.util.*;
import java.util.concurrent.ConcurrentHashMap;
import java.util.concurrent.atomic.AtomicLong;
import java.util.stream.Collectors;

@Service
public class ApplicationService {

    private final Map<Long, ApplicationResponse> applicationStore = new ConcurrentHashMap<>();
    private final AtomicLong idGenerator = new AtomicLong(1);

    @PostConstruct
    public void init() {
        // 목 데이터 초기화
        createMockData();
    }

    private void createMockData() {
        LocalDateTime now = LocalDateTime.now();

        applicationStore.put(1L, ApplicationResponse.builder()
                .id(1L)
                .name("AI 챗봇 빌더")
                .description("코드 없이 나만의 AI 챗봇을 만들어보세요. 간단한 설정만으로 고객 상담, FAQ 자동 응답 등 다양한 용도로 활용할 수 있습니다.")
                .url("https://example.com/chatbot")
                .coverImage("https://picsum.photos/seed/chatbot/400/300")
                .creator("김개발")
                .likeCount(42)
                .commentCount(8)
                .createdAt(now.minusDays(5))
                .updatedAt(now.minusDays(5))
                .build());

        applicationStore.put(2L, ApplicationResponse.builder()
                .id(2L)
                .name("이미지 생성기")
                .description("텍스트 설명만으로 원하는 이미지를 생성합니다. DALL-E와 Stable Diffusion을 활용한 고품질 이미지 생성 도구입니다.")
                .url("https://example.com/image-gen")
                .coverImage("https://picsum.photos/seed/imagegen/400/300")
                .creator("박디자인")
                .likeCount(89)
                .commentCount(15)
                .createdAt(now.minusDays(3))
                .updatedAt(now.minusDays(3))
                .build());

        applicationStore.put(3L, ApplicationResponse.builder()
                .id(3L)
                .name("스마트 번역기")
                .description("AI 기반 실시간 다국어 번역 서비스. 문맥을 이해하고 자연스러운 번역을 제공합니다. 50개 이상의 언어를 지원합니다.")
                .url("https://example.com/translator")
                .coverImage("https://picsum.photos/seed/translator/400/300")
                .creator("이언어")
                .likeCount(67)
                .commentCount(12)
                .createdAt(now.minusDays(7))
                .updatedAt(now.minusDays(7))
                .build());

        applicationStore.put(4L, ApplicationResponse.builder()
                .id(4L)
                .name("코드 리뷰 도우미")
                .description("AI가 당신의 코드를 분석하고 개선점을 제안합니다. 버그 탐지, 성능 최적화, 코드 스타일 개선을 지원합니다.")
                .url("https://example.com/code-review")
                .coverImage("https://picsum.photos/seed/codereview/400/300")
                .creator("최코딩")
                .likeCount(134)
                .commentCount(23)
                .createdAt(now.minusDays(2))
                .updatedAt(now.minusDays(2))
                .build());

        applicationStore.put(5L, ApplicationResponse.builder()
                .id(5L)
                .name("문서 요약기")
                .description("긴 문서를 몇 초 만에 핵심 내용으로 요약합니다. PDF, Word, 웹 페이지 등 다양한 형식을 지원합니다.")
                .url("https://example.com/summarizer")
                .coverImage("https://picsum.photos/seed/summarizer/400/300")
                .creator("정문서")
                .likeCount(56)
                .commentCount(9)
                .createdAt(now.minusDays(4))
                .updatedAt(now.minusDays(4))
                .build());

        idGenerator.set(6L);
    }

    public List<ApplicationResponse> getAllApplications() {
        return applicationStore.values().stream()
                .sorted(Comparator.comparing(ApplicationResponse::getCreatedAt).reversed())
                .collect(Collectors.toList());
    }

    public ApplicationResponse getApplication(Long id) {
        ApplicationResponse app = applicationStore.get(id);
        if (app == null) {
            throw new RuntimeException("Application not found");
        }
        return app;
    }

    public ApplicationResponse createApplication(ApplicationRequest request) {
        Long newId = idGenerator.getAndIncrement();
        LocalDateTime now = LocalDateTime.now();

        ApplicationResponse newApp = ApplicationResponse.builder()
                .id(newId)
                .name(request.getName())
                .description(request.getDescription())
                .url(request.getUrl())
                .coverImage(request.getCoverImage())
                .creator(request.getCreator())
                .likeCount(0)
                .commentCount(0)
                .createdAt(now)
                .updatedAt(now)
                .build();

        applicationStore.put(newId, newApp);
        return newApp;
    }

    public ApplicationResponse updateApplication(Long id, ApplicationRequest request) {
        ApplicationResponse existing = applicationStore.get(id);
        if (existing == null) {
            throw new RuntimeException("Application not found");
        }

        ApplicationResponse updated = ApplicationResponse.builder()
                .id(existing.getId())
                .name(request.getName())
                .description(request.getDescription())
                .url(request.getUrl())
                .coverImage(request.getCoverImage())
                .creator(existing.getCreator())
                .likeCount(existing.getLikeCount())
                .commentCount(existing.getCommentCount())
                .createdAt(existing.getCreatedAt())
                .updatedAt(LocalDateTime.now())
                .build();

        applicationStore.put(id, updated);
        return updated;
    }

    public void deleteApplication(Long id) {
        ApplicationResponse removed = applicationStore.remove(id);
        if (removed == null) {
            throw new RuntimeException("Application not found");
        }
    }

    public ApplicationResponse likeApplication(Long id) {
        ApplicationResponse existing = applicationStore.get(id);
        if (existing == null) {
            throw new RuntimeException("Application not found");
        }

        ApplicationResponse updated = ApplicationResponse.builder()
                .id(existing.getId())
                .name(existing.getName())
                .description(existing.getDescription())
                .url(existing.getUrl())
                .coverImage(existing.getCoverImage())
                .creator(existing.getCreator())
                .likeCount(existing.getLikeCount() + 1)
                .commentCount(existing.getCommentCount())
                .createdAt(existing.getCreatedAt())
                .updatedAt(existing.getUpdatedAt())
                .build();

        applicationStore.put(id, updated);
        return updated;
    }

    public ApplicationResponse unlikeApplication(Long id) {
        ApplicationResponse existing = applicationStore.get(id);
        if (existing == null) {
            throw new RuntimeException("Application not found");
        }

        int newLikeCount = Math.max(0, existing.getLikeCount() - 1);

        ApplicationResponse updated = ApplicationResponse.builder()
                .id(existing.getId())
                .name(existing.getName())
                .description(existing.getDescription())
                .url(existing.getUrl())
                .coverImage(existing.getCoverImage())
                .creator(existing.getCreator())
                .likeCount(newLikeCount)
                .commentCount(existing.getCommentCount())
                .createdAt(existing.getCreatedAt())
                .updatedAt(existing.getUpdatedAt())
                .build();

        applicationStore.put(id, updated);
        return updated;
    }
}
