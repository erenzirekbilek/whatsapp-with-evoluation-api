# Tasks: Evolution stack + Cloudflare Tunnel

- **Plan:** `docs/work/2026-08-30-evolution-cloudflare-tunnel/plan.md`

### Task 1: Compose and env template

**Files:** `infra/evolution/docker-compose.yml`, `infra/evolution/.env.example`, `.gitignore`

**Done when:** API port bind is localhost; cloudflared is profile `tunnel`; `.env.example` is not ignored.

- [x] Implement
- [x] Verify (files on disk; live Docker/CF needs operator token)

### Task 2: Runbook and ADR

**Files:** `infra/evolution/README.md`, `docs/decisions/0002-evolution-local-cloudflare.md`

**Done when:** CF origin is documented as `http://api:8080`.

- [x] Implement
- [x] Verify
