# Smart CRM & Outreach Monorepo

This repository houses the entire codebase for a multi-role CRM, helpdesk, marketing, and smart outreach platform.

## Project Structure

- `infrastructure/`: Supabase migrations and scripts
- `backend/`: Node 18 concurrency worker tasks (scraping, emailing)
- `frontend/`: Next.js 13 React application
- `docker-compose.yml`: Orchestrates multi-service dev environment

## Getting Started

1. Clone the repository
2. Copy `.env.example` to `.env` and fill in your values
3. Run `yarn install` to install dependencies
4. Start the development environment with `docker-compose up`

## Development

- Frontend: http://localhost:3000
- Backend Worker: http://localhost:4000
- Supabase: Managed cloud instance

## License

MIT License - see LICENSE file for details 