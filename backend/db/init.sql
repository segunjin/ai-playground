-- PostgreSQL 초기화 스크립트
-- 로컬 개발 환경을 위한 사용자 및 데이터베이스 생성

-- 사용자 생성 (이미 존재하면 무시)
DO
$$
BEGIN
    IF NOT EXISTS (SELECT FROM pg_catalog.pg_roles WHERE rolname = 'postgres') THEN
        CREATE USER postgres WITH PASSWORD 'postgres';
    END IF;
END
$$;

-- 데이터베이스 생성 (이미 존재하면 무시)
SELECT 'CREATE DATABASE ai_playground'
WHERE NOT EXISTS (SELECT FROM pg_database WHERE datname = 'ai_playground')\gexec

-- 권한 부여
ALTER USER postgres WITH SUPERUSER;
GRANT ALL PRIVILEGES ON DATABASE ai_playground TO postgres;

-- 연결 후 스키마 권한 설정
\c ai_playground
GRANT ALL ON SCHEMA public TO postgres;
GRANT ALL PRIVILEGES ON ALL TABLES IN SCHEMA public TO postgres;
GRANT ALL PRIVILEGES ON ALL SEQUENCES IN SCHEMA public TO postgres;

-- 기본 권한 설정 (향후 생성될 객체에 대해)
ALTER DEFAULT PRIVILEGES IN SCHEMA public GRANT ALL ON TABLES TO postgres;
ALTER DEFAULT PRIVILEGES IN SCHEMA public GRANT ALL ON SEQUENCES TO postgres;
