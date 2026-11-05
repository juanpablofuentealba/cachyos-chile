#!/data/data/com.termux/files/usr/bin/bash
# ---------------------------------------------------------------------------
# recordar-fechas.sh — recordatorios personales del operador.
#
# POR QUÉ EXISTE:
#   Las fechas personales (cumpleaños, trámites) no pueden depender de la
#   memoria. Este cron las avisa a a16 unos días antes y el día mismo.
#
# CÓMO SE USA:
#   La lista de fechas vive en el array FECHAS de abajo: "MM-DD|aviso|dias".
#     - MM-DD : día del año (mes-día)
#     - aviso : el texto que recibe el operador
#     - dias  : cuántos días ANTES empezar a avisar (0 = solo el día)
#   Pensado para correr TODOS LOS DÍAS por cron (es idempotente: avisa una vez
#   por día y por fecha, guardando marca en ~/.config/recordar-fechas.state).
#
# Ejemplo de cron (a13, todos los días a las 9:00):
#   0 9 * * * ~/bin/cron-run.sh "recordar-fechas" \
#       ~/dev/juanpablomasia/bin/recordar-fechas.sh
#
# Silent cuando no hay nada que avisar.
# ---------------------------------------------------------------------------
set -uo pipefail

STATE="$HOME/.config/recordar-fechas.state"
HOY="$(date +%Y-%m-%d)"
HOY_MD="$(date +%m-%d)"

# --- Fechas personales -----------------------------------------------------
# Formato: "MM-DD|texto del aviso|días de anticipación"
FECHAS=(
  "11-16|🎂 Sebastián cumple 10 años|7"
  "12-16|🎂 Paula cumple años|7"
)

# --- Motor -----------------------------------------------------------------
mkdir -p "$(dirname "$STATE")"

avisos_hoy=""
for f in "${FECHAS[@]:-}"; do
  [ -z "$f" ] && continue
  md="${f%%|*}"; resto="${f#*|}"
  texto="${resto%%|*}"; dias="${resto#*|}"; dias="${dias:-0}"

  # ¿Cuántos días faltan? (comparando mes-día en el año actual)
  falta=$(python3 - "$md" <<'PY'
import sys,datetime
md=sys.argv[1]; m,d=md.split("-")
hoy=datetime.date.today()
try: objetivo=datetime.date(hoy.year,int(m),int(d))
except ValueError: sys.exit(0)
if objetivo < hoy: objetivo=datetime.date(hoy.year+1,int(m),int(d))
print((objetivo-hoy).days)
PY
)
  [ -z "$falta" ] && continue
  if [ "$falta" -le "$dias" ]; then
    clave="$HOY|$md"
    if ! grep -qF "$clave" "$STATE" 2>/dev/null; then
      if [ "$falta" -eq 0 ]; then
        avisos_hoy="$avisos_hoy$texto ¡HOY! "
      else
        avisos_hoy="$avisos_hoy$texto (faltan $falta días). "
      fi
      echo "$clave" >> "$STATE"
    fi
  fi
done

[ -z "$avisos_hoy" ] && exit 0

# Avisar a a16 (canal verificado; a13 no notifica, ver H-86).
if [ -x "$HOME/bin/cron-notify.sh" ]; then
  "$HOME/bin/cron-notify.sh" "📅 Recordatorio personal" "$avisos_hoy" normal >/dev/null 2>&1 || true
fi
echo "$avisos_hoy"

# Poda del estado (no crece sin fin)
if [ "$(wc -l < "$STATE" 2>/dev/null || echo 0)" -gt 100 ]; then
  tail -50 "$STATE" > "$STATE.tmp" && mv "$STATE.tmp" "$STATE"
fi
