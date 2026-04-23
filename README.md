# Agent Harness

这是一个面向通用软件项目的开发流程框架，用于把“需求 → 设计规范 → 设计图 → 开发计划 → 代码实现 → 代码审查 → 自动修复 → 发布 → 反馈进化”串成一个可控、可审查、可迭代的工程闭环。

## 核心理念

- **前馈引导**：在动手前先把需求、设计和计划说清楚
- **反馈控制**：在提交、停止、切换会话等关键节点自动检查
- **上下文隔离**：不同任务使用独立 Sub-Agent，避免记忆污染
- **持续进化**：把反馈沉淀为规则、Skill 和新的工作流能力

## 五层结构

### 1. 调度层
- `CLAUDE.md`
- 职责：判断阶段、路由流程、调度 Skill、派发 Sub-Agent、控制停止与进化

### 2. 执行层
- `implementer`
- `code-reviewer`
- `feedback-observer`
- `evolution-runner`
- 职责：实现、审查、记录、进化

### 3. 引导层
- `product-spec-builder`
- `design-brief-builder`
- `design-maker`
- `dev-planner`
- `dev-builder`
- `bug-fixer`
- `code-review`
- `release-builder`
- 职责：把意图转成可执行任务结构

### 4. 检查层
- `pre-commit-check`
- `auto-push`
- `stop-gate`
- `detect-feedback-signal`
- `mark-review-needed`
- `check-evolution`
- 职责：在关键节点自动触发检查，形成反馈控制

### 5. 进化层
- `FEEDBACK-INDEX.md`
- `FEEDBACK-LOG.md`
- `EVOLUTION.md`
- 职责：记录反馈、索引反馈、升级规则、形成 Steering Loop

## 目录结构

```text
project/                              # 当前项目根目录
├── Product-Spec.md                  # 当前项目的需求基准文档
├── Product-Spec-CHANGELOG.md        # 当前项目的需求变更记录
├── Design-Brief.md                  # 当前项目的设计规范文档
├── Design-Brief-CHANGELOG.md        # 当前项目的设计变更记录
├── DEV-PLAN.md                      # 当前项目的开发计划与 Phase 锚点
├── DEV-PLAN-CHANGELOG.md            # 当前项目的开发计划变更记录
├── README.md                        # 当前项目的说明与目录总览
└── .claude/                         # Agent Harness 配置目录
    ├── CLAUDE.md                    # 主控调度入口
    ├── feedback/                    # 反馈与进化数据目录
    │   ├── FEEDBACK-INDEX.md        # 反馈索引，便于快速加载
    │   ├── FEEDBACK-LOG.md          # 反馈日志，记录原始反馈条目
    │   └── EVOLUTION.md             # 进化规则与升级提案
    ├── agents/                      # 四个 Sub-Agent 职责文件
    │   ├── implementer.md           # 负责编码实现与局部验证
    │   ├── code-reviewer.md         # 负责两阶段代码审查
    │   ├── feedback-observer.md     # 负责记录反馈信号
    │   └── evolution-runner.md      # 负责扫描反馈并生成进化建议
    ├── hooks/                       # 六个反馈传感器脚本
    │   ├── pre-commit-check.sh      # 提交前编译/检查
    │   ├── auto-push.sh             # 提交后自动推送
    │   ├── stop-gate.sh             # 停止前检查是否允许结束
    │   ├── detect-feedback-signal.sh # 检测用户纠正/不满信号
    │   ├── mark-review-needed.sh    # 标记代码变更需要审查
    │   └── check-evolution.sh       # 新 session 启动时检查反馈积累
    └── skills/                      # 八个核心 Skill 目录
        ├── product-spec-builder/     # 需求收集与 Spec 生成
        ├── design-brief-builder/     # 设计规范生成
        ├── design-maker/             # 设计图/原型制作
        ├── dev-planner/              # 开发计划与 Phase 拆分
        ├── dev-builder/              # 代码实现与 Task 执行
        ├── bug-fixer/                # 系统性调试与修复
        ├── code-review/              # 两阶段代码审查
        └── release-builder/          # 构建、发布与交付
```

## 文档职责

### 根目录文档

- `Product-Spec.md`：当前项目的需求基准
- `Product-Spec-CHANGELOG.md`：当前项目的需求变更记录
- `Design-Brief.md`：当前项目的设计规范
- `Design-Brief-CHANGELOG.md`：当前项目的设计变更记录
- `DEV-PLAN.md`：当前项目的开发计划
- `DEV-PLAN-CHANGELOG.md`：当前项目的开发计划变更记录
- `README.md`：项目入口说明

### `.claude/`

- `CLAUDE.md`：总调度入口，负责路由、阶段切换和流程控制
- `feedback/`：反馈与进化数据
- `agents/`：4 个执行角色
- `hooks/`：6 个确定性检查脚本
- `skills/`：8 个通用能力模块

## 推荐落地顺序

如果准备真正开始一个项目，建议按下面顺序推进：

1. 先生成 `Product-Spec.md`
2. 再生成 `Design-Brief.md`
3. 再生成 `DEV-PLAN.md`
4. 然后进入实现、审查、修复、发布
5. 最后把反馈沉淀到 `.claude/feedback/`

## 设计优先级

UI 与功能实现的优先级如下：

1. 设计工具中的设计稿
2. `Design-Brief.md`
3. `Product-Spec.md`

如果实现和设计冲突，优先以设计图为准；如果设计图本身过时，再更新设计稿并记录原因。

## 版本化原则

- 所有关键阶段都保留文档
- 所有需求、设计、计划变更都保留 changelog
- 所有反馈都进入 `.claude/feedback/`
- 所有重复问题都应考虑升级为规则或 Skill

## 下一步建议

如果你要继续推进，我建议下一步开始把这套流程应用到第一个真实项目上，或者进一步细化每个 Skill 的工作协议。
