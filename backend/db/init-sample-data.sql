-- 샘플 데이터 삽입 스크립트
-- 실행: psql -U voicememo_user -d ai_playground -f init-sample-data.sql

-- 기존 데이터 삭제 (개발 환경용)
TRUNCATE TABLE comments RESTART IDENTITY CASCADE;
TRUNCATE TABLE applications RESTART IDENTITY CASCADE;

-- 샘플 애플리케이션 데이터
INSERT INTO applications (name, description, url, cover_image, creator, like_count, created_at, updated_at) VALUES
('AI 이미지 생성기', 'Stable Diffusion을 활용한 이미지 생성 도구입니다. 텍스트만 입력하면 원하는 이미지를 만들어줍니다.',
 'https://example.com/ai-image-generator',
 'https://images.unsplash.com/photo-1686191128892-c3cf68c863f5?w=400',
 '김철수', 15, NOW() - INTERVAL '5 days', NOW() - INTERVAL '5 days'),

('챗봇 어시스턴트', '업무 자동화를 위한 AI 챗봇입니다. 간단한 질문에 답변하고 일정을 관리해줍니다.',
 'https://example.com/chatbot-assistant',
 'https://images.unsplash.com/photo-1677442136019-21780ecad995?w=400',
 '이영희', 23, NOW() - INTERVAL '4 days', NOW() - INTERVAL '4 days'),

('음성 텍스트 변환', '회의록 작성을 자동화하는 STT(Speech-to-Text) 애플리케이션입니다.',
 'https://example.com/voice-to-text',
 'https://images.unsplash.com/photo-1589254065878-42c9da997008?w=400',
 '박민수', 18, NOW() - INTERVAL '3 days', NOW() - INTERVAL '3 days'),

('문서 요약 도구', '긴 문서를 AI가 자동으로 요약해주는 도구입니다. PDF, Word 파일 지원.',
 'https://example.com/doc-summarizer',
 'https://images.unsplash.com/photo-1633613286991-611fe299c4be?w=400',
 '최지영', 31, NOW() - INTERVAL '2 days', NOW() - INTERVAL '2 days'),

('코드 리뷰 봇', 'GitHub PR을 자동으로 리뷰하고 개선사항을 제안하는 AI 봇입니다.',
 'https://example.com/code-review-bot',
 'https://images.unsplash.com/photo-1555066931-4365d14bab8c?w=400',
 '정현우', 27, NOW() - INTERVAL '1 day', NOW() - INTERVAL '1 day'),

('번역 도구', '실시간으로 여러 언어를 번역해주는 AI 번역기입니다. 20개 언어 지원.',
 'https://example.com/translator',
 'https://images.unsplash.com/photo-1526925712774-79dc1c0b1d5e?w=400',
 '강서연', 42, NOW() - INTERVAL '12 hours', NOW() - INTERVAL '12 hours');

-- 샘플 댓글 데이터
INSERT INTO comments (application_id, author, content, created_at, updated_at) VALUES
-- AI 이미지 생성기 댓글
(1, '이민지', '정말 유용한 도구네요! 마케팅 자료 만들 때 많이 활용하고 있습니다.', NOW() - INTERVAL '4 days', NOW() - INTERVAL '4 days'),
(1, '김태현', '이미지 퀄리티가 생각보다 좋네요. 프롬프트 작성 가이드도 있으면 좋겠어요.', NOW() - INTERVAL '3 days', NOW() - INTERVAL '3 days'),
(1, '박소희', '속도가 빠르고 사용하기 편해요!', NOW() - INTERVAL '2 days', NOW() - INTERVAL '2 days'),

-- 챗봇 어시스턴트 댓글
(2, '정우진', '고객 응대에 활용하고 있는데 만족도가 높습니다.', NOW() - INTERVAL '3 days', NOW() - INTERVAL '3 days'),
(2, '최유나', '자연스러운 대화가 가능해서 놀랐어요. 커스터마이징 기능도 추가되면 좋겠습니다.', NOW() - INTERVAL '2 days', NOW() - INTERVAL '2 days'),

-- 음성 텍스트 변환 댓글
(3, '김민석', '회의록 작성 시간이 절반으로 줄었어요!', NOW() - INTERVAL '2 days', NOW() - INTERVAL '2 days'),
(3, '이수진', '한국어 인식률이 정말 좋네요. 방언도 잘 인식하나요?', NOW() - INTERVAL '1 day', NOW() - INTERVAL '1 day'),

-- 문서 요약 도구 댓글
(4, '박준영', '논문 읽을 때 유용하게 쓰고 있습니다. 감사합니다!', NOW() - INTERVAL '1 day', NOW() - INTERVAL '1 day'),
(4, '강혜진', '요약 품질이 훌륭해요. 핵심만 잘 뽑아주네요.', NOW() - INTERVAL '12 hours', NOW() - INTERVAL '12 hours'),
(4, '윤서준', '영어 문서도 지원하나요?', NOW() - INTERVAL '6 hours', NOW() - INTERVAL '6 hours'),

-- 코드 리뷰 봇 댓글
(5, '조민호', '코드 리뷰 품질이 사람보다 나은 것 같아요 ㅎㅎ', NOW() - INTERVAL '18 hours', NOW() - INTERVAL '18 hours'),
(5, '한지원', '보안 취약점도 잘 찾아주네요!', NOW() - INTERVAL '12 hours', NOW() - INTERVAL '12 hours'),

-- 번역 도구 댓글
(6, '임도현', '실시간 번역이 정말 빠르고 정확해요!', NOW() - INTERVAL '10 hours', NOW() - INTERVAL '10 hours'),
(6, '신예은', '해외 업체와 소통할 때 유용하게 쓰고 있습니다.', NOW() - INTERVAL '8 hours', NOW() - INTERVAL '8 hours'),
(6, '오재혁', '일본어 번역 퀄리티가 특히 좋네요.', NOW() - INTERVAL '4 hours', NOW() - INTERVAL '4 hours');

\echo '✅ 샘플 데이터 삽입 완료!'
\echo '📊 삽입된 데이터:'
\echo '   - 애플리케이션: 6개'
\echo '   - 댓글: 14개'

-- 데이터 확인
SELECT
    a.id,
    a.name,
    a.creator,
    a.like_count,
    COUNT(c.id) as comment_count
FROM applications a
LEFT JOIN comments c ON a.id = c.application_id
GROUP BY a.id, a.name, a.creator, a.like_count
ORDER BY a.id;
