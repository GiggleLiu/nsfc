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

**LLM辅助组合优化问题规约的自动发现、验证与编译**

三个子目标（S1-S3）：
1. **S1** 规约编译器与路径优化理论（多变量多项式代价、Pareto最优路径、端到端编译器系统）
2. **S2** LLM驱动的规约规则自动合成（智能体技能集 + 智能体编程 + 往返测试 + 整数规划证明）
3. **S3** 硬件加速器后端验证（里德堡原子阵列/D-Wave量子退火机）

### 核心概念

- **Agentic coding**：有规划的AI编程范式（vs. vibe coding），通过系统化测试保障可靠性
- **往返测试(round-trip test)**：直接求解A vs. 规约到B→求解B→提取回A，结果必须一致
  - 整数规划求解器 = 主验证器（大多数问题已有到整数规划的规约路径）
  - 穷举求解器 = 辅助验证器（小规模，验证整数规划规约本身）
- **problem-reductions**：申请人开发的Rust规约编译器（20+问题类型、26条非平凡规约、MCP服务器）

### 核心引用

`Ebadi2022Science`, `Liu2021PRL`, `Liu2023SIAM`, `Nguyen2023PRXQuantum`(共同第一作者, 被引150+), `Pan2025Triangular`, `AlphaEvolve2025`, `Carlini2026CCC`, `ProblemReductions2025`

### 写作规范

- 统一术语：智能体编程/agentic coding（非"AI编程"）、规约合成（非"规约发现"）
- 概念先定义再使用（如质量因子$Q$、MCP全称等）
- 避免Rust实现细节的jargon（如inventory、ReduceTo trait），用通俗语言描述
- 引用数据不重复（如"被引150+次"仅在首次提及KSG编码时出现）

## 标书审查清单

每次大规模修改后，按以下清单逐项检查：

### 数字一致性
- [ ] 同一数字在所有出现位置保持一致（规约规则数26/150+、问题类型数100+、论文数30余篇等）
- [ ] 摘要（NSFC-ABSTRACTS.md）与正文数字同步
- [ ] 年度计划中的论文数加总 = 总承诺论文数（当前4-6篇）
- [ ] S1/S2/S3各方向承诺与总目标对齐

### 事实准确性
- [ ] 论文数、引用数、h-index与Google Scholar一致
- [ ] 合作者和所属机构信息准确、无已删除的过时引用
- [ ] 在合作项目中的角色标注正确（PI/骨干/参与人）
- [ ] Science论文角色：经典算法分析（非问题映射设计）
- [ ] 开源软件星标数准确（Yao.jl千余、非"近千"）

### 写作质量
- [ ] 无AI套话：综上所述、完整链条、全栈能力、改变格局、深刻理解、坚实基础、突破性进展
- [ ] `——`（中文破折号）不过度使用，优先用 `，` `:` `。` `即`
- [ ] 技术代码名用中文描述（规约合成/往返测试/自动化集成，非add-model/add-rule）
- [ ] 无不必要的英文（@ 等非正式符号）

### LaTeX格式
- [ ] 引用前有非断空格：`~\cite{}` 而非 `\cite{}`
- [ ] 手动编号列表无跳号
- [ ] 编译无错误，25页以内

### 指标承诺
- [ ] 论文数合理（面上4-6篇），标注目标期刊/会议档次
- [ ] 包含人才培养指标（培养博士研究生2名）
- [ ] S3验证目标：至少2类NP难问题
- [ ] 不过度承诺（"达到或超越" → "评估差异"）

## Skills

项目自定义技能位于 `.claude/skills/`，可在对话中调用。

| 技能 | 描述 | 入口 |
|------|------|------|
| `check-review-alignment` | AI 驱动的综述引用语义核查与自动渲染 | `python3 scripts/run_ai_alignment.py --work-dir <dir> --prepare/--render` |
| `transfer_old_latex_to_new` | NSFC LaTeX 标书跨版本智能迁移 | `python scripts/run.py analyze/apply/compile/restore` |
| `nsfc-research-content-writer` | 研究内容+创新+年度计划编排写作 | Skill 调用，输出到 `extraTex/2.*.tex` |
| `nsfc-justification-writer` | 科研立项依据写作/重构 | `python scripts/run.py coach/apply-section/diagnose` |
| `nsfc-research-foundation-writer` | 研究基础+工作条件+风险应对写作 | Skill 调用，输出到 `extraTex/3.*.tex` |
| `nsfc-abstract` | 中英文摘要生成（中文≤400字；英文≤4000字符） | Skill 调用，输出到 `NSFC-ABSTRACTS.md` |
| `nsfc-bib-manager` | 引用与 Bib 管理，避免幻觉引用 | Skill 调用 |
| `systematic-literature-review` | 相关性评分驱动的系统综述流水线 | `python scripts/pipeline_runner.py --topic "{主题}"` |
| `get-review-theme` | 多源输入的结构化综述主题提取 | Skill 调用，支持 text/yaml/json 输出 |
| `guide-updater` | 项目指南实时更新器 | `/guide-updater --guide-path <路径>` |
| `make_latex_model` | LaTeX 模板高保真优化器（对齐 Word 模板） | `python3 scripts/enhanced_optimize.py --project projects/{project}` |
| `complete_example` | AI 增强版 LaTeX 示例智能生成器 | `/complete_example <project_name> [options]` |
