#!/usr/bin/env bash
set -euo pipefail

# pre-commit-check
# Commit 前编译/测试检查，失败则阻止提交。

if [ -f "package.json" ]; then
  if command -v npm >/dev/null 2>&1; then
    npm run build
  fi
elif [ -f "pyproject.toml" ] || [ -f "requirements.txt" ]; then
  if command -v python >/dev/null 2>&1; then
    python -m compileall .
  fi
fi
