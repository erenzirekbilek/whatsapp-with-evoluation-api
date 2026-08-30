# Spec: Evolution stack + Cloudflare Tunnel

- **Status:** in-progress
- **Date:** 2026-08-30
- **Owner:** repo
- **Work folder:** `docs/work/2026-08-30-evolution-cloudflare-tunnel/`

## Problem

The company sends WhatsApp from **staff numbers** to **customers**. n8n already runs on n8n Cloud. There is no VPS. Cloud n8n cannot call a process that only listens on this Windows PC.

## Goals

- Run Evolution API (Postgres + Redis) in Docker on this machine.
- Bind the API to localhost only.
- Expose the API to n8n Cloud through **Cloudflare Tunnel** (persistent hostname).
- Let staff connect WhatsApp via the local Evolution Manager (QR).

## Non-goals

- Custom company website / extra token product (later slice).
- Hosting n8n.
- Multi-tenant SaaS.
- Exposing Evolution Manager on the public internet.

## Users and context

Internal ops: start Docker, keep the PC/tunnel up. n8n authors: public URL + global `apikey`. Staff: scan QR once per line.

## Acceptance criteria

1. Given Docker Desktop is running and `.env` is filled, when `docker compose up -d api manager redis postgres` runs in `infra/evolution`, then API answers on `http://127.0.0.1:8080` and Manager on `http://127.0.0.1:3000`.
2. Given a Cloudflare tunnel token and public hostname pointing at `http://api:8080`, when `docker compose --profile tunnel up -d` runs, then n8n Cloud can reach `https://<hostname>` with header `apikey`.
3. Given a connected Evolution instance for a staff number, when n8n sends a text to a customer WhatsApp JID, then the message is sent from that staff WhatsApp.
4. API host port is `127.0.0.1:8080`, not `0.0.0.0:8080`.
5. `.env` is gitignored; `.env.example` is committed.

## Constraints

- Single company (this tenant only).
- Windows + Docker; machine must stay on for sending.
- Tunnel origin URL uses Docker DNS name `api` (compose service), not localhost (localhost inside cloudflared is the tunnel container).

## Open questions

- None for this slice. Cloudflare hostname is chosen by the operator.
