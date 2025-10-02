-- PostgreSQL 초기 데이터베이스 및 사용자 생성 스크립트
-- 실행: psql -U postgres -f init-db.sql

-- 데이터베이스 생성
DROP DATABASE IF EXISTS ai_playground;
CREATE DATABASE ai_playground;

-- 사용자 생성
DROP USER IF EXISTS voicememo_user;
CREATE USER voicememo_user WITH PASSWORD 'voicememo_user';

-- 권한 부여
ALTER DATABASE ai_playground OWNER TO voicememo_user;
GRANT ALL PRIVILEGES ON DATABASE ai_playground TO voicememo_user;

-- 데이터베이스 연결
\c ai_playground

-- 스키마 권한 설정
GRANT ALL ON SCHEMA public TO voicememo_user;
GRANT ALL PRIVILEGES ON ALL TABLES IN SCHEMA public TO voicememo_user;
GRANT ALL PRIVILEGES ON ALL SEQUENCES IN SCHEMA public TO voicememo_user;

-- 기본 권한 설정 (향후 생성될 객체)
ALTER DEFAULT PRIVILEGES IN SCHEMA public GRANT ALL ON TABLES TO voicememo_user;
ALTER DEFAULT PRIVILEGES IN SCHEMA public GRANT ALL ON SEQUENCES TO voicememo_user;

\echo '✅ 데이터베이스 및 사용자 생성 완료!'
\echo '📊 연결 정보:'
\echo '   Database: ai_playground'
\echo '   Username: voicememo_user'
\echo '   Password: voicememo_user'
\echo '   Host: localhost'
\echo '   Port: 5432'
