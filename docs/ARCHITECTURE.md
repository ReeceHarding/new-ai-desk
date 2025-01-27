# Smart CRM Architecture

## Overview
This is a multi-role CRM platform with integrated helpdesk, knowledge base, and smart outreach capabilities.

## Core Components

### Frontend (Next.js 13)
- App Router based architecture
- Server and Client Components
- Supabase Auth integration
- Real-time updates using Supabase subscriptions

### Backend (Node.js 18)
- Express.js REST API
- BullMQ for job processing
- Email automation system
- Web scraping capabilities

### Database (Supabase)
- PostgreSQL with RLS policies
- Real-time subscriptions
- Vector embeddings for AI features
- Full-text search capabilities

### Infrastructure
- Docker containerization
- Redis for job queues
- Supabase for managed database
- GitHub Actions for CI/CD

## Data Flow
1. User interactions trigger frontend actions
2. Server components handle data mutations
3. Background jobs process async tasks
4. Real-time updates reflect changes

## Security
- Row Level Security (RLS)
- JWT-based authentication
- Environment-based configuration
- Secure API endpoints 