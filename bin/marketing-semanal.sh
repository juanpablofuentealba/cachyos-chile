#!/data/data/com.termux/files/usr/bin/bash
# ---------------------------------------------------------------------------
# marketing-semanal.sh — ciclo semanal de marketing del sitio (Etapa 3).
#
# QUÉ HACE (todo local; NO publica nada, NO hace push):
#   1. Corre el auditor técnico (bin/auditar-sitio.sh) -> salud del sitio.
#   2. Junta contexto: informe previo, últimas guías, la skill de marketing.
#   3. Llama a `pi --print` para que el agente PROPONGA acciones concretas
#      (títulos, secciones FAQ, una guía nueva) según lo medido.
#   4. Escribe TODO en ~/informes/marketing/AAAA-MM-DD.md y lo resume en
#      ~/informes/marketing/ULTIMO.md
#   5. Avisa al operador (WhatsApp a a16) de que el informe está listo.
#
# LO QUE *NO* HACE (por diseño, ver MARKETING.md §8.4):
#   - No publica, no abre PR, no empuja nada. El operador revisa y decide.
#   - No inventa casos ni promesas (Ley 19.496).
#
# Uso:
#   marketing-semanal.sh              # corrida normal (escribe el informe)
#   marketing-semanal.sh --sin-ia     # solo el auditor técnico (rápido, barato)
#   marketing-semanal.sh --dry-run    # no escribe el informe ni avisa
#
# Pensado para cron en a13 (lunes 10:00). Log por cron-run.sh.
# ---------------------------------------------------------------------------
set -uo pipefail

REPO="$HOME/dev/juanpablomasia"
AUDIT="$REPO/bin/auditar-sitio.sh"
OUT_DIR="$HOME/informes/marketing"
HOY="$(date +%F)"
INFORME="$OUT_DIR/$HOY.md"
ULTIMO="$OUT_DIR/ULTIMO.md"
WS="$HOME/rustdesk-clientes/scripts/wa.sh"
PI="$HOME/.pi/agent/bin/pi"

SIN_IA=0; DRY=0
for a in "$@"; do
  case "$a" in
    --sin-ia) SIN_IA=1 ;;
    --dry-run) DRY=1 ;;
    *) echo "uso: marketing-semanal.sh [--sin-ia|--dry-run]" >&2; exit 2 ;;
  esac
done

mkdir -p "$OUT_DIR"
T="${TMPDIR:-$HOME/.cache}"; mkdir -p "$T"

# --- 1. Auditoría técnica (determinista) ---------------------------------
AUDIT_TXT=""
AUDIT_OK=1
if [ -x "$AUDIT" ] && [ -d "$REPO" ]; then
  AUDIT_TXT="$(cd "$REPO" && ./bin/auditar-sitio.sh 2>&1)"; AUDIT_OK=$?
else
  AUDIT_TXT="(no se pudo correr el auditor: falta $AUDIT o el repo)"
  AUDIT_OK=2
fi

# --- 2. Contexto ---------------------------------------------------------
INFO_PREVIO=""
[ -f "$ULTIMO" ] && INFO_PREVIO="$(head -40 "$ULTIMO")"

GUIAS=""
if [ -d "$REPO" ]; then
  GUIAS="$(cd "$REPO" && ls -d */ 2>/dev/null | grep -v -E '^(bin|netlify|skills|assets|img)/' | sed 's#/##' | tr '\n' ' ')"
fi

# --- 3. Análisis con IA (opcional) --------------------------------------
ANALISIS=""
if [ "$SIN_IA" -eq 0 ] && [ -x "$PI" ]; then
  PROMPT_FILE="$T/marketing-prompt.txt"

  # Cabecera fija. Las comillas en <<'PROMPT' evitan que bash expanda $ ni
  # backticks del texto del prompt (el informe previo puede traer $).
  cat > "$PROMPT_FILE" <<'PROMPT'
Eres el asistente de marketing del servicio técnico "Juan Pablo + IA" (Macul,
Chile). Escribes en español de Chile neutro, tuteo, sin voseo, sin promesas
exageradas (Ley 19.496: nada de "garantizado", "100%", "cura").

CONTEXTO DEL SITIO
- Sitio: https://juanpablomasia.netlify.app/ (repo cachyos-chile, marca "Juan Pablo + IA")
- Servicios (CLP): web desde 149900; PC presencial Macul 44900; Android
  optimizacion 24900 / formateo 29900; soporte remoto 18000/h; mantención
  9900 o 19900/mes.
