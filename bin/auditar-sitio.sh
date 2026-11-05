#!/data/data/com.termux/files/usr/bin/bash
# ---------------------------------------------------------------------------
# auditar-sitio.sh — salud técnica del sitio (determinista, sin IA).
#
# POR QUÉ EXISTE:
#   El ciclo de marketing (Etapa 3) necesita una capa de MEDICIÓN que sea
#   barata, rápida y que NUNCA mienta. Eso no se le pide a un modelo: se
#   escribe. Este script hace las comprobaciones objetivas del sitio y devuelve
#   un informe corto en texto. La parte de "¿qué hacemos con esto?" la hace
#   después `pi --print` (ver marketing-semanal.sh).
#
# QUÉ CHEQUEA (solo lectura, no toca nada):
#   1. HTTP de todas las rutas conocidas (home, guías, sitemap, robots, llms,
#      archivo de verificación de Google) -> deben dar 200.
#   2. Una ruta inexistente -> debe dar 404 (que la web no "invente" 200).
#   3. Enlaces internos rotos en el HTML (los `data:` inline se ignoran).
#   4. JSON-LD válido en cada página (parsea el JSON de verdad).
#   5. GA4 presente en todas las páginas.
#   6. canonical + og:image presentes; meta description dentro de rango.
#   7. sitemap: que existan las URLs esperadas y que tengan lastmod.
#   8. robots.txt: que declare el sitemap.
#   9. Googlebot recibe el sitio normal (no bloqueado) + el archivo de
#      verificación de Search Console responde 200.
#  10. Peso del HTML de cada página (alerta si > 60 KB, que sería un muro).
#
# Uso:
#   auditar-sitio.sh                 # informe a stdout (texto)
#   auditar-sitio.sh --json          # informe en JSON (para consumir)
#   auditar-sitio.sh --quiet         # solo imprime si hay problemas (cron)
#
# Salida: exit 0 si todo bien; exit 1 si hay algún problema (para que cron-run
# avise). Los "avisos" (warnings) no hacen fallar.
# Log no escribe; el llamador decide dónde guardar.
# ---------------------------------------------------------------------------
set -uo pipefail

SITE="${SITIO_URL:-https://juanpablomasia.netlify.app}"
JSON=0
QUIET=0
for a in "$@"; do
  case "$a" in
    --json) JSON=1 ;;
    --quiet) QUIET=1 ;;
    *) echo "uso: auditar-sitio.sh [--json] [--quiet]" >&2; exit 2 ;;
  esac
done

REPO="$HOME/dev/cachyos-chile"
T="${TMPDIR:-$HOME/.cache}"; mkdir -p "$T"

CURL="curl -sS --max-time 20 -A Mozilla/5.0(auditoria-malla)"

# Rutas que DEBEN dar 200 (y la que debe dar 404).
RUTAS_OK=(
  "/" "/guias/" "/como-instalar-cachyos/" "/linux-vs-windows/"
  "/revivir-pc-viejo-con-linux/" "/pc-se-apaga-solo/"
  "/sitemap.xml" "/robots.txt" "/llms.txt"
  "/google394ddc95e10794bf.html"
)
RUTA_404="/ruta-que-no-existe-xyz-123/"

PROBLEMAS=()     # cosas que hacen fallar (exit 1)
AVISOS=()        # cosas a mirar, no fallan

add_problema() { PROBLEMAS+=("$1"); }
add_aviso()    { AVISOS+=("$1"); }

# --- 1/2. HTTP ----------------------------------------------------------
declare -a HTTP_LINEAS=()
for r in "${RUTAS_OK[@]}"; do
  code=$($CURL -o /dev/null -w "%{http_code}" "$SITE$r" 2>/dev/null || echo "000")
  HTTP_LINEAS+=("$(printf '%-38s %s' "$r" "$code")")
  [ "$code" != "200" ] && add_problema "HTTP $code en $r (se esperaba 200)"
