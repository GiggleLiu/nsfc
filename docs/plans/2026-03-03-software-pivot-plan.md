# Software-Centric Pivot Implementation Plan

> **For Claude:** REQUIRED SUB-SKILL: Use superpowers:executing-plans to implement this plan task-by-task.

**Goal:** Rewrite the NSFC proposal from quantum-computing-centric to software-engineering-centric framing ("Compiler-First" approach), making it accessible to mixed-panel reviewers while preserving quantum content as backend examples.

**Architecture:** The pivot rewrites three main sections (立项依据, 研究内容, 研究基础) using their corresponding project skills (`nsfc-justification-writer`, `nsfc-research-content-writer`, `nsfc-research-foundation-writer`). Each skill takes a structured info form as input. The rewrite proceeds front-to-back: title/config first, then 立项依据, then 研究内容, then 研究基础, then abstract.

**Tech Stack:** LaTeX (XeLaTeX), project-specific skills, `problem-reductions` Rust crate as key reference material.

**Key Reference:** The `problem-reductions` crate at `~/rcode/problem-reductions` provides concrete software evidence: 20+ problem types, 46 reduction rules, Dijkstra path optimizer, MCP server, type-safe Rust architecture.

---

## Task 1: Update Project Metadata

**Files:**
- Modify: `config.yaml`
- Modify: `AGENTS.md`

**Step 1: Update `config.yaml`**

Change the research title and directions:

```yaml
research:
  title_zh: LLM辅助组合优化问题规约的自动发现、验证与编译
  title_en: LLM-assisted Automatic Discovery, Verification and Compilation of Problem Reductions for Combinatorial Optimization

  directions:
    - name: 规约代价模型与路径优化
      description: 将规约选择形式化为多项式代价图上的路径优化（编译器优化理论）
    - name: LLM驱动的规约规则自动合成
      description: 利用LLM + ILP自动合成和验证规约规则（自动化程序合成）
    - name: 问题规约编译器设计与实现
      description: 基于problem-reductions构建端到端编译器系统
```

**Step 2: Update `AGENTS.md`**

Update the following sections in `AGENTS.md`:
- **研究主题**: New Chinese and English titles
- **三个研究方向**: Align with config.yaml directions
- **关键术语表**: Add software-centric terms (编译器/compiler, 规约合成/reduction synthesis, 编译后端/compilation backend)
- **章节状态**: Mark 一依据, 二内容, 三1基础 as "🔄 重写中"

**Step 3: Compile to verify no breakage**

Run: `cd /Users/liujinguo/Documents/nsfc2026 && make pdf`
Expected: PDF compiles successfully (content unchanged at this point)

**Step 4: Commit**

```bash
git add config.yaml AGENTS.md
git commit -m "chore: update project metadata for software-centric pivot"
```

---

## Task 2: Rewrite 立项依据 (Section 1) — Using `nsfc-justification-writer` Skill

**Files:**
- Modify: `sections/一依据.tex`
- Possibly modify: `ref.bib` (if new references needed)

**Skill:** `nsfc-justification-writer`

**Step 1: Prepare the info form**

Provide the following info form to the skill:

