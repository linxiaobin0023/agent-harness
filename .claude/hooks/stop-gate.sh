#!/usr/bin/env bash
set -euo pipefail

# stop-gate
# 结束前检查是否仍有未审查代码变更。

if git status --porcelain | grep -E '^(A|M|\?\?)' >/dev/null 2>&1; then
  echo "Review needed before stopping."
  exit 1
fi
