# PromptForge Deployment Guide

## 1) Backend (Vapor) Deployment

### Infrastructure
- Runtime: Swift 5.9 container
- Database: Managed PostgreSQL 14+
- Secrets: `DATABASE_URL`, `JWT_SECRET`, `OPENAI_API_KEY`
- Reverse proxy: Nginx/Cloud LB with TLS

### Build + Run
```bash
cd backend/PromptForgeServer
swift build -c release
swift run -c release Run
```

### Production Hardening
- Replace in-memory rate limiter with Redis-backed distributed limiter.
- Replace placeholder `LLMService` with OpenAI Responses API client.
- Enable structured logging and trace IDs.
- Add DB connection pool tuning and health checks.

## 2) iOS App Deployment

### Build
- Xcode 15+
- iOS 17 deployment target recommended
- Ensure dark mode default and accessibility checks

### App Store
- Configure StoreKit products:
  - `com.promptforge.pro`
  - `com.promptforge.research`
- Implement App Store Server Notification webhook on backend.

## 3) CI/CD

### Backend pipeline
1. `swift test`
2. `swift build -c release`
3. Containerize and deploy

### iOS pipeline
1. `xcodebuild test`
2. static analysis
3. TestFlight upload

## 4) Future Web Frontend
- Keep all business logic server-side in Vapor.
- Expose typed JSON contracts from DTOs.
- Add OAuth SSO + org workspaces for enterprise.