```
1. 【研究对象/应用场景】
组合优化问题到专用求解器（量子优化平台、SAT/ILP求解器等）的自动映射系统。
研究对象是"问题规约规则"——将一种NP难问题转化为另一种的映射算法。

2. 【痛点与现有不足（理论层面）】
一句话问题：将实际组合优化问题映射到专用求解器需要深厚专业知识，目前缺乏自动化工具和系统理论。

理论瓶颈：
- 规约代价模型缺失：经典理论关注规约的存在性，不关注最优性；代价是问题规模的多变量多项式，现有编译器理论的常数代价模型不适用
- 规模化发现缺乏系统方法：传统人工设计每条规约需数周至数月，无法规模化；现有AI辅助方法（FunSearch/AlphaEvolve）依赖数值评估，缺乏可证明正确性保障
- 端到端自动化工具链缺失：实验研究者仍需手工设计映射方案，各步骤割裂、无法自动选择最优路径
- 硬件适配缺乏统一框架：不同量子平台（里德堡原子、D-Wave）的映射方法各自独立发展，缺乏统一的编译器抽象

3. 【核心假说】
通过将问题规约建模为编译过程，结合LLM自动合成规约规则并以ILP提供可证明正确性保障，
可以构建覆盖100+规约规则的端到端问题规约编译器，使专用求解器（尤其是量子优化平台）
的使用门槛从"需要领域专家手工设计"降低为"自动化编译"。

4. 【关键科学问题】
S1：多变量多项式代价模型下，如何判定一条规约路径渐进优于另一条？如何高效计算Pareto最优路径集合？
S2：如何利用LLM+ILP的"合成-验证"闭环，在保证数学正确性的前提下实现100+规约规则的自动合成？
S3：如何设计支持增量更新和多后端的规约编译器架构，实现从问题识别到求解器参数生成的端到端自动化？
S4：编译器自动生成的规约方案在量子优化平台上的实际求解效果能否达到或超越手工方案？

5. 【本项目切入点（理论层面）】
将问题规约视为一种"编译"过程，借鉴编译器理论框架（前端-中端-后端），
提出"规约编译器"的统一抽象。关键理论创新是：（1）多变量多项式代价模型
（区别于经典编译器的常数代价），（2）LLM+ILP构成的"合成-精确验证"闭环
（区别于AlphaEvolve的数值评估），（3）基于Rust类型系统的编译时正确性保障。

6. 【拟解决技术/方法概览】
输入：用户的组合优化问题实例 + 目标求解器平台
→ 前端：问题识别与规范化
→ 中端：规约图路径搜索（Dijkstra + Pareto优化）
→ 后端：目标平台参数生成（里德堡原子坐标/D-Wave QUBO矩阵）
→ 验证：ILP精确验证 + 小规模实例穷举 + 量子硬件实测
→ 交付：开源编译器 + 100+规约规则知识库

7. 【前期基础】
- problem-reductions Rust库：20+问题类型、46条规约规则、Dijkstra路径优化器、MCP服务器
- 三角晶格编码(Pan2025Triangular)：首次ILP辅助规约发现，验证计算机辅助方法可行性
- 里德堡量子优化实验(Ebadi2022Science)：289量子比特MIS求解，申请人负责问题映射
- 热带张量网络(Liu2021PRL)：精确求解工具，可用于规约正确性验证
- Yao.jl, GenericTensorNetworks.jl, UnitDiskMapping.jl：完整的开源工具链

8. 【主流路线与代表工作】
- FunSearch (Nature 2024): LLM在函数空间搜索，数值评估
- AlphaEvolve (Google DeepMind 2025): LLM+进化算法，改进20%已知最优解
- Claude构建C编译器 (Carlini 2026): AI编程的系统工程能力
- D-Wave量子优势 (Science 2025): 量子退火的计算优势验证
- KSG编码 (Nguyen2023PRXQuantum): 里德堡原子的通用编码方案
```

**Step 2: Invoke the skill**

Run: `Skill("nsfc-justification-writer")` with the info form above.

**Key reframe instructions for the skill:**
- Section structure should follow the design doc at `docs/plans/2026-03-03-software-pivot-design.md`
- Open with "组合优化的普遍需求与规约瓶颈" (NOT quantum hardware breakthroughs)
- Introduce `problem-reductions` crate in the "编译器视角" section
- Quantum platforms appear in section 3 as "最具挑战性的编译目标"
- Use software terminology: "规约合成" not "规约发现", "编译后端" not "编码方案"
- Keep the compiler analogy front and center throughout

**Step 3: Review output and iterate**

Check that:
- [ ] Opening paragraph does NOT start with quantum computing
- [ ] `problem-reductions` crate is prominently featured
- [ ] Quantum content is moderate (1 subsection per platform, simplified physics)
- [ ] Software/CS terms dominate: compiler, synthesis, TDD, type-safe, MCP
- [ ] All `\cite{}` keys exist in `ref.bib`

**Step 4: Compile**

Run: `cd /Users/liujinguo/Documents/nsfc2026 && xelatex -interaction=nonstopmode 面上项目-正文-2026.tex`
Expected: Compiles without errors

**Step 5: Commit**

```bash
git add sections/一依据.tex ref.bib
git commit -m "feat: rewrite 立项依据 with software-centric framing"
```

---

## Task 3: Rewrite 研究内容 (Section 2) — Using `nsfc-research-content-writer` Skill

**Files:**
- Modify: `sections/二内容.tex`

**Skill:** `nsfc-research-content-writer`

**Step 1: Prepare the info form**

