#!/usr/bin/env bash
set -euo pipefail

# detect-feedback-signal
# 检测用户输入中的纠正/不满信号。

message="${1:-}"
case "$message" in
  *"你搞错了"*|*"不是这样"*|*"你又忘了"*|*"不对"*|*"有问题"*)
    echo "feedback signal detected"
    ;;
esac
