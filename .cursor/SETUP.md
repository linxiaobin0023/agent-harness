# Cursor 配置步骤

1. 在项目根目录创建 `.cursor/` 目录。
2. 在 `.cursor/` 下保留以下文件和目录：
   - `CURSOR.md`
   - `workflow-map.md`
   - `prompts.md`
   - `rules/`
   - `agents/`
   - `skills/`
   - `feedback/`
   - `hooks/`
3. 确保 `CURSOR.md` 作为入口文件存在。
4. 确保 `rules/` 中包含阶段、审查、提交、反馈相关规则。
5. 确保 `agents/`、`skills/`、`feedback/`、`hooks/` 与主流程对应。
6. 在 Cursor 中打开项目后，先读取 `.cursor/CURSOR.md`，再按流程推进。
