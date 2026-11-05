#!/data/data/com.termux/files/usr/bin/bash
# ---------------------------------------------------------------------------
# recordar-dominio.sh — recuerda al operador comprar juanpablomasia.cl.
#
# Contexto: el operador cobra alrededor de los días 15 y 20 de cada mes y
# decidió (05-nov-2026) comprar el dominio dentro de esa ventana.
#
# Pensado para correr por cron en a13 los días 14, 15, 16, 19 y 20:
#   0 11 14,15,16,19,20 * *  ~/bin/cron-run.sh "recordar-dominio" \
#       ~/dev/juanpablomasia/bin/recordar-dominio.sh
#
# Qué hace:
#   1. Se detiene en cuanto juanpablomasia.cl empieza a responder (ya comprado).
#   2. Si sigue sin existir, manda UN aviso por WhatsApp a a16 y no repite
#      dentro del mismo día (marca en ~/.config/recordar-dominio.state).
#
# Es idempotente y silencioso: si no hay nada que avisar, no imprime nada.
# ---------------------------------------------------------------------------
set -uo pipefail

DOMINIO="juanpablomasia.cl"
STATE_DIR="$HOME/.config"
STATE="$STATE_DIR/recordar-dominio.state"
HOY="$(date +%Y-%m-%d)"

[[ "${1:-}" == "--force" ]] && FORCE=1 || FORCE=0

mkdir -p "$STATE_DIR"

# ¿Ya está comprado? El dominio resuelve => paramos.
# En Termux (a13) no hay nslookup/dig: usar python3 como resolvedor portable.
ya_comprado() {
  if command -v nslookup >/dev/null 2>&1; then
    nslookup "$DOMINIO" 1.1.1.1 >/dev/null 2>&1 && return 0
    return 1
  fi
  python3 - "$DOMINIO" <<'PY' 2>/dev/null
import socket, sys
try:
    socket.setdefaulttimeout(5)
    socket.getaddrinfo(sys.argv[1], None)
except Exception:
    sys.exit(1)
sys.exit(0)
PY
}

if ya_comprado; then
  echo "[$HOY] $DOMINIO ya resuelve DNS -> comprado. Nada que recordar."
  echo "listo $HOY" > "$STATE"
  exit 0
fi

# ¿Ya avisamos hoy?
if [[ $FORCE -eq 0 ]] && [[ -f "$STATE" ]] && grep -q "avisado $HOY" "$STATE" 2>/dev/null; then
  exit 0   # silencio: ya se avisó hoy
fi

MSG='Recordatorio: comprar juanpablomasia.cl en nic.cl (9.990 al año). Ya esta todo preparado: avisa "dominio comprado" y se activa. Detalle: ~/dev/juanpablomasia/DOMINIO-PENDIENTE.md'

# Avisar a a16 por WhatsApp (wa.sh de la malla) si está disponible.
WS="$HOME/rustdesk-clientes/scripts/wa.sh"
if [[ -x "$WS" ]]; then
  if "$WS" -t "$MSG" >/dev/null 2>&1; then
    echo "avisado $HOY" >> "$STATE"
    echo "[$HOY] Recordatorio enviado a a16."
    exit 0
  fi
fi

# Sin wa.sh: al menos dejar el aviso en el log de cron y en pantalla.
echo "avisado $HOY (solo log)" >> "$STATE"
echo "[$HOY] RECORDATORIO: $MSG"
