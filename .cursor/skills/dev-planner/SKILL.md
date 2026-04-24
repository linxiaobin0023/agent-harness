# dev-planner

## 目标

读取需求、设计和设计图之后，把项目拆成可执行的 Phase 与 Task，并生成可跨 session 续接的 `DEV-PLAN.md`。

## 适用场景

- Product-Spec、Design-Brief、设计图都已完成
- 需要开始真正拆解开发任务
- 需要为后续实现提供稳定锚点

## 输入

- `Product-Spec.md`
- `Design-Brief.md`
- 设计图
- 当前项目结构

## 输出

- `DEV-PLAN.md`
- `DEV-PLAN-CHANGELOG.md`
- Phase / Task 拆分
- 依赖、风险、验收点

## 工作方式

1. 先调研技术栈和现成组件，再拆 Phase
2. 把每个 Phase 拆成可验证的 Task
3. 明确每个阶段的交付物与退出条件
4. 让 `DEV-PLAN.md` 成为跨 session 的进度锚点

## 问题维度

- 是否有清晰的 Phase 边界
- Task 是否足够小
- 依赖是否明确
- 风险是否可控
- 验收条件是否可执行

## 重点检查项

- 是否存在过大的任务
- 是否存在不可验证的步骤
- 是否与需求和设计对齐
- 是否能支持后续实现和审查

## 交接标准

- Phase 与 Task 已拆清楚
- 依赖关系已明确
- 已准备好交给 `dev-builder`

## 退出条件

- Phase 与 Task 已拆清楚
- 依赖关系已明确
- 可以进入 `dev-builder`
