#!/usr/bin/env bash
# ---------------------------------------------------------------------------
# cambiar-dominio.sh — pasa el sitio del subdominio .netlify.app al dominio propio.
#
# Hace TODO el cambio de URLs de una vez y sin errores de tipeo:
#   canonical · og:url · og:image · twitter:image · JSON-LD · sitemap
#   robots.txt · llms.txt · plugin IndexNow · generador de sitemap
#
# NO compra el dominio ni lo conecta en Netlify (eso es del operador):
#   ver MARKETING.md §4 y DOMINIO-PENDIENTE.md
#
# Uso:
#   ./bin/cambiar-dominio.sh juanpablomasia.cl          # aplica el cambio
#   ./bin/cambiar-dominio.sh juanpablomasia.cl --check  # solo muestra qué haría
#   ./bin/cambiar-dominio.sh --volver                   # vuelve al .netlify.app
#
# El dominio viejo queda registrado como redirección 301 en netlify.toml.
# ---------------------------------------------------------------------------
set -uo pipefail

REPO="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$REPO" || exit 1

VIEJO_HOST="juanpablomasia.netlify.app"
DOMINIO="${1:-}"
CHECK=0
VOLVER=0

case "${1:-}" in
  --volver) VOLVER=1; DOMINIO=""; shift ;;
  *) [[ "${2:-}" == "--check" ]] && CHECK=1 ;;
esac

if [[ $VOLVER -eq 0 ]]; then
  if [[ -z "$DOMINIO" || "$DOMINIO" == --* ]]; then
    echo "Uso: ./bin/cambiar-dominio.sh <dominio.cl> [--check]"
    echo "     ./bin/cambiar-dominio.sh --volver"
    exit 1
  fi
  # Normalizar: quitar https://, http://, www. y barra final
  DOMINIO="${DOMINIO#https://}"; DOMINIO="${DOMINIO#http://}"
  DOMINIO="${DOMINIO#www.}"; DOMINIO="${DOMINIO%/}"
  NUEVO_HOST="$DOMINIO"
else
  NUEVO_HOST="$VIEJO_HOST"
  echo "→ Volviendo a $VIEJO_HOST"
fi

# Archivos donde vive el host (los .md se actualizan aparte, a mano).
FILES=(
  "index.html"
  "guias/index.html"
  "como-instalar-cachyos/index.html"
  "linux-vs-windows/index.html"
  "revivir-pc-viejo-con-linux/index.html"
  "404.html"
  "robots.txt"
  "llms.txt"
  "sitemap.xml"
  "avisar-buscadores.sh"
  "bin/generar-sitemap.sh"
  "netlify/plugins/indexnow/index.js"
)

echo "== Cambio de dominio =="
echo "  desde: $VIEJO_HOST"
echo "  hacia: $NUEVO_HOST"
[[ $CHECK -eq 1 ]] && echo "  (modo --check: no se escribe nada)"
echo

total=0
for f in "${FILES[@]}"; do
  [[ -f "$f" ]] || { echo "  ⚠ falta $f"; continue; }
  n=$(grep -c -F "$VIEJO_HOST" "$f" 2>/dev/null || echo 0)
  # Cuando volvemos, también hay que reemplazar el dominio propio.
  if [[ $VOLVER -eq 1 ]]; then
    n=$(( n + $(grep -c -E "https?://[a-z0-9.-]+\.cl" "$f" 2>/dev/null || echo 0) ))
  fi
  echo "  $f: $n coincidencia(s)"
  total=$((total+n))
  [[ $CHECK -eq 1 ]] && continue

  if [[ $VOLVER -eq 1 ]]; then
    # Revertir: cualquier *.cl del sitio vuelve al netlify.app
    sed -i -E "s#https?://(www\.)?[a-z0-9.-]+\.cl(\b|/)#https://$NUEVO_HOST\2#g" "$f"
  else
    sed -i -F "s#$VIEJO_HOST#$NUEVO_HOST#g" "$f"
  fi
done

echo
echo "Total: $total coincidencia(s)"
[[ $CHECK -eq 1 ]] && exit 0

# netlify.toml: redirección 301 del subdominio al dominio propio
echo "== netlify.toml (301 del .netlify.app al dominio) =="
if [[ $VOLVER -eq 0 ]]; then
  echo "  → agregar a mano (o ya está) el bloque 'redirect 301':"
  echo "     from = \"https://$VIEJO_HOST/*\"  →  to = \"https://$NUEVO_HOST/:splat\""
else
  echo "  → recordar quitar la redirección 301 del netlify.toml"
fi

# Regenerar sitemap con el host nuevo
if [[ -x bin/generar-sitemap.sh ]]; then
  ./bin/generar-sitemap.sh >/dev/null && echo "== sitemap.xml regenerado =="
fi

echo
echo "✔ Listo. Verificar:"
echo "   grep -r '$VIEJO_HOST' --include='*.html' --include='*.xml' --include='*.txt' ."
echo "   ./bin/generar-sitemap.sh --check"
