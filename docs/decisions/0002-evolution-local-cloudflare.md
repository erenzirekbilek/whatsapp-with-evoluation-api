# ADR 0002: Evolution on this PC + Cloudflare Tunnel

- **Status:** accepted
- **Date:** 2026-08-30

## Context

n8n is on n8n Cloud. There is no VPS. Staff WhatsApp lines must send via Evolution API.

## Decision

Run Evolution (API, Manager, Postgres, Redis) with Docker on the Windows machine. Publish the API with Cloudflare Tunnel. Keep Manager and API host ports on `127.0.0.1`. Custom company web app is a later slice; n8n uses Evolution’s global `apikey` and instance names.

## Consequences

- The PC must stay awake with Docker and the tunnel running.
- The operator must own a Cloudflare domain and paste a tunnel token.
- A later VPS move can reuse the same compose; only DNS and `SERVER_URL` change.