```
1. 研究对象/应用场景：
组合优化问题到专用求解器的自动映射——构建问题规约编译器。

2. 核心科学问题与假说：
假说：LLM+ILP闭环可实现100+正确规约规则的自动合成，支撑端到端编译器。
S1: 多变量多项式代价模型与Pareto路径优化
S2: LLM驱动的规约规则自动合成
S3: 问题规约编译器设计与实现
S4: 量子优化后端验证

3. 总体目标：
构建开源问题规约编译器，覆盖100+规约规则，支持从用户组合优化问题到量子优化平台的端到端自动映射。

4. 子目标：
S1（编译器优化理论）：
  - 指标：100+节点规约图的秒级路径搜索
  - 对照：穷举搜索与贪心策略
  - 验证：Pareto前沿完备性分析与路径质量对比

S2（自动规约合成）：
  - 指标：100+规约规则，ILP验证通过率，覆盖≥15类NP难问题
  - 对照：纯随机搜索与人工设计效率
  - 验证：ILP严格证明 + 热带张量网络精确求解交叉检验

S3（编译器系统）：
  - 指标：千顶点规模映射时间≤分钟量级
  - 对照：手工方案、D-Wave Ocean SDK默认嵌入
  - 基础：problem-reductions Rust库（20+问题、46规则、MCP服务器已实现）
  - 验证：标准基准问题集上的系统对比

S4（后端验证）：
  - 指标：求解成功率与近似比
  - 对照：KSG编码、平台默认嵌入
  - 验证：≥5类NP难问题、≥3个规模梯度

5. 技术路线概览：
用户问题 → 前端（问题识别）→ 中端（规约图路径优化）→ 后端（硬件参数生成）→ 量子平台执行 → 解提取

6. 关键方法与验证：
- LLM+ILP合成-验证闭环（测试驱动方法）
- 进化式优化（AlphaEvolve范式）
- Rust类型系统保障编译时正确性
- Dijkstra + Pareto多目标路径搜索
- 热带张量网络精确求解（交叉检验）
- 量子硬件实测（里德堡或D-Wave）

9. 创新对照坐标系：
- vs AlphaEvolve: 我们用ILP精确验证（非数值评估），保证可证明正确性
- vs 手工规约设计: 我们自动化+规模化，100+ vs ~10 rules
- vs D-Wave Ocean SDK: 我们支持多步规约路径优化（非单步嵌入）
- vs 经典编译器: 我们处理多变量多项式代价（非常数代价）

10. 四年计划硬约束：
- 第一年必须完成：代价模型理论框架、LLM发现原型验证、20+规约规则
- 每年成果：论文2-3篇、规约规则持续积累、开源软件迭代发布
- problem-reductions crate已有46规则基础，目标扩展至100+

11. 关键风险：
- LLM合成质量不足 → 退回ILP精确搜索（已验证可行）
- 理论复杂度过高 → 单变量近似 + 启发式路径选择
- 规模不足 → 优先覆盖15-20类核心问题 + 开源社区协作
- 硬件访问延迟 → 数值模拟先行 + 三角晶格编码作首个验证目标
```

**Step 2: Invoke the skill**

Run: `Skill("nsfc-research-content-writer")` with the info form above.

**Key reframe instructions:**
- Research Content 3 (compiler) should be the **longest and most detailed** section (~30% more than current)
- Prominently feature the `problem-reductions` crate architecture: type-safe rules, inventory registration, Dijkstra optimizer, MCP server
- Rename "规约发现" → "规约合成(synthesis)" throughout
- Rename "实验验证" → "后端验证" for Research Content 4
- Use compiler terminology: front-end, middle-end, back-end, IR, compilation pass
- The "特色与创新" should lead with software/methodology innovation, quantum as application

**Step 3: Review and iterate**

Check that:
- [ ] Research Content 3 (compiler) is the centerpiece, featuring `problem-reductions` details
- [ ] "合成" used instead of "发现" for LLM-driven rule generation
- [ ] "后端验证" framing for quantum experiments
- [ ] 年度研究计划 uses software milestones, no weekly time estimates
- [ ] All existing S1-S4 metrics and baselines are preserved

**Step 4: Compile**

Run: `cd /Users/liujinguo/Documents/nsfc2026 && xelatex -interaction=nonstopmode 面上项目-正文-2026.tex`

**Step 5: Commit**

```bash
git add sections/二内容.tex
git commit -m "feat: rewrite 研究内容 with compiler-first framing"
```

