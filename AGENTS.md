# NSFC 2026 面上项目 - AI 项目指令

本项目为国家自然科学基金2026年度面上项目申请书，研究主题为「LLM辅助面向物理计算平台的问题规约自动发现与验证」。

---

## 项目概览

### 研究主题

**LLM辅助面向物理计算平台的问题规约自动发现与验证**
(LLM-assisted Automatic Discovery and Verification of Problem Reductions for Physical Computing Platforms)

### 核心科学问题

如何利用大语言模型自动发现、验证和优化面向物理计算平台的问题规约规则？

### 三个研究方向

1. **LLM辅助规约小工具自动发现** - 利用LLM + ILP（整数线性规划）自动生成和验证规约小工具
2. **规约正确性形式化验证** - 与Lean4/mathlib定理证明器集成的形式化验证
3. **硬件感知规约优化** - 针对里德堡原子阵列、D-Wave量子退火机、张量网络的硬件感知优化

### 目录结构

```
nsfc2026/
├── 面上项目-正文-2026.tex   # 主文档（勿修改）
├── nsfc.sty                 # 核心模板样式
├── sections/                # 内容文件（编辑这里）
│   ├── 一依据.tex           # 立项依据
│   ├── 二内容.tex           # 研究内容
│   ├── 三*.tex              # 研究基础
│   ├── 四*.tex              # 其他说明
│   └── 个性化设置.sty       # 用户设置
├── figures/                 # 图片
├── ref.bib                  # 参考文献
├── bibs/                    # GB/T 7714 引用样式
├── fonts/                   # 中文字体
├── references/              # 参考文献PDF
│   └── md/                  # PDF转Markdown
├── docs/                    # 文档
│   └── plans/               # 实施计划
├── skills/                  # 项目专用技能
├── config.yaml              # 项目配置
├── CLAUDE.md                # Claude Code 项目指令
├── AGENTS.md                # 通用AI项目指令
└── Makefile                 # 构建命令
```

---

## 核心工作流

### 任务理解

- 理解用户的真实需求和意图（内容撰写、格式调整、编译问题等）
- 确认任务范围和预期输出（PDF文档、LaTeX代码、文档说明等）
- 识别可能的依赖和约束（宏包版本、编译引擎、页数限制等）

### 执行流程

内容理解 → 文件编辑 → 编译验证 → 格式检查 → 输出交付

**计划制定原则**：
- 任务按优先级从上到下罗列，不使用时间限制表述（如"第1-2周"等）
- AI 可快速完成任务，无需按周/月规划时间线
- 优先级基于任务依赖关系和重要性排序

### 输出规范

- LaTeX 代码应遵循项目模板规范
- 文档更新应保持格式一致性
- 编译结果应无错误（警告可接受）

---

## 工程原则

| 原则 | 核心思想 | 在本项目中的体现 |
|------|----------|------------------|
| **KISS** | Keep It Simple, Stupid | 追求极致简洁，避免过度设计 |
| **YAGNI** | You Aren't Gonna Need It | 只实现当前需要的功能 |
| **DRY** | Don't Repeat Yourself | 相似逻辑应抽象复用 |
| **奥卡姆剃刀** | 如无必要，勿增实体 | 优先选择最简单的解决方案 |

**原则冲突时的决策优先级**：
1. **正确性 > 一切**
2. **简洁性 > 灵活性**
3. **清晰性 > 性能**

---

## 通用规范

### 默认语言

- 与用户对话：简体中文
- 撰写标书正文：简体中文（正式学术语言）
- 代码注释：中文或英文均可

### 变更边界

- 仅修改与当前任务直接相关的文件
- 不主动添加用户未要求的功能
- 保持现有代码风格和结构
- **勿修改** `面上项目-正文-2026.tex` 主文档
- **勿修改** NSFC规定的章节标题

---

## LaTeX 技术规范

### 编译规范

**PDF 渲染4步法**：为保证参考文献和交叉引用的正确性，始终按以下顺序编译：

```
xelatex → bibtex → xelatex → xelatex
```

