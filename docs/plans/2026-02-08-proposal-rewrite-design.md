# NSFC 2026 Proposal Rewrite Design

## Overview

This document captures the redesigned vision for the NSFC 面上项目 proposal, shifting from "LLM-assisted gadget discovery" to a unified "Problem Reduction Compiler" framing.

## New Title

**面向量子优化平台的问题规约编译器：理论、方法与系统**

(Problem Reduction Compiler for Quantum Optimization Platforms: Theory, Methods, and Systems)

## Core Narrative

### The Problem

量子优化平台（里德堡原子阵列、D-Wave退火机）正走向实用化，但每种平台仅能原生求解特定问题（MIS、QUBO）。将实际应用中的NP难问题有效映射到这些平台，需要经过**多步规约链**。例如，将图着色问题映射到里德堡平台可能需要：

```
图着色 → MAX-SAT → MIS → 单位圆盘图MIS
```

### Core Insight

规约不是单步操作，而是在"问题空间"中的**路径规划问题**。不同路径有不同的资源开销，最优路径取决于问题规模、硬件约束和求解器能力。

### Project Goal

构建一个**问题规约编译器**，让用户只需指定"待求解问题"和"目标平台"，系统自动发现最优规约路径并生成可执行的硬件映射。

## Research Framework

### 研究内容一：规约编译的代价模型与路径优化

**编译器类比**：

传统编译器将高级语言转换为机器码，需要在多种等价指令序列中选择代价最低的方案。本项目的规约编译器面临类似问题：将用户问题"编译"到量子硬件的原生问题表示，需要在多条规约路径中选择最优方案。

**代价模型**：

与经典编译器的常数代价模型不同，规约代价是**问题规模的函数**。例如：
- 将 n 顶点图嵌入三角晶格：O(n²) 原子
- 3-SAT 到 MIS：每个子句引入常数个顶点

这意味着最优路径可能随问题规模变化——小规模时路径A更优，大规模时路径B更优。

**研究问题**：

1. **代价比较**：何时能判定一条路径渐进优于另一条？
2. **路径搜索**：如何高效搜索包含100+节点的规约图？
3. **多目标权衡**：当存在多个规模参数时，如何呈现Pareto最优路径供用户选择？

**预期成果**：建立规约编译的代价模型理论，开发路径优化算法，集成到编译器的路径选择模块。

---

### 研究内容二：LLM驱动的大规模规约发现与验证

**核心挑战**：

构建覆盖大量问题的规约图需要发现上百条规约规则，传统人工方法需要数年。本项目提出**LLM驱动的测试先行开发方法**，将规约发现从"专家手工设计"转变为"人机协作的自动化流水线"。

**技术路线**：

1. **测试先行的规约发现**
   - 首先定义规约的形式化规范（输入/输出类型、正确性性质）
   - LLM生成候选规约代码
   - 自动化测试套件验证正确性（小规模穷举 + 随机测试）
   - 失败用例反馈给LLM迭代改进

2. **ILP精确验证**
   - 对通过测试的候选规约，使用整数线性规划进行形式化验证
   - 验证解保持性和解可提取性
   - 自动生成开销多项式的精确表达式

3. **进化式优化**
   - 借鉴AlphaEvolve范式，对已验证规约进行变异和优化
   - 多目标优化：最小化开销、最大化质量因子、保持正确性

**规模目标**：项目周期内完成100+规约规则的发现与验证，形成开源知识库。

---

### 研究内容三：问题规约编译器设计与实现

**系统定位**：

核心产出是一个**开源问题规约编译器**，为量子优化平台的使用者提供"一键映射"服务。用户只需指定：
- 输入：待求解的组合优化问题实例
- 目标：量子硬件平台（里德堡原子阵列或D-Wave）

系统自动完成：问题识别 → 路径规划 → 逐步规约 → 硬件映射代码生成。

**系统架构**：

