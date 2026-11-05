#!/usr/bin/env bash
# ---------------------------------------------------------------------------
# generar-sitemap.sh — regenera sitemap.xml con <lastmod> real.
#
# El <lastmod> sale de la fecha del último commit que tocó cada página
# (no de la fecha de hoy, que mentiría y los buscadores ignoran).
# Si un archivo no está en git o no tiene commits, se usa la fecha del
# último commit del repo como respaldo.
#
# Uso:
#   ./bin/generar-sitemap.sh          # reescribe sitemap.xml
#   ./bin/generar-sitemap.sh --check   # solo compara; exit 1 si está desactualizado
#
# Nota Termux: no usa mktemp (no hay /tmp) — escribe directo sobre el archivo.
# ---------------------------------------------------------------------------
set -uo pipefail

REPO="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$REPO" || exit 1

SITE="https://juanpablomasia.netlify.app"
OUT="sitemap.xml"
CHECK=0
[[ "${1:-}" == "--check" ]] && CHECK=1

# ruta local | URL | prioridad
PAGES=(
  "index.html|$SITE/|1.0"
  "guias/index.html|$SITE/guias/|0.8"
  "como-instalar-cachyos/index.html|$SITE/como-instalar-cachyos/|0.9"
  "linux-vs-windows/index.html|$SITE/linux-vs-windows/|0.8"
  "revivir-pc-viejo-con-linux/index.html|$SITE/revivir-pc-viejo-con-linux/|0.8"
)

# Fecha del último commit del repo (respaldo).
FALLBACK="$(git log -1 --format=%cs 2>/dev/null)"
[[ -z "$FALLBACK" ]] && FALLBACK="$(date -u +%Y-%m-%d)"

tmp="$OUT.nuevo"
{
  echo '<?xml version="1.0" encoding="UTF-8"?>'
  echo '<urlset xmlns="http://www.sitemaps.org/schemas/sitemap/0.9">'
  for row in "${PAGES[@]}"; do
    IFS='|' read -r file url prio <<< "$row"
    last="$(git log -1 --format=%cs -- "$file" 2>/dev/null)"
    [[ -z "$last" ]] && last="$FALLBACK"
    # changefreq coherente con el tipo de página
    if [[ "$file" == "index.html" ]]; then freq="weekly"; else freq="monthly"; fi
    echo "  <url>"
    echo "    <loc>$url</loc>"
    echo "    <lastmod>$last</lastmod>"
    echo "    <changefreq>$freq</changefreq>"
    echo "    <priority>$prio</priority>"
    echo "  </url>"
  done
  echo '</urlset>'
} > "$tmp"

if [[ $CHECK -eq 1 ]]; then
  if diff -q "$OUT" "$tmp" >/dev/null 2>&1; then
    echo "✔ sitemap.xml está al día"
    rm -f "$tmp"
    exit 0
  else
    echo "✗ sitemap.xml está desactualizado. Correr: ./bin/generar-sitemap.sh"
    diff "$OUT" "$tmp" | head -20
    rm -f "$tmp"
    exit 1
  fi
fi

mv "$tmp" "$OUT"
echo "✔ sitemap.xml regenerado con <lastmod>:"
grep -E "<loc>|<lastmod>" "$OUT" | sed 's/^ *//'