- El 5o servicio (diagnóstico "el PC se cae o se apaga solo", caso rai) aun
  NO esta publicado con precio.
PROMPT

  # Variables, concatenadas aparte (así nunca se expanden dentro del texto fijo).
  {
    echo
    echo "GUIAS PUBLICADAS: ${GUIAS:-（ninguna）}"
    echo
    echo "RESULTADO DE LA AUDITORIA TECNICA DE HOY"
    printf '%s\n' "$AUDIT_TXT"
    echo
    echo "INFORME ANTERIOR (si lo hay)"
    printf '%s\n' "${INFO_PREVIO:-（sin informe previo）}"
    cat <<'PROMPT2'

TU TAREA
Con base en lo anterior, entrega un informe BREVE y ACCIONABLE en Markdown, así:

## Estado
(2-3 líneas: cómo está el sitio según la auditoría)

## Acciones propuestas
(1 a 3 acciones concretas, ordenadas por impacto/esfuerzo. Cada una con: qué,
por qué, y el cambio TÉCNICO exacto que implicaría —título nuevo, sección FAQ,
guía nueva—. Nada vago.)

## Qué NO hacer todavía
(1-2 líneas: lo que no conviene, dado que Search Console recién arranca)

REGLAS
- No propongas publicar nada automáticamente: tú propones, el operador aprueba.
- No inventes datos ni casos. Si no hay datos de tráfico, dilo.
- Máximo 400 palabras. Español de Chile, formal.
PROMPT2
  } >> "$PROMPT_FILE"

  ANALISIS="$(timeout 300 "$PI" --print --no-session "$(cat "$PROMPT_FILE")" 2>"$T/pi-err.txt")"
  PI_RC=$?
  if [ "$PI_RC" -ne 0 ] || [ -z "$ANALISIS" ]; then
    ANALISIS="(no se pudo obtener el análisis de IA — rc=$PI_RC)
$(head -3 "$T/pi-err.txt" 2>/dev/null)"
  fi
fi

# --- 4. Escribir el informe ---------------------------------------------
if [ "$DRY" -eq 1 ]; then
  echo "=== DRY-RUN: esto es lo que se escribiría ==="
  echo "$AUDIT_TXT"
  [ -n "$ANALISIS" ] && { echo; echo "--- análisis IA ---"; echo "$ANALISIS"; }
  exit 0
fi

{
  echo "# Informe de marketing — $HOY"
  echo
  echo "> Generado automáticamente por el ciclo semanal (a13)."
  echo "> **Este informe no publica nada**: el operador revisa y decide."
  echo
  echo "## 1. Salud técnica del sitio (medida)"
  echo
  echo '```'
  echo "$AUDIT_TXT"
  echo '```'
  echo
  if [ -n "$ANALISIS" ]; then
    echo "## 2. Análisis y acciones propuestas"
    echo
    echo "$ANALISIS"
    echo
  fi
  echo "---"
  echo "_Próximo paso humano: revisar este informe y, si algo convence,"
  echo "convertirlo en PR._"
} > "$INFORME"

cp "$INFORME" "$ULTIMO"

# --- 5. Avisar ------------------------------------------------------------
RESUMEN="Informe de marketing listo ($HOY)."
if [ "$AUDIT_OK" -eq 0 ]; then
  RESUMEN="$RESUMEN Sitio sin problemas técnicos."
else
  RESUMEN="$RESUMEN ⚠️ La auditoría técnica encontró problemas — revisar."
fi

# Aviso a a16 (el canal que SÍ llega: a13 no notifica, ver H-86).
# Se usa cron-notify.sh, que ya tiene reintento y cola.
if [ -x "$HOME/bin/cron-notify.sh" ]; then
  "$HOME/bin/cron-notify.sh" "📊 Informe de marketing $HOY" \
    "$RESUMEN Abrelo en ~/informes/marketing/$HOY.md" normal >/dev/null 2>&1 || true
fi
# Redundancia: dejar el texto también en el portapapeles de a13 por si acaso.
if [ -x "$WS" ]; then
  "$WS" -t "$RESUMEN Detalle: ~/informes/marketing/$HOY.md" >/dev/null 2>&1 || true
fi

echo "$RESUMEN"
echo "Informe: $INFORME"
[ "$AUDIT_OK" -eq 0 ] && exit 0 || exit 1
