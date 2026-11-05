#!/usr/bin/env bash
# ---------------------------------------------------------------------------
# instalar-skill.sh — instala/actualiza la skill de marketing del negocio
# (skills/marketing-juanpablo) en ~/.pi/agent/skills/ del nodo actual,
# y opcionalmente la replica a los demás nodos de la malla por SSH.
#
# La skill vive en el repo `juanpablomasia` (fuente de verdad).
# Al cambiar SKILL.md o references/, correr este script para que Pi la
# cargue con el contenido nuevo (o /reload dentro de Pi).
#
# Uso:
#   ./bin/instalar-skill.sh              # solo este nodo
#   ./bin/instalar-skill.sh --malla      # este nodo + a13/a16/msi/hp por SSH
#   ./bin/instalar-skill.sh --check      # compara y dice si está al día
# ---------------------------------------------------------------------------
set -uo pipefail

REPO="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
SRC="$REPO/skills/marketing-juanpablo"
NAME="marketing-juanpablo"
NODOS=(msi-operador hp-operador a13 a16)

MALLA=0; CHECK=0
for a in "$@"; do
  case "$a" in
    --malla) MALLA=1 ;;
    --check) CHECK=1 ;;
    *) echo "opción desconocida: $a"; exit 1 ;;
  esac
done

[[ -d "$SRC" ]] || { echo "ERROR: no encuentro $SRC"; exit 1; }

DIFF="$(diff -rq "$SRC" "$HOME/.pi/agent/skills/$NAME" 2>&1)"
if [[ -z "$DIFF" ]]; then
  echo "✔ skill $NAME al día en $HOSTNAME"
  [[ $CHECK -eq 1 ]] && exit 0
else
  if [[ $CHECK -eq 1 ]]; then
    echo "✗ skill $NAME desactualizada en este nodo:"
    echo "$DIFF" | sed 's/^/    /'
    exit 1
  fi
  mkdir -p "$HOME/.pi/agent/skills"
  rm -rf "$HOME/.pi/agent/skills/$NAME"
  cp -r "$SRC" "$HOME/.pi/agent/skills/$NAME"
  echo "✔ skill $NAME instalada en $HOME/.pi/agent/skills/$NAME"
fi

[[ $MALLA -eq 0 ]] && { echo "   (dentro de Pi: /reload para que la tome sin reiniciar)"; exit 0; }

# Replicar a los demás nodos: se manda el directorio y se copia en destino.
# Se usa tar por stdin (H-23: no pegar comandos multilínea por SSH).
echo "== Replicando a la malla =="
for n in "${NODOS[@]}"; do
  if ! ssh -o ConnectTimeout=6 -o BatchMode=yes "$n" true 2>/dev/null; then
    echo "  $n: inalcanzable"
    continue
  fi
  ssh -o ConnectTimeout=10 "$n" "mkdir -p ~/.pi/agent/skills" 2>/dev/null
  if tar -C "$SRC/.." -czf - "$NAME" | ssh -o ConnectTimeout=15 "$n" "rm -rf ~/.pi/agent/skills/$NAME && tar -C ~/.pi/agent/skills -xzf -" 2>/dev/null; then
    echo "  $n: ✔"
  else
    echo "  $n: ✗ falló"
  fi
done
