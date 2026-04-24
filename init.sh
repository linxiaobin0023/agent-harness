#!/usr/bin/env bash
set -euo pipefail

MODE="${1:-}"
TEMPLATE_BASE_URL="${TEMPLATE_BASE_URL:-https://raw.githubusercontent.com/linxiaobin0023/agent-harness/main}"

if [[ -z "$MODE" ]]; then
  echo "Choose a template package:"
  echo "  1. Minimal (min)"
  echo "  2. Full (full)"
  read -rp "Enter 1 or 2: " choice
  case "$choice" in
    1) MODE="min" ;;
    2) MODE="full" ;;
    *) echo "Invalid input. Exiting."; exit 1 ;;
  esac
fi

case "$MODE" in
  min|full)
    ;;
  *)
    echo "Usage: bash init.sh [min|full]"
    exit 1
    ;;
esac

echo "Selected mode: $MODE"

case "$MODE" in
  min)
    VERSION_FILE_NAME="releases/min/version.json"
    TEMPLATE_FILE_NAME="releases/min/template.zip"
    ;;
  full)
    VERSION_FILE_NAME="releases/full/version.json"
    TEMPLATE_FILE_NAME="releases/full/template.zip"
    ;;
esac

VERSION_URL="$TEMPLATE_BASE_URL/$VERSION_FILE_NAME"
TEMPLATE_URL="$TEMPLATE_BASE_URL/$TEMPLATE_FILE_NAME"
TMP_DIR="$(mktemp -d)"
VERSION_FILE="$TMP_DIR/$(basename "$VERSION_FILE_NAME")"
TEMPLATE_FILE="$TMP_DIR/$(basename "$TEMPLATE_FILE_NAME")"

echo "Downloading version metadata..."
curl -fsSL "$VERSION_URL" -o "$VERSION_FILE"
echo "Downloading template package..."
curl -fsSL "$TEMPLATE_URL" -o "$TEMPLATE_FILE"
echo "Extracting template..."
unzip -o "$TEMPLATE_FILE" -d .

echo "Installation complete."
echo "Mode: $MODE"
echo "Open Cursor and read .cursor/CURSOR.md first."
