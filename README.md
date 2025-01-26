# Smart Outreach

This repository contains a single-admin outreach automation platform using Node.js, Next.js, Supabase, Redis, Selenium, Pinecone, and GPT.

## Project Structure
- `backend/` - Node.js + TypeScript backend services
- `frontend/` - Next.js + TypeScript frontend application
- `scripts/` - Database migrations and development utilities
- `docker-compose.yml` - Local development services (Redis, Selenium)

## Setup Steps
1. Environment Setup
2. Single-Admin Auth
3. Knowledge Base Integration
4. Campaign Management
5. Email Automation
6. Analytics Dashboard
7. Lead Generation
8. GPT Integration
9. Security & Compliance
10. Production Deployment

## Local Development
1. Copy `.env.example` to `.env` and fill in required values
2. Run `docker-compose up -d` to start Redis and Selenium
3. Run database migrations: `bash scripts/migrate-supabase-schema.sh`
4. Start backend: `cd backend && npm run dev`
5. Start frontend: `cd frontend && npm run dev` 