#!/bin/bash

# 로컬 PostgreSQL 데이터베이스 설정 스크립트

echo "🚀 로컬 PostgreSQL 설정 시작..."

# PostgreSQL이 설치되어 있는지 확인
if ! command -v psql &> /dev/null; then
    echo "❌ PostgreSQL이 설치되어 있지 않습니다."
    echo "📦 설치 방법:"
    echo "   macOS: brew install postgresql@16"
    echo "   Ubuntu: sudo apt-get install postgresql-16"
    exit 1
fi

# PostgreSQL 서비스 상태 확인
if [[ "$OSTYPE" == "darwin"* ]]; then
    # macOS
    if ! brew services list | grep postgresql | grep started > /dev/null; then
        echo "🔄 PostgreSQL 서비스 시작 중..."
        brew services start postgresql@16
        sleep 2
    fi
else
    # Linux
    if ! systemctl is-active --quiet postgresql; then
        echo "🔄 PostgreSQL 서비스 시작 중..."
        sudo systemctl start postgresql
        sleep 2
    fi
fi

# 현재 사용자로 데이터베이스 생성
echo "📦 데이터베이스 및 사용자 생성 중..."

# superuser로 연결하여 데이터베이스 및 사용자 생성
psql -U $USER -d postgres -c "SELECT 1" > /dev/null 2>&1

if [ $? -eq 0 ]; then
    # 현재 사용자로 연결 가능한 경우
    psql -U $USER -d postgres << EOF
-- voicememo_user 생성 (없으면)
DO \$\$
BEGIN
    IF NOT EXISTS (SELECT FROM pg_catalog.pg_roles WHERE rolname = 'voicememo_user') THEN
        CREATE USER voicememo_user WITH PASSWORD 'voicememo_user';
    ELSE
        ALTER USER voicememo_user WITH PASSWORD 'voicememo_user';
    END IF;
END
\$\$;

-- 데이터베이스 생성 (없으면)
SELECT 'CREATE DATABASE ai_playground OWNER voicememo_user'
WHERE NOT EXISTS (SELECT FROM pg_database WHERE datname = 'ai_playground')\gexec

-- 권한 부여
GRANT ALL PRIVILEGES ON DATABASE ai_playground TO voicememo_user;
EOF

    # 스키마 권한 설정
    psql -U $USER -d ai_playground << EOF
GRANT ALL ON SCHEMA public TO voicememo_user;
GRANT ALL PRIVILEGES ON ALL TABLES IN SCHEMA public TO voicememo_user;
GRANT ALL PRIVILEGES ON ALL SEQUENCES IN SCHEMA public TO voicememo_user;
ALTER DEFAULT PRIVILEGES IN SCHEMA public GRANT ALL ON TABLES TO voicememo_user;
ALTER DEFAULT PRIVILEGES IN SCHEMA public GRANT ALL ON SEQUENCES TO voicememo_user;
EOF

    echo "✅ PostgreSQL 사용자 및 데이터베이스 설정 완료!"

    # 샘플 데이터 삽입 여부 확인
    read -p "📊 샘플 데이터를 삽입하시겠습니까? (y/n) " -n 1 -r
    echo
    if [[ $REPLY =~ ^[Yy]$ ]]; then
        echo "📝 샘플 데이터 삽입 중..."
        # Spring Boot가 테이블을 생성할 때까지 대기
        echo "⚠️  먼저 Spring Boot 애플리케이션을 한 번 실행하여 테이블을 생성해주세요."
        echo "   실행 후 다음 명령어로 샘플 데이터를 삽입하세요:"
        echo "   psql -U voicememo_user -d ai_playground -f init-sample-data.sql"
    fi
else
    echo "⚠️  직접 설정이 필요합니다. 다음 명령어를 실행하세요:"
    echo ""
    echo "psql -U postgres -f init-db.sql"
fi

echo ""
echo "📊 데이터베이스 연결 정보:"
echo "   Host: localhost"
echo "   Port: 5432"
echo "   Database: ai_playground"
echo "   Username: voicememo_user"
echo "   Password: voicememo_user"
echo ""
echo "🔗 연결 테스트:"
echo "   psql -U voicememo_user -d ai_playground"