```
用户问题 → [问题识别] → [路径规划器] → [规约执行器] → 硬件可执行代码
                ↑              ↑              ↑
            问题分类器    代价模型+搜索    规约规则库(100+)
```

**核心模块**：

1. **规约知识库**：存储问题定义和规约规则，每条规则附带正确性证明和代价多项式
2. **路径规划器**：基于研究内容一的理论，实现最优路径搜索算法
3. **规约执行器**：逐步应用规约规则，处理实例级别的转换
4. **后端代码生成**：针对里德堡（原子坐标）和D-Wave（QUBO矩阵）生成可执行输入

**开源生态**：基于申请人的 `problem-reductions` 库扩展，与 `GenericTensorNetworks.jl`、`UnitDiskMapping.jl` 集成。

---

### 研究内容四：量子优化平台实验验证

**验证目标**：

规约编译器的价值最终体现在实际量子硬件上的求解效果。本研究将与国际合作者开展实验验证，证明自动发现的规约路径确实能高效求解实际问题。

**里德堡原子阵列（主要平台）**：

- 合作方：Harvard/MIT Lukin团队、QuEra Computing
- 验证内容：
  - 三角晶格编码的实验实现（已有前期工作基础）
  - 自动发现的新型小工具在真实硬件上的性能
  - 不同规约路径的求解成功率对比
- 目标问题：图着色、MAX-CUT、调度问题等经典NP难问题

**D-Wave量子退火机（次要平台）**：

- 平台：D-Wave Leap云服务
- 验证内容：
  - 编译器生成的QUBO嵌入与人工设计的对比
  - 自动优化的链强度参数效果
  - 大规模问题（1000+变量）的求解质量

**验证指标**：

1. **正确性**：求解结果是否为原问题的有效解
2. **效率**：相比人工设计规约，资源开销是否更低
3. **自动化程度**：从问题输入到硬件执行的端到端时间

---

## Comparison: Old vs New

| 方面 | 当前版本 | 新版本 |
|------|----------|--------|
| 核心概念 | LLM辅助小工具发现 | 问题规约编译器 |
| 理论深度 | 较弱 | 多项式代价模型+路径优化 |
| 方法创新 | LLM+ILP | LLM驱动的测试先行开发 |
| 系统产出 | 分散的工具 | 统一的编译器系统 |
| 规模目标 | 未明确 | 100+规约规则 |
| 平台定位 | 三平台并重 | 量子优化为主(Rydberg+D-Wave) |

## Four Innovation Points

1. **理论创新**：首次建立规约路径的代价模型理论，将规约选择问题形式化为多项式图上的路径优化

2. **方法创新**：提出LLM驱动的测试先行规约发现方法，实现人工难以企及的规模化

3. **系统创新**：构建首个问题规约编译器，实现从用户问题到量子硬件的自动映射

4. **开源生态**：建立100+规约规则的知识库，降低量子优化平台使用门槛

## One-Line Summary

> 本项目构建"问题规约编译器"，让用户像使用传统编译器一样使用量子优化平台——只需描述问题，无需了解硬件细节。

## Implementation Notes

### Files to Modify

1. **sections/一依据.tex** - Rewrite with new narrative (compiler framing, practical impact)
2. **sections/二内容.tex** - Restructure into 4 research directions
3. **sections/三1基础.tex** - Update to emphasize compiler-relevant prior work
4. **figures/framework.tex** - New diagram showing compiler architecture

### Key Changes to Make

- Replace "LLM辅助...发现与验证" framing with "问题规约编译器"
- Add theoretical section on cost models and path optimization
- Emphasize "test-driven AI development" methodology
- De-emphasize tensor networks (mention as classical baseline only)
- Add compiler system architecture diagram
- Update innovation points to reflect new framing

### References to Add

- Compiler optimization literature (for cost model analogy)
- Shortest path algorithms on weighted graphs
- Test-driven development methodology papers

---

*Design document created: 2026-02-08*
*Status: Ready for implementation*
