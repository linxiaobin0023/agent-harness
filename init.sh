#!/usr/bin/env bash
set -euo pipefail

MODE="${1:-}"
TEMPLATE_BASE_URL="${TEMPLATE_BASE_URL:-https://raw.githubusercontent.com/linxiaobin0023/agent-harness/main}"

if [[ -z "$MODE" ]]; then
  echo "请选择要安装的模板版本："
  echo "  1. 精简版（min）"
  echo "  2. 全量版（full）"
  read -rp "请输入 1 或 2: " choice
  case "$choice" in
    1) MODE="min" ;;
    2) MODE="full" ;;
    *) echo "输入无效，已退出。"; exit 1 ;;
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

echo "当前选择的模板版本：$MODE"

case "$MODE" in
  min)
    VERSION_FILE_NAME="version-min.json"
    TEMPLATE_FILE_NAME="template-min.zip"
    ;;
  full)
    VERSION_FILE_NAME="version-full.json"
    TEMPLATE_FILE_NAME="template-full.zip"
    ;;
esac

VERSION_URL="$TEMPLATE_BASE_URL/$VERSION_FILE_NAME"
TEMPLATE_URL="$TEMPLATE_BASE_URL/$TEMPLATE_FILE_NAME"
TMP_DIR="$(mktemp -d)"
VERSION_FILE="$TMP_DIR/$VERSION_FILE_NAME"
TEMPLATE_FILE="$TMP_DIR/$TEMPLATE_FILE_NAME"

echo "正在下载模板元数据..."
curl -fsSL "$VERSION_URL" -o "$VERSION_FILE"
curl -fsSL "$TEMPLATE_URL" -o "$TEMPLATE_FILE"
echo "正在解压模板..."
unzip -o "$TEMPLATE_FILE" -d .

echo "安装完成。"
echo "当前模式：$MODE"
echo "请先打开 Cursor 并阅读 .cursor/CURSOR.md。"