---

## Task 4: Update 研究基础 (Section 3) — Using `nsfc-research-foundation-writer` Skill

**Files:**
- Modify: `sections/三1基础.tex`

**Skill:** `nsfc-research-foundation-writer`

**Step 1: Prepare the info form**

```
1. 前期基础（证据链素材）

1.1 已发表/已接收论文
- Ebadi2022Science: 里德堡原子量子优化实验 (Science, 2022)
- Liu2021PRL: 热带张量网络 (Physical Review Letters, 2021)
- Liu2023SIAM: 泛型张量网络 (SIAM Review, 2023)
- Pan2025Triangular: 三角晶格编码 (in review, 2025)
- Nguyen2023PRXQuantum: KSG编码 (PRX Quantum, 2023)
- Luo2020Quantum: Yao.jl量子模拟器 (Quantum, 2020)

1.2 软件
- problem-reductions (Rust): 20+问题类型、46条规约规则、Dijkstra路径优化、MCP服务器、CLI工具、inventory注册系统、类型安全的规约框架。GitHub: CodingThrust/problem-reductions
- Yao.jl: Julia量子计算框架，近千GitHub星标
- GenericTensorNetworks.jl: 泛型张量网络求解组合优化
- UnitDiskMapping.jl: 里德堡原子编码方案库

1.3 预实验/初步结果
- ILP辅助小工具搜索：在4^12搜索空间成功发现最优12顶点交叉小工具
- problem-reductions已实现的规约路径搜索：可在秒级完成多步规约路径规划
- MCP服务器：已支持LLM agent直接查询规约图、创建问题实例、执行规约

2. 团队与分工
- 申请人刘金国：总体设计、编译器架构、量子平台对接
- 博士生团队(8人)：量子算法(2人)、张量网络(2人)、里德堡实验(1人)、形式化方法(1人)、软件工程(2人)

3. 条件与资源
- 平台：香港科技大学（广州）高性能计算集群
- 合作：Harvard/MIT Lukin团队（里德堡平台访问）、QuEra Computing（产业合作）
- 云服务：D-Wave Leap（量子退火机访问）
- 开源社区：CodingThrust GitHub组织

4. 风险清单
4.1 技术风险：LLM合成质量不足
  - 早期信号：第一年ILP验证通过率<10%
  - 备选：退回ILP精确搜索（已验证）+ 优化提示策略

4.2 进度风险：理论复杂度过高
  - 早期信号：多变量渐进比较可判定性无实质进展
  - 备选：单变量近似 + 启发式路径选择

4.3 资源风险：硬件访问延迟
  - 早期信号：合作方无法按期提供实验时间
  - 备选：数值模拟先行 + 三角晶格编码作首个验证目标
```

**Step 2: Invoke the skill**

Run: `Skill("nsfc-research-foundation-writer")` with the info form above.

**Key reframe instructions:**
- **Elevate `problem-reductions` crate** to the most prominent position in "成果四" — expand description to include:
  - Architecture: type-safe Rust generics, `ReduceTo<T>` trait, `DeclaredVariant` compile-time checks
  - Scale: 20+ problem types across 5 categories, 46 reduction rule implementations
  - Infrastructure: Dijkstra path optimizer with custom cost functions, inventory-based registration
  - AI integration: MCP server with 10+ tools for LLM agents, structured prompts
  - CLI: `pred` command-line tool for interactive exploration
- **Reframe "可行性分析"** with software engineering language:
  - "系统可行性" should detail the existing crate's architecture maturity
  - "方法可行性" should emphasize TDD, not just ILP
- Keep existing quantum accomplishments but position them as "domain expertise that informs compiler design"

**Step 3: Review and iterate**

Check that:
- [ ] `problem-reductions` crate gets 1-2 full paragraphs of detailed description
- [ ] Software engineering capabilities of the team are highlighted
- [ ] Risk mitigation is practical and software-oriented

**Step 4: Compile**

Run full compilation:
```bash
cd /Users/liujinguo/Documents/nsfc2026
xelatex -interaction=nonstopmode 面上项目-正文-2026.tex
bibtex 面上项目-正文-2026
xelatex -interaction=nonstopmode 面上项目-正文-2026.tex
xelatex -interaction=nonstopmode 面上项目-正文-2026.tex
```

**Step 5: Commit**

