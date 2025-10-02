package com.daou.aiplayground.service;

import com.daou.aiplayground.dto.CommentRequest;
import com.daou.aiplayground.dto.CommentResponse;
import org.springframework.stereotype.Service;

import java.time.LocalDateTime;
import java.util.*;
import java.util.concurrent.ConcurrentHashMap;
import java.util.concurrent.atomic.AtomicLong;
import java.util.stream.Collectors;

@Service
public class CommentService {

    private final Map<Long, CommentResponse> commentStore = new ConcurrentHashMap<>();
    private final AtomicLong idGenerator = new AtomicLong(1);

    public List<CommentResponse> getComments(Long applicationId) {
        return commentStore.values().stream()
                .filter(comment -> comment.getApplicationId().equals(applicationId))
                .sorted(Comparator.comparing(CommentResponse::getCreatedAt).reversed())
                .collect(Collectors.toList());
    }

    public CommentResponse createComment(Long applicationId, CommentRequest request) {
        Long newId = idGenerator.getAndIncrement();
        LocalDateTime now = LocalDateTime.now();

        CommentResponse newComment = CommentResponse.builder()
                .id(newId)
                .applicationId(applicationId)
                .author(request.getAuthor())
                .content(request.getContent())
                .createdAt(now)
                .updatedAt(now)
                .build();

        commentStore.put(newId, newComment);
        return newComment;
    }

    public CommentResponse updateComment(Long commentId, CommentRequest request) {
        CommentResponse existing = commentStore.get(commentId);
        if (existing == null) {
            throw new RuntimeException("Comment not found");
        }

        CommentResponse updated = CommentResponse.builder()
                .id(existing.getId())
                .applicationId(existing.getApplicationId())
                .author(existing.getAuthor())
                .content(request.getContent())
                .createdAt(existing.getCreatedAt())
                .updatedAt(LocalDateTime.now())
                .build();

        commentStore.put(commentId, updated);
        return updated;
    }

    public void deleteComment(Long commentId) {
        CommentResponse removed = commentStore.remove(commentId);
        if (removed == null) {
            throw new RuntimeException("Comment not found");
        }
    }
}
