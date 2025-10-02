# GitHub Workflow: Branch → Issue → Commit → PR

## 1️⃣ 브랜치 생성 & 이동
```bash
# 원격 main 브랜치 최신화
git pull origin main

# 새로운 브랜치 생성 및 체크아웃
git checkout -b feature/issue-123-fix-login
```
- 브랜치 네이밍 규칙 (권장)
  - 기능 추가: `feature/<이름>`
  - 버그 수정: `fix/<이름>`
  - 실험/테스트: `experiment/<이름>`

---

## 2️⃣ 이슈 수정
- IDE (IntelliJ, VSCode 등)에서 코드 수정
- Claude Code를 활용해 리팩토링/코드 개선/자동 생성
- 예: `LoginController.java` 수정

---

## 3️⃣ 변경 사항 확인 & 스테이징
```bash
# 변경된 파일 목록 확인
git status

# 특정 파일 스테이징
git add src/main/java/com/example/LoginController.java

# 모든 변경 사항 스테이징
git add .
```

---

## 4️⃣ 커밋
```bash
git commit -m "fix: 로그인 인증 오류 수정 (issue #123)"
```
- 커밋 메시지 컨벤션 (권장)
  - `feat`: 새로운 기능
  - `fix`: 버그 수정
  - `docs`: 문서 수정
  - `refactor`: 코드 리팩토링
  - `test`: 테스트 코드 추가

---

## 5️⃣ 원격 브랜치로 푸시
```bash
git push -u origin feature/issue-123-fix-login
```

---

## 6️⃣ Pull Request 생성
1. GitHub 저장소 접속
2. `feature/issue-123-fix-login` → `main` Pull Request(PR) 생성
3. 코드 리뷰 & Merge

---

## 🚀 전체 Workflow 요약
1. `git checkout -b 브랜치명` → 새 브랜치 생성
2. 코드 수정 (Claude Code + IDE)
3. `git add . && git commit -m "메시지"`
4. `git push origin 브랜치명`
5. GitHub에서 Pull Request 생성 → 리뷰 → Merge
