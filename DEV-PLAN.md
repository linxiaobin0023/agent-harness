# DEV-PLAN

## 1. 项目定位

本项目的目标是把需求、设计、开发、审查、修复、发布与反馈进化串成一个可控的开发流程。

## 2. 当前目标

### Phase 0：最小可用闭环

先跑通以下最小流程：

1. 写出需求基准
2. 写出设计基准
3. 写出开发计划
4. 能按 Task 实现代码
5. 能在每个 Task 后触发审查
6. 能记录反馈并沉淀进化建议

## 3. 现有结构

### 已落地的基础文件

- `README.md`：目录总览与项目说明
- `Product-Spec.md`：需求基准模板
- `Product-Spec-CHANGELOG.md`：需求变更记录
- `Design-Brief.md`：设计规范模板
- `Design-Brief-CHANGELOG.md`：设计规范变更记录
- `DEV-PLAN.md`：当前开发计划
- `DEV-PLAN-CHANGELOG.md`：开发计划变更记录

### `.claude/` 结构

- `CLAUDE.md`：主调度入口
- `agents/`：4 个 Sub-Agent 职责文件
- `hooks/`：6 个反馈传感器脚本
- `skills/`：8 个核心 Skill
- `feedback/`：反馈与进化数据

## 4. 已完成的 Harness 骨架

### 4.1 调度层

- `CLAUDE.md` 负责路由、阶段判断、指令分发

### 4.2 执行层

- `implementer`
- `code-reviewer`
- `feedback-observer`
- `evolution-runner`

### 4.3 引导层

- `product-spec-builder`
- `design-brief-builder`
- `design-maker`
- `dev-planner`
- `dev-builder`
- `bug-fixer`
- `code-review`
- `release-builder`

### 4.4 检查层

- `pre-commit-check`
- `auto-push`
- `stop-gate`
- `detect-feedback-signal`
- `mark-review-needed`
- `check-evolution`

### 4.5 进化层

- `FEEDBACK-INDEX.md`
- `FEEDBACK-LOG.md`
- `EVOLUTION.md`

## 5. Phase 0 执行路线

### Step 1：需求确认

- 确认当前项目要解决什么问题
- 明确范围边界与非目标
- 输出或更新 `Product-Spec.md`

### Step 2：设计规范

- 明确视觉风格、交互原则、状态设计
- 输出或更新 `Design-Brief.md`

### Step 3：开发计划

- 基于需求与设计拆分 Phase
- 将 Phase 细化为 Task
- 明确依赖、风险、验收点

### Step 4：实现 Task

- 使用 `dev-builder` 逐个 Task 实现
- 每完成一个 Task 就做局部验证

### Step 5：审查闭环

- 每个 Task 完成后执行 `code-review`
- Stage 1 先查功能完整性
- Stage 2 再查代码质量

### Step 6：修复闭环

- 如果审查失败，进入 `bug-fixer`
- 一次只修一个逻辑点
- 修复后重新审查

### Step 7：反馈沉淀

- 把用户反馈、Review 发现的问题写入 `feedback`
- 形成进化建议

## 6. 交付准则

一个 Task 结束前必须满足：

- 代码已实现
- 局部验证已通过
- 审查已通过或已明确进入修复
- 相关反馈已记录

一个 Phase 结束前必须满足：

- Phase 内所有 Task 已完成
- 集成验证已通过
- 审查问题已清空
- 开发计划状态已更新

## 7. 后续可扩展项

当最小闭环跑通后，再逐步增强：

- 更完整的反馈记录格式
- 更严格的审查模板
- 更细的发布流程
- 更强的进化规则
- 多项目复用能力

## 8. 备注

当前 `DEV-PLAN.md` 作为主开发计划锚点，后续每次需求变化都要先更新这里，再进入实现。
