# Plan: Evolution stack + Cloudflare Tunnel

- **Spec:** `docs/work/2026-08-30-evolution-cloudflare-tunnel/spec.md`
- **Status:** in-progress

## Architecture

Compose stack: Postgres, Redis, Evolution API, local Manager, optional `cloudflared` profile. n8n Cloud → Cloudflare edge → tunnel sidecar → `http://api:8080`. Staff QR stays on localhost Manager.

## Files

| Path | Action | Responsibility |
|------|--------|----------------|
| `infra/evolution/docker-compose.yml` | create | Services and localhost binds |
| `infra/evolution/.env.example` | create | Required secrets and SERVER_URL |
| `infra/evolution/README.md` | create | Operator steps (CF dashboard + n8n) |
| `.gitignore` | modify | Keep `.env.example` committable |
| `docs/decisions/0002-evolution-local-cloudflare.md` | create | Why local + tunnel, not VPS |

## Risks

- Operator never creates the CF hostname / token → n8n cannot connect (documented, not automatable without their account).
- `SERVER_URL` left as localhost → webhooks/QR callbacks wrong.
- PC sleep → sessions drop.

## Order

1. Compose + env example + gitignore
2. Operator runbook
3. ADR

## Out of this plan

Custom token portal; n8n workflow JSON.
