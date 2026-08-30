# Evolution (Docker)

**Geliştirici / laptop:** bu dosya. **Şirket VPS + domain + n8n:** [docs/kurumsal-klavuz.md](../../docs/kurumsal-klavuz.md) — `host.docker.internal` yerine `http://api:8080`.

This compose is only Evolution (API, Postgres, Redis). Local n8n often stays in a separate `n8n_container` on port 5678.

## Start Evolution

```powershell
cd D:\software-projects\sales-whatsapp-n8n\infra\evolution
docker compose up -d api redis postgres
```

- Evolution panel: http://127.0.0.1:8080/manager
- n8n (already yours): http://127.0.0.1:5678

## Staff WhatsApp

Manager → `AUTHENTICATION_API_KEY` from `.env` → instance + QR.

## n8n → WhatsApp

Your n8n is a Docker container. **Do not** use `http://127.0.0.1:8080` in the HTTP Request node (that is n8n itself).

Use:

- POST `http://host.docker.internal:8080/message/sendText/ahmet`
- Header `apikey` = `.env` key
- Body `{"number":"905XXXXXXXXX","text":"test"}`

`ahmet` = Evolution instance name.

## Optional tunnel

Only if the public internet must reach Evolution: `docker compose --profile tunnel up -d`
