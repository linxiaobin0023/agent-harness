#!/usr/bin/env bash
set -euo pipefail

# check-evolution
# 新 session 启动时检查反馈积累，提示是否有待处理的进化建议。

if [ -f ".claude/feedback/FEEDBACK-INDEX.md" ]; then
  echo "evolution check complete"
fi
