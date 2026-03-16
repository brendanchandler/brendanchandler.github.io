#!/usr/bin/env bash
set -euo pipefail

PREFIX="${PREFIX:-$HOME/bin}"
DEST="$PREFIX/bren-timer"

mkdir -p "$PREFIX"
install -m 755 bren-timer.sh "$DEST"
echo "Installed to $DEST"
