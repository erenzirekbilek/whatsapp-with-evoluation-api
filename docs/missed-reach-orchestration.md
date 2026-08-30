# Ulaşılamadı → satışçı WhatsApp’ı (n8n orchestrator)

Bu, şirkete anlatılan **hedef ürün** metnidir. Local Docker + tek `sendText` denemesi yalnızca “bu hattın WhatsApp’ından mesaj gider” kanıtıydı.

## Ne işe yarar

Satışçı müşteriyi arar, **ulaşılamaz** (açılmaz, meşgul, vs.). n8n bu olayı alır ve **o satışçının kendi WhatsApp hesabından** otomatik bir mesaj atar. Müşteri sohbette o satışçının numarasını görür; başka birinin hattından gitmez.

n8n **orchestrator**’dır. İçeride kayıtlı, **birbirinden ayrı** send-message hatları vardır (örnek: 10 satışçı = 10 ayrı gönderim). Karışık hat / yanlış kimlik olmasın diye her satışçı kendi Evolution instance’ına bağlıdır.

## Akış

1. Dış sistem “arandı, ulaşılamadı” der (CRM, santral veya form — tetik henüz bağlanmadı).
2. n8n `salespersonId` ile **hangi satışçı** olduğunu çözer.
3. Sadece o satışçının send-message dalı çalışır.
4. Evolution, o satışçının açık WhatsApp oturumundan `sendText` yapar.
5. Müşteri mesajı alır.

n8n metni ve alıcıyı bilir. Evolution oturumu açık tutar ve iletir.

## Örnek n8n workflow

Dosya: `infra/evolution/workflows/missed-reach-orchestrator.json`

- Tetik: Webhook `POST /webhook/missed-reach` (import sonrası n8n’in verdiği tam URL).
- İki örnek dal: `eren` → instance `Eren-Number`, `mehmet` → `Mehmet` (ikincisini kendi instance adınla değiştir; 10 satışçı için dal kopyala).
- Auth: Header Auth, header adı `apikey` (değer JSON’da yok). Credential adı: `Evolution API`.
- Evolution’a n8n Docker’dan: `http://host.docker.internal:8080`.

Gövde örneği:

```json
{
  "salespersonId": "eren",
  "customerNumber": "905XXXXXXXXXX",
  "message": "Sizi aradik, ulasamadik. Musait oldugunuzda doner misiniz?"
}
```

`message` yoksa varsayılan ulaşılamadı metni kullanılır. Bilinmeyen `salespersonId` → 400. Evolution hatası → 502.

## Üretim (kurumsal)

Şirketler **kendi VPS + domain + n8n** ile entegre kurar; dizüstü Docker production değildir. Adımlar, ağ (`api:8080` vs `host.docker.internal`), TLS ve güvenlik: [kurumsal-klavuz.md](kurumsal-klavuz.md).

Tek şirket (tek tenant). Müşteri QR okutmaz.
