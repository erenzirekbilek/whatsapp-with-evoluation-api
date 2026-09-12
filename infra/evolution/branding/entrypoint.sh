#!/bin/bash
set -e

BRAND=/opt/evolution-branding
IMG_DIR=/evolution/manager/dist/assets/images
mkdir -p "$IMG_DIR"
cp -f "$BRAND/evolution-logo.svg" "$BRAND/evolution-logo-white.svg" "$BRAND/favicon.svg" "$IMG_DIR/"

shopt -s nullglob
for f in /evolution/manager/dist/assets/*.js; do
  sed -i \
    -e 's|https://evolution-api.com/files/evo/evolution-logo-white.svg|/assets/images/evolution-logo-white.svg|g' \
    -e 's|https://evolution-api.com/files/evo/evolution-logo.svg|/assets/images/evolution-logo.svg|g' \
    "$f"
done

for f in /evolution/manager/dist/*.html; do
  sed -i 's|https://evolution-api.com/files/evo/favicon.svg|/assets/images/favicon.svg|g' "$f"
done

for css in /evolution/manager/dist/assets/*.css; do
  if ! grep -q "sales-whatsapp-n8n manager ux" "$css"; then
    printf '\n' >> "$css"
    cat "$BRAND/manager-ux.css" >> "$css"
  fi
done

cd /evolution
. ./Docker/scripts/deploy_database.sh
exec npm run start:prod
