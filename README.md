# AI Application Curation Platform

사내 AI 어플리케이션 큐레이션 플랫폼 - 간단한 어플리케이션을 공유하고 피드백을 받을 수 있는 플랫폼

## 기술 스택

- **Backend**: Spring Boot 3.2.x + Java 21
- **Frontend**: React + TypeScript
- **Database**: PostgreSQL
- **Build Tool**: Gradle 8.x
- **Deployment**: Docker

## 주요 기능

1. **어플리케이션 관리**
   - 어플리케이션 등록/수정/삭제
   - 커버 이미지 및 설명 등록
   - 접속 URL 관리

2. **피드백 기능**
   - 좋아요 기능
   - 댓글 작성 및 관리
   - 그리드 형식의 앱 큐레이션 페이지

## 프로젝트 구조

```
ai-playground/
├── backend/
│   ├── src/main/java/com/daou/aiplayground/
│   │   ├── entity/          # JPA 엔티티
│   │   ├── repository/      # JPA 리포지토리
│   │   ├── service/         # 비즈니스 로직
│   │   ├── controller/      # REST API 컨트롤러
│   │   └── dto/             # 데이터 전송 객체
│   ├── build.gradle
│   └── settings.gradle
├── frontend/
│   ├── src/
│   │   ├── api/        # API 클라이언트
│   │   ├── components/ # React 컴포넌트
│   │   ├── pages/      # 페이지 컴포넌트
│   │   └── types/      # TypeScript 타입
│   ├── Dockerfile
│   └── nginx.conf
├── Dockerfile          # Backend Dockerfile
└── docker-compose.yml
```

## 실행 방법

### 로컬 개발 환경 (IntelliJ)

#### 1. PostgreSQL 설정

**방법 1: 로컬 PostgreSQL 사용 (권장)**
```bash
# PostgreSQL 설치 (macOS)
brew install postgresql@16
brew services start postgresql@16

# 데이터베이스 및 사용자 설정
cd backend
./setup-local-db.sh
```

**방법 2: Docker로 PostgreSQL 실행**
```bash
docker run -d \
  --name ai-playground-db \
  -e POSTGRES_DB=ai_playground \
  -e POSTGRES_USER=postgres \
  -e POSTGRES_PASSWORD=postgres \
  -p 5432:5432 \
  postgres:16-alpine
```

#### 2. Backend 실행 (IntelliJ)

1. IntelliJ에서 `backend` 디렉토리 열기
2. Gradle 프로젝트로 인식될 때까지 대기
3. `AiPlaygroundApplication` 클래스를 찾아 실행
4. **Active profiles**를 `local`로 설정:
   - Run → Edit Configurations
   - Active profiles: `local` 입력

또는 터미널에서:
```bash
cd backend
./gradlew bootRun --args='--spring.profiles.active=local'
```

#### 3. Frontend 실행
```bash
cd frontend
npm install
npm start
```

### Docker Compose 실행

```bash
docker-compose up -d
```

- Frontend: http://localhost
- Backend API: http://localhost:8080
- PostgreSQL: localhost:5432

## API 엔드포인트

### Applications
- `GET /api/applications` - 모든 앱 조회
- `GET /api/applications/{id}` - 특정 앱 조회
- `POST /api/applications` - 앱 등록
- `PUT /api/applications/{id}` - 앱 수정
- `DELETE /api/applications/{id}` - 앱 삭제
- `POST /api/applications/{id}/like` - 좋아요
- `POST /api/applications/{id}/unlike` - 좋아요 취소

### Comments
- `GET /api/applications/{applicationId}/comments` - 댓글 조회
- `POST /api/applications/{applicationId}/comments` - 댓글 작성
- `PUT /api/applications/{commentId}/comments` - 댓글 수정
- `DELETE /api/applications/{commentId}/comments` - 댓글 삭제

## 환경 변수

### Backend (application.yml)
```yaml
spring.datasource.url=jdbc:postgresql://localhost:5432/ai_playground
spring.datasource.username=postgres
spring.datasource.password=postgres
```

### Frontend (.env)
```
REACT_APP_API_URL=http://localhost:8080/api
```
