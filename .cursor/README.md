# Cursor 配置说明

本目录存放 Cursor 相关配置与规则，用于让 Cursor 在项目中自动遵守通用开发流程。

## 文件说明

- `CURSOR.md`：Cursor 入口说明
- `workflow-map.md`：流程映射
- `prompts.md`：常用启动提示
- `rules/`：分层规则文件
- `agents/`：Cursor 侧执行角色
- `skills/`：Cursor 侧技能目录
- `feedback/`：Cursor 侧反馈层
- `hooks/`：Cursor 侧检查脚本

## 规则拆分

- `rules/trigger-rules.md`：触发判断规则
- `rules/stage-rules.md`：阶段执行规则
- `rules/review-rules.md`：审查规则
- `rules/commit-rules.md`：提交与推送规则
- `rules/feedback-rules.md`：反馈与进化规则

## 使用方式

在 Cursor 中打开项目后，优先参考本目录内容，并按以下顺序推进：

需求 → 设计 → 计划 → 开发 → 审查 → 修复 → 发布 → 反馈 → 进化

## 说明

本目录负责 Cursor 相关配置，与 `README.md` 中的 Claude Code 定位相互独立。
