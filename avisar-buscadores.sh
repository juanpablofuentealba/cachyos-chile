#!/usr/bin/env bash
# Avisa a los buscadores (IndexNow: Bing, Yandex, Seznam…) que el sitio cambió.
# Uso: ./avisar-buscadores.sh
# Corre tras cada cambio relevante de contenido. Google no usa IndexNow:
# para Google se usa Search Console (ver PENDIENTES-SEO.md).
set -euo pipefail

SITE="https://cachyos-chile.netlify.app"
KEY_FILE="./4ac291d7c370106abaa06b0edf277790.txt"
KEY="$(tr -d '[:space:]' < "$KEY_FILE")"

URLS=(
  "$SITE/"
  "$SITE/guias/"
  "$SITE/como-instalar-cachyos/"
  "$SITE/linux-vs-windows/"
  "$SITE/revivir-pc-viejo-con-linux/"
  "$SITE/sitemap.xml"
)

# JSON con la lista de URLs
JSON_URLS=$(printf '%s\n' "${URLS[@]}" | python3 -c 'import sys,json;print(json.dumps([l.strip() for l in sys.stdin if l.strip()]))')

echo "→ IndexNow key: $KEY"
echo "→ Avisando ${#URLS[@]} URLs a IndexNow (api.indexnow.org)…"

RESP=$(curl -sS -o /dev/null -w "%{http_code}" \
  -X POST "https://api.indexnow.org/indexnow" \
  -H "Content-Type: application/json; charset=utf-8" \
  -d "{\"host\":\"cachyos-chile.netlify.app\",\"key\":\"$KEY\",\"keyLocation\":\"$SITE/$KEY.txt\",\"urlList\":$JSON_URLS}")

case "$RESP" in
  200|202) echo "✅ Aceptado por IndexNow (HTTP $RESP). Bing/Yandex indexarán pronto." ;;
  400)     echo "⚠️  HTTP 400: formato inválido." ;;
  403)     echo "⚠️  HTTP 403: key no válida o no accesible en $SITE/$KEY.txt" ;;
  422)     echo "⚠️  HTTP 422: URLs no pertenecen al host o key no coincide." ;;
  429)     echo "⚠️  HTTP 429: demasiadas solicitudes, intenta más tarde." ;;
  *)       echo "⚠️  HTTP $RESP: revisar. Respuesta: $RESP" ;;
esac