| 步骤 | 作用 |
|------|------|
| `xelatex` (第1次) | 生成辅助文件（.aux 等） |
| `bibtex` | 处理参考文献 |
| `xelatex` (第2次) | 解析文献引用 |
| `xelatex` (第3次) | 确保所有交叉引用正确 |

**快捷命令**：
- `make pdf` - 单次编译（日常使用）
- `make clean && make pdf` - 清理后编译

**使用原则**：
- 每次修改参考文献后必须重新执行完整4步
- 仅修改正文时可省略 bibtex 步骤
- 使用 `-interaction=nonstopmode` 参数避免编译中断

### 写作规范

- 使用 `\textbf{}` 强调关键术语
- 使用 `\cite{}` 引用文献（定义在 `ref.bib`）
- 图片放在 `figures/`，使用 `\includegraphics{filename}`
- **正文不超过30页**

---

## 申请人背景

**刘金国博士**，香港科技大学（广州）助理教授

- 博士：南京大学（导师：王强华教授）
- 博后：中科院物理所（导师：王磊研究员）、哈佛大学（导师：Mikhail Lukin教授）
- 工业：QuEra Computing Inc. 顾问
- 软件：Yao.jl, GenericTensorNetworks.jl, UnitDiskMapping.jl

### 代表性成果

| 引用键 | 成果 |
|--------|------|
| `Ebadi2022Science` | 里德堡原子量子优化 (Science, 289 qubits) |
| `Liu2021PRL` | 热带张量网络 (PRL) |
| `Liu2023SIAM` | 通用张量网络 (SIAM) |
| `Nguyen2023PRXQuantum` | King's subgraph编码 (PRX Quantum) |
| `Pan2025Triangular` | 三角晶格编码 (in review) |
| `Luo2020Quantum` | Yao.jl 量子模拟器 |

---

## 关键术语表

| 中文 | 英文 | 说明 |
|------|------|------|
| 问题规约 | problem reduction | 将一个问题映射到另一个问题 |
| 小工具 | gadget | 编码源问题约束的基本结构 |
| 里德堡原子阵列 | Rydberg atom arrays | 量子计算平台 |
| D-Wave量子退火机 | D-Wave quantum annealer | 量子退火硬件 |
| 张量网络 | tensor networks | 计算方法 |
| QUBO | Quadratic Unconstrained Binary Optimization | 二次无约束二值优化 |
| MIS | Maximum Independent Set | 最大独立集 |
| 单位圆盘图 | unit-disk graph | 里德堡阵列的原生问题 |

---

## 章节状态

| 文件 | 内容 | 状态 |
|------|------|------|
| `一依据.tex` | 立项依据 | ✅ 已完成 |
| `二内容.tex` | 研究内容 | ✅ 已完成 |
| `三1基础.tex` | 研究基础 | ✅ 已完成 |
| `三2条件.tex` | 工作条件 | ✅ 已完成 |
| `三3正承担.tex` | 正在承担项目 | ✅ 已完成 |
| `三4已完成.tex` | 已完成项目 | ✅ 已完成 |
| `四*.tex` | 其他说明 | ✅ 已完成 |

---

## 文档与版本管理

### 变更记录规范

项目中的重要更新应在 Git 提交信息中清晰记录。

### 提交信息格式

```
<type>: <description>

[optional body]

🤖 Generated with [Claude Code](https://claude.com/claude-code)

Co-Authored-By: Claude Opus 4.5 <noreply@anthropic.com>
```

**类型**：
- `feat`: 新增内容
- `fix`: 修复问题
- `docs`: 文档更新
- `style`: 格式调整
- `refactor`: 重构
- `chore`: 杂项

---

## 文档更新原则

当需要更新本文档时，遵循以下原则：

1. **理解意图**：首先理解用户需求背后的意图
2. **定位生态位**：每条规则都应找到其在整个文档结构中的位置
3. **协调生长**：更新一个部分时，检查并同步更新相关部分
4. **保持简洁**：避免冗余，保持文档精炼

---

**提示**：修改本文档后，请确保 `CLAUDE.md` 与 `AGENTS.md` 的核心内容保持一致。
