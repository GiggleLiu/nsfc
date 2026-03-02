# Design: Pivot Proposal to Software-Centric Framing

**Date**: 2026-03-03
**Status**: Approved
**Approach**: Compiler-First Reframe (Approach A)

---

## Summary

Reposition the NSFC proposal from quantum-computing-centric to software-engineering-centric. The **problem reduction compiler** (backed by the existing `problem-reductions` Rust crate) becomes the star; quantum platforms become the most challenging compilation backends.

## New Title

**中文**: LLM辅助组合优化问题规约的自动发现、验证与编译
**英文**: LLM-assisted Automatic Discovery, Verification and Compilation of Problem Reductions for Combinatorial Optimization

## Core Narrative Shift

| Aspect | Before (quantum-centric) | After (software-centric) |
|--------|--------------------------|--------------------------|
| **Star** | Quantum hardware platforms | Problem reduction compiler |
| **LLM role** | Gadget generator for quantum encodings | Automated program synthesizer for reduction rules |
| **ILP role** | Verification of lattice encodings | Formal verification oracle in synthesis loop |
| **Quantum** | The motivation and destination | Most challenging compilation backend |
| **Existing work** | UnitDiskMapping.jl, physics papers | `problem-reductions` Rust crate (20+ problems, 46 rules, MCP server) |
| **Audience language** | Hamiltonian, qubit overhead, Rydberg blockade | Compiler passes, IR, type-safe rules, TDD synthesis |

## 立项依据 (Section 1) — New Structure

### 1. 组合优化的普遍需求与规约瓶颈
- Combinatorial optimization is ubiquitous (logistics, chip design, scheduling, network)
- Specialized solvers exist (SAT, ILP, quantum annealer, Rydberg arrays) but mapping problems requires expert knowledge
- This is the "reduction bottleneck" — the gap between problem formulation and solver-ready representation
- **Opens with a problem every CS reviewer understands**

### 2. 问题规约：编译器视角
- Reduction as compilation: source problem → IR → target solver
- Cost model is polynomial (not constant as in classical compilers)
- Introduce the reduction graph, Pareto optimality
- **Introduce `problem-reductions` crate** as existing infrastructure (20+ problems, 46 rules, Dijkstra path optimizer)
- Compiler analogy: front-end (problem recognition) → middle-end (reduction path optimization) → back-end (hardware parameter generation)

### 3. 量子优化平台：最具挑战性的编译目标
- Rydberg atoms: ~1 subsection, simplified physics, focus on WHY it's a hard compilation target (geometric constraints, encoding overhead, energy gap)
- D-Wave: ~1 subsection, focus on minor embedding challenge as a compilation problem
- Both presented as backends that make the compiler problem interesting and non-trivial

### 4. AI编程能力的突破
- FunSearch, AlphaEvolve, Claude-builds-C-compiler
- Reframed as "automated program synthesis" — LLM can synthesize correct programs
- Reduction rule synthesis fits this paradigm

### 5. 规模化规约发现的方法论挑战
- Three challenges: combinatorial explosion, correctness verification, scale vs quality
- Same content, software-flavored language

### 6. 测试驱动的规约发现方法
- LLM-driven TDD approach
- ILP as verification oracle
- "Test-driven" is a software concept reviewers immediately recognize

### 7. 核心科学问题与价值
- Same four sub-problems S1-S4
- S3 (compiler system) elevated to more prominent position
- Value framed in terms of software engineering contribution + quantum application

## 研究内容 (Section 2) — New Structure

### Research Content 1: 规约代价模型与路径优化 (Compiler Optimization Theory)
- Same content, positioned as "compiler optimization theory"
- Analogy to instruction selection in classical compilers
- Polynomial cost model, Pareto optimality, path search algorithms

### Research Content 2: LLM驱动的规约规则自动合成 (Automated Rule Synthesis)
- Rename "发现" → "合成(synthesis)" — a software term
- TDD loop: spec → LLM generates candidate → ILP verifies → feedback → iterate
- Evolutionary program synthesis (AlphaEvolve-inspired)
- Each rule comes with: executable mapping, cost polynomial, ILP correctness proof

### Research Content 3: 问题规约编译器设计与实现 (The Centerpiece)
- **Existing infrastructure**: `problem-reductions` crate
  - 20+ problem types across 5 categories
  - 46 reduction rules already implemented
  - Rust type system guarantees reduction rule correctness at compile time
  - Dijkstra path optimizer with custom cost functions
  - MCP server for LLM agent integration
  - CLI tool for interactive exploration
  - Inventory-based registration for extensibility
- **Target state**: 100+ rules, formal verification evidence, hardware backends
- Four modules: knowledge base, path planner, reduction executor, hardware parameter generator
- This section should be ~30% longer than current version to showcase the software engineering depth

### Research Content 4: 量子优化后端验证 (Backend Validation)
- Rename from "实验验证" → "后端验证"
- It's testing a compiler on real hardware, not doing physics experiments
- Same validation content (Rydberg, D-Wave), but framed as compiler backend testing

## Key Terminology Mapping

| Current (quantum) | New (software) |
|-------------------|----------------|
| 小工具 (gadget) | 规约规则 / 编译转换规则 (reduction rule / compilation pass) |
| 量子比特开销 | 资源开销 (resource overhead) — qubits as specific instance |
| 哈密顿量表示 | 目标求解器的原生表示 (target solver's native representation) |
| 编码方案 | 编译后端 (compilation backend) |
| 硬件验证 | 后端验证 (backend validation) |
| 规约发现 | 规约合成 (reduction synthesis) |

## Files to Modify

1. **`sections/一依据.tex`** — Major rewrite, new structure as above
2. **`sections/二内容.tex`** — Moderate rewrite, reframe and reorder
3. **`sections/三1基础.tex`** — Update to prominently feature `problem-reductions` crate
4. **`config.yaml`** — Update title, directions
5. **`AGENTS.md`** — Update research topic, terminology, key references
6. **`CLAUDE.md`** — Will auto-update via AGENTS.md reference
7. **`figures/problemtree.pdf`** — May need update (optional)
8. **`figures/framework.pdf`** — May need update (optional)

## What Stays the Same

- Overall four-part research structure (theory → method → system → validation)
- LLM + ILP core methodology
- Quantum platform content (simplified, not removed)
- Applicant's background and qualifications
- 30-page constraint
- All LaTeX formatting and template requirements

## Estimated Scope

- 立项依据: ~70% rewrite (restructure + new framing paragraphs + simplified quantum)
- 研究内容: ~50% rewrite (reframe + expand compiler section + condense quantum validation)
- 研究基础: ~30% rewrite (add problem-reductions crate details)
- Other sections: minor updates