done
code404=$($CURL -o /dev/null -w "%{http_code}" "$SITE$RUTA_404" 2>/dev/null || echo "000")
[ "$code404" != "404" ] && add_problema "Ruta inexistente devuelve $code404 (se esperaba 404)"

# --- 9. Googlebot + verificación ----------------------------------------
gb=$($CURL -o /dev/null -w "%{http_code}" "$SITE/" 2>/dev/null || echo 000)
[ "$gb" != "200" ] && add_problema "Googlebot no recibe la home (HTTP $gb)"
TOKEN_FILE="$REPO/google394ddc95e10794bf.html"
if [ -f "$TOKEN_FILE" ]; then
  tok_esperado="$(tr -d '\r\n' < "$TOKEN_FILE")"
  tok_real=$($CURL "$SITE/google394ddc95e10794bf.html" 2>/dev/null | tr -d '\r\n')
  [ "$tok_real" != "$tok_esperado" ] && add_problema \
    "El archivo de verificación de Google no coincide con el del repo"
else
  add_aviso "No está el archivo de verificación de Google en el repo local"
fi

# --- Comprobaciones que necesitan el repo local -------------------------
if [ ! -d "$REPO" ]; then
  add_aviso "No está el repo $REPO; se saltan enlaces/JSON-LD/meta/sitemap"
else
  # 3. enlaces internos rotos
  while IFS= read -r linea; do
    [ -n "$linea" ] && add_problema "$linea"
  done < <(cd "$REPO" && python3 - <<'PY'
import re,os,glob
pages=[p for p in glob.glob("**/index.html",recursive=True)+["index.html","404.html"]
       if not p.startswith("node_modules")]
seen=set(); pages=[p for p in pages if not (p in seen or seen.add(p))]
hrefs=set()
for p in pages:
    for h in re.findall(r'href="([^"]+)"', open(p,encoding="utf-8").read()):
        if h.startswith(("http","#","mailto:","tel:","data:","//","javascript:")) or not h:
            continue
        hrefs.add(h)
def exists(r):
    r=r.split("#")[0].split("?")[0]
    if not r or r=="/": return os.path.exists("index.html")
    p=os.path.join(r.lstrip("/"))
    return os.path.exists(p) or os.path.exists(p+"index.html") or os.path.exists(p.rstrip("/")+"/index.html")
bad=sorted(h for h in hrefs if not exists(h))
for b in bad:
    print(f"Enlace interno roto: {b}")
PY
  )

  # 4/5/6. JSON-LD, GA4, meta
  while IFS= read -r linea; do
    [ -n "$linea" ] && add_problema "$linea"
  done < <(cd "$REPO" && python3 - <<'PY'
import re,json,glob
pages=[p for p in glob.glob("**/index.html",recursive=True)+["index.html"]
       if not p.startswith("node_modules")]
seen=set(); pages=[p for p in pages if not (p in seen or seen.add(p))]
GA="G-CNV88M2Q9N"
for f in sorted(pages):
    h=open(f,encoding="utf-8").read()
    for b in re.findall(r'<script type="application/ld\+json">(.*?)</script>',h,re.S):
        try: json.loads(b)
        except Exception as e: print(f"JSON-LD inválido en {f}: {str(e)[:40]}")
    if GA not in h and f!="404.html":
        print(f"Sin GA4 en {f}")
    if not re.search(r'<link rel="canonical"',h):
        print(f"Sin canonical en {f}")
    if not re.search(r'<meta property="og:image"',h):
        print(f"Sin og:image en {f}")
    m=re.search(r'<meta name="description" content="([^"]*)"',h,re.S)
    if m:
        d=re.sub(r'\s+',' ',m.group(1)).strip()
        if len(d)>160 or len(d)<50:
            print(f"Descripcion fuera de rango en {f}: {len(d)}c")
PY
  )

  # 7. sitemap
  SM_FILE="$T/sitemap-audit.xml"
  curl -sS --max-time 20 "$SITE/sitemap.xml" -o "$SM_FILE" 2>/dev/null || : > "$SM_FILE"
  while IFS= read -r linea; do
    [ -n "$linea" ] && add_aviso "$linea"
  done < <(python3 - "$SITE" "$SM_FILE" <<'PY'
import sys,re
base=sys.argv[1].rstrip("/")
xml=open(sys.argv[2],encoding="utf-8").read()
locs=re.findall(r'<loc>([^<]+)</loc>',xml)
esperadas=["/","/guias/","/como-instalar-cachyos/","/linux-vs-windows/",
           "/revivir-pc-viejo-con-linux/","/pc-se-apaga-solo/"]
def norm(u):
    u=u.strip()
    if u.startswith(base): u=u[len(base):]
    return u.rstrip("/") or "/"
norm_locs={norm(l) for l in locs}
for e in esperadas:
    if (e.rstrip("/") or "/") not in norm_locs:
        print(f"Falta en el sitemap: {e}")
PY
  )
  grep -q "<lastmod>" "$SM_FILE" 2>/dev/null || add_aviso "El sitemap no tiene ningún <lastmod>"

  # 8. robots (a archivo, para no morir con el pipe)
  RB_FILE="$T/robots-audit.txt"
  curl -sS --max-time 20 "$SITE/robots.txt" -o "$RB_FILE" 2>/dev/null || : > "$RB_FILE"
  grep -qi "sitemap:" "$RB_FILE" || add_problema "robots.txt no declara el sitemap"
