# NSFC 2026 面上项目 - Claude Code 项目指令

## 核心指令

@./AGENTS.md

## Claude Code 特定说明

### 文件引用规范

在 Claude Code 中引用文件时，使用 markdown 链接语法：
- 文件：`[filename.md](路径/filename.md)`
- 特定行：`[filename.md:42](路径/filename.md#L42)`
- 行范围：`[filename.md:42-51](路径/filename.md#L42-L51)`
- 目录：`[目录名/](路径/目录名/)`

### 任务管理

- 使用 TodoWrite 工具跟踪复杂任务的进度
- 完成任务后及时标记为 completed
- 拆分大任务为可管理的小步骤
- **计划制定**：按优先级从上到下罗列任务点，不使用时间限制表述（如"第1-2周"等）

### 代码变更规范

- 修改代码前先使用 Read 工具阅读文件
- 优先使用 Edit 工具进行精确修改
- 避免不必要的格式化或重构

### 与 AGENTS.md 的关系

- **AGENTS.md**：跨平台通用项目指令（Single Source of Truth）
- **CLAUDE.md**：通过 `@./AGENTS.md` 自动引用 + Claude Code 特定适配
- **维护流程**：修改 AGENTS.md → CLAUDE.md 自动生效

---

## 快速参考

### 构建命令

```bash
make pdf          # 编译 PDF（XeLaTeX）
make clean        # 清理辅助文件
make refs-md      # 转换参考文献 PDF 为 Markdown
make bib-md       # 转换 ref.bib 为 Markdown
```

### 完整编译（含参考文献）

```bash
xelatex 面上项目-正文-2026.tex
bibtex 面上项目-正文-2026
xelatex 面上项目-正文-2026.tex
xelatex 面上项目-正文-2026.tex
```

### 项目结构

| 目录/文件 | 用途 |
|-----------|------|
| `sections/` | 内容文件（主要编辑区域） |
| `figures/` | 图片资源 |
| `ref.bib` | 参考文献 |
| `docs/plans/` | 实施计划 |
| `references/md/` | 文献 Markdown |

### 关键约束

- **正文不超过30页**
- **勿修改** `面上项目-正文-2026.tex`
- **勿修改** NSFC 规定的章节标题
- **必须使用 XeLaTeX** 编译

### 章节文件

| 文件 | 内容 |
|------|------|
| `一依据.tex` | 立项依据 |
| `二内容.tex` | 研究内容 |
| `三1基础.tex` | 研究基础 |
| `三2条件.tex` | 工作条件 |
| `三3正承担.tex` | 正在承担项目 |
| `三4已完成.tex` | 已完成项目 |
| `四*.tex` | 其他说明 |

### 配置文件

编辑 `sections/个性化设置.sty`：
- 标题高亮色：`\definecolor{HighLight}{RGB}{r,g,b}`
- 正文字体：楷体 (`\MS@kaitrue`) 或 宋体 (`\MS@songtrue`)
- 内容可见性：`\MS@ontrue` (显示) 或 `\MS@offtrue` (仅结构)

---

## 研究主题速查

**LLM辅助面向物理计算平台的问题规约自动发现与验证**

三个研究方向：
1. LLM辅助规约小工具自动发现（LLM + ILP）
2. 规约正确性形式化验证（Lean4/mathlib）
3. 硬件感知规约优化（Rydberg/D-Wave/TN）

核心引用：`Ebadi2022Science`, `Liu2021PRL`, `Liu2023SIAM`, `Pan2025Triangular`, `AlphaEvolve2025`
