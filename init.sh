#!/usr/bin/env bash
set -euo pipefail

MODE="${1:-}"
TEMPLATE_BASE_URL="${TEMPLATE_BASE_URL:-https://raw.githubusercontent.com/linxiaobin0023/agent-harness/main}"

RED='\033[31m'
GREEN='\033[32m'
YELLOW='\033[33m'
CYAN='\033[36m'
RESET='\033[0m'

stage() {
  local color="$1"
  local label="$2"
  local message="$3"
  printf '%b[%s] %s%b\n' "$color" "$label" "$message" "$RESET"
}

if [[ -z "$MODE" ]]; then
  stage "$CYAN" "SELECT" "Choose a template package:"
  echo "  1. Minimal (min)"
  echo "  2. Full (full)"
  read -rp "Enter 1 or 2: " choice
  case "$choice" in
    1) MODE="min" ;;
    2) MODE="full" ;;
    *) stage "$RED" "ERROR" "Invalid input. Exiting."; exit 1 ;;
  esac
fi

case "$MODE" in
  min|full)
    ;;
  *)
    stage "$RED" "ERROR" "Usage: bash init.sh [min|full]"
    exit 1
    ;;
esac

stage "$CYAN" "SELECT" "Selected mode: $MODE"

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
CURSOR_DIR="$(pwd)/.cursor"

stage "$YELLOW" "DOWNLOAD" "Downloading version metadata..."
curl -fsSL "$VERSION_URL" -o "$VERSION_FILE"
stage "$YELLOW" "DOWNLOAD" "Downloading template package..."
curl -fsSL "$TEMPLATE_URL" -o "$TEMPLATE_FILE"

mkdir -p "$CURSOR_DIR"
stage "$GREEN" "EXTRACT" "Extracting template into .cursor..."
unzip -o "$TEMPLATE_FILE" -d "$CURSOR_DIR"

stage "$GREEN" "DONE" "Installation complete."
stage "$GREEN" "DONE" "Mode: $MODE"
stage "$GREEN" "DONE" "Open Cursor and read .cursor/CURSOR.md first."