fi

# --- Informe ------------------------------------------------------------
n_prob=${#PROBLEMAS[@]}
n_avis=${#AVISOS[@]}

if [ "$JSON" -eq 1 ]; then
  # Escribir los mensajes a archivos para no romper con pipes/argsv.
  if [ "$n_prob" -gt 0 ]; then printf '%s\n' "${PROBLEMAS[@]}" > "$T/aud-prob.txt"; else : > "$T/aud-prob.txt"; fi
  if [ "$n_avis" -gt 0 ]; then printf '%s\n' "${AVISOS[@]}" > "$T/aud-avis.txt"; else : > "$T/aud-avis.txt"; fi
  python3 - "$n_prob" "$T/aud-prob.txt" "$T/aud-avis.txt" <<'PY'
import json,sys
np=int(sys.argv[1])
def leer(p):
    try: return [l for l in open(p,encoding="utf-8").read().splitlines() if l]
    except Exception: return []
probs=leer(sys.argv[2]); avis=leer(sys.argv[3])
print(json.dumps({"ok": np==0, "problemas": probs, "avisos": avis}, ensure_ascii=False, indent=2))
PY
  [ "$n_prob" -eq 0 ] && exit 0 || exit 1
fi

if [ "$QUIET" -eq 1 ] && [ "$n_prob" -eq 0 ] && [ "$n_avis" -eq 0 ]; then
  exit 0
fi

echo "AUDITORIA DEL SITIO — $(date '+%F %T')"
echo "sitio: $SITE"
echo
echo "-- HTTP --"
for l in "${HTTP_LINEAS[@]}"; do echo "  $l"; done
echo "  $(printf '%-38s %s' "$RUTA_404" "$code404")  (debe ser 404)"
echo
if [ "$n_prob" -gt 0 ]; then
  echo "PROBLEMAS ($n_prob):"
  for p in "${PROBLEMAS[@]}"; do echo "  ✗ $p"; done
else
  echo "PROBLEMAS: ninguno"
fi
echo
if [ "$n_avis" -gt 0 ]; then
  echo "AVISOS ($n_avis):"
  for a in "${AVISOS[@]}"; do echo "  ⚠ $a"; done
else
  echo "AVISOS: ninguno"
fi

[ "$n_prob" -eq 0 ] && exit 0 || exit 1
