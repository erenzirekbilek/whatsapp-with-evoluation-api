# Evidence: Evolution stack + Cloudflare Tunnel

## 2026-08-30 — files

**Command or action:** Added `infra/evolution` compose, env example, README; gitignore exception for `.env.example`.

**Result:** pass (repo artifacts)

**Notes:** Criteria 1–3 need Docker Desktop + Cloudflare token on the operator machine. Criterion 4: compose uses `127.0.0.1:8080:8080`. Criterion 5: gitignore exception present.