```bash
git add sections/三1基础.tex
git commit -m "feat: update 研究基础 to showcase problem-reductions crate"
```

---

## Task 5: Update Bibliography — Using `nsfc-bib-manager` Skill

**Files:**
- Modify: `ref.bib`

**Skill:** `nsfc-bib-manager`

**Step 1: Verify all existing citations still work**

Run: `grep -o '\\cite{[^}]*}' sections/一依据.tex sections/二内容.tex sections/三1基础.tex | sort -u`

**Step 2: Check if new references are needed**

The pivot may require adding references for:
- Compiler/PL theory (if cited in the new framing)
- Program synthesis literature (if cited)
- Any new software engineering references

Use `nsfc-bib-manager` to verify each new citation has correct DOI/metadata.

**Step 3: Full compilation with bibliography**

```bash
cd /Users/liujinguo/Documents/nsfc2026
xelatex -interaction=nonstopmode 面上项目-正文-2026.tex
bibtex 面上项目-正文-2026
xelatex -interaction=nonstopmode 面上项目-正文-2026.tex
xelatex -interaction=nonstopmode 面上项目-正文-2026.tex
```

**Step 4: Commit**

```bash
git add ref.bib
git commit -m "fix: update bibliography for software-centric pivot"
```

---

## Task 6: Update Abstract — Using `nsfc-abstract` Skill

**Files:**
- Output: `NSFC-ABSTRACTS.md`

**Skill:** `nsfc-abstract`

**Step 1: Invoke skill after all sections are rewritten**

The abstract should reflect the new software-centric framing:
- Lead with "combinatorial optimization compiler" not "quantum computing"
- Mention `problem-reductions` crate as existing foundation
- Key contributions: cost model theory, LLM+ILP synthesis method, compiler system, quantum backend validation

**Step 2: Review Chinese abstract (≤400 chars) and English abstract (≤4000 chars)**

Check that:
- [ ] Software/compiler framing is primary
- [ ] Quantum platforms mentioned as application/backend
- [ ] Key metrics preserved (100+ rules, 15+ problem types)

**Step 3: Commit**

```bash
git add NSFC-ABSTRACTS.md
git commit -m "feat: update abstracts for software-centric pivot"
```

---

## Task 7: Final Verification

**Step 1: Full compilation**

```bash
cd /Users/liujinguo/Documents/nsfc2026
make clean
xelatex -interaction=nonstopmode 面上项目-正文-2026.tex
bibtex 面上项目-正文-2026
xelatex -interaction=nonstopmode 面上项目-正文-2026.tex
xelatex -interaction=nonstopmode 面上项目-正文-2026.tex
```

Expected: No errors, all citations resolved.

**Step 2: Page count check**

Verify PDF is ≤ 30 pages.

**Step 3: Consistency check**

Verify across all sections:
- [ ] Title is consistent (new title everywhere)
- [ ] S1-S4 numbering and descriptions are consistent between 一依据 and 二内容
- [ ] `problem-reductions` crate description is consistent between 一依据 and 三1基础
- [ ] All `\cite{}` keys resolve correctly
- [ ] No orphaned quantum-first language in software-first sections

**Step 4: Update AGENTS.md chapter status**

Mark all rewritten sections as "✅ 已完成 (软件化重构)"

**Step 5: Final commit**

```bash
git add -A
git commit -m "chore: final verification after software-centric pivot"
```

---

## Execution Dependencies

```
Task 1 (metadata) ──→ Task 2 (立项依据) ──→ Task 3 (研究内容) ──→ Task 4 (研究基础)
                                                                        │
                                                                        ├──→ Task 5 (bibliography)
                                                                        └──→ Task 6 (abstract)
                                                                                    │
                                                                                    └──→ Task 7 (verification)
```

Tasks 2-4 must be sequential (later sections reference earlier ones).
Tasks 5-6 can run in parallel after Task 4.
Task 7 is the final gate.

## Skill Mapping Summary

| Task | Section | Skill |
|------|---------|-------|
| 1 | Metadata | Manual edit |
| 2 | 一依据.tex | `nsfc-justification-writer` |
| 3 | 二内容.tex | `nsfc-research-content-writer` |
| 4 | 三1基础.tex | `nsfc-research-foundation-writer` |
| 5 | ref.bib | `nsfc-bib-manager` |
| 6 | Abstract | `nsfc-abstract` |
| 7 | Verification | Manual + `make pdf` |
