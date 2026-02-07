# NSFC 2026 面上项目 Implementation Plan: LLM-Assisted Problem Reduction

> **For Claude:** REQUIRED SUB-SKILL: Use superpowers:executing-plans to implement this plan task-by-task.

**Goal:** Write a complete NSFC 面上项目 proposal on using LLMs to automate problem reductions for physical computing devices (Rydberg atoms, D-Wave, tensor networks).

**Architecture:** The proposal follows 2026 NSFC format with three main sections: 立项依据 (why this research), 研究内容 (what to do), 研究基础 (capability to deliver). Content is organized in LaTeX files under `sections/`. We leverage existing `survey.md` and `personal.md` for source material.

**Tech Stack:** LaTeX (XeLaTeX), BibTeX, Chinese scientific writing

---

## Key Resources

- **Template structure**: `面上项目-正文-2026.tex` (main), `sections/*.tex` (content)
- **Source materials**: `survey.md` (literature review), `personal.md` (PI credentials)
- **References**: `references/md/*.md` (converted PDFs), `ref.bib` (bibliography)
- **Build**: `make pdf` (XeLaTeX compilation)

## 2026 NSFC Format Requirements

Per [NSFC 2026 Guidelines](https://www.nsfc.gov.cn/p1/3381/2821/99242.html):
- **正文不超过30页**，鼓励简洁表达
- 三大部分：立项依据、研究内容、研究基础
- 立项依据：只需说清"为什么要开展此项研究，研究的科学技术价值如何"
- 研究内容：提纲不做限制，按研究工作自身逻辑撰写，需包含特色与创新点、年度研究计划
- 研究基础：前期工作积累和已取得成绩

---

## Task 1: Prepare Bibliography (ref.bib)

**Files:**
- Modify: `ref.bib`

**Step 1: Review current ref.bib**

Run: `cat ref.bib | head -50`
Expected: See existing bibliography entries

**Step 2: Add core references from survey.md**

Add BibTeX entries for key papers:

```bibtex
@article{Ebadi2022Science,
  author = {Ebadi, S. and Keesling, A. and Cain, M. and Wang, T.T. and Levine, H. and Bluvstein, D. and Semeghini, G. and Omran, A. and Liu, J.-G. and Samajdar, R. and Luo, X.-Z. and Nash, B. and Gao, X. and Barak, B. and Farhi, E. and Sachdev, S. and Gemelke, N. and Zhou, L. and Choi, S. and Pichler, H. and Wang, S.-T. and Greiner, M. and Vuletic, V. and Lukin, M.D.},
  title = {Quantum optimization of maximum independent set using Rydberg atom arrays},
  journal = {Science},
  volume = {376},
  pages = {1209-1215},
  year = {2022}
}

@article{Liu2021PRL,
  author = {Liu, Jin-Guo and Wang, Lei and Zhang, Pan},
  title = {Tropical Tensor Network for Ground States of Spin Glasses},
  journal = {Physical Review Letters},
  volume = {126},
  pages = {090506},
  year = {2021}
}

@article{Nguyen2023PRXQuantum,
  author = {Nguyen, Minh-Thi and Liu, Jin-Guo and Wurtz, Jonathan and Lukin, Mikhail D. and Wang, Sheng-Tao and Pichler, Hannes},
  title = {Quantum optimization with arbitrary connectivity using Rydberg atom arrays},
  journal = {PRX Quantum},
  volume = {4},
  pages = {010316},
  year = {2023}
}

@article{Pan2025Triangular,
  author = {Pan, Xue-Wei and Zhou, Hong-Hao and Lu, Yi-Ming and Liu, Jin-Guo},
  title = {Encoding computationally hard problems in triangular Rydberg atom arrays},
  journal = {arXiv preprint},
  year = {2025}
}

@article{Luo2020Quantum,
  author = {Luo, Xiu-Zhe and Liu, Jin-Guo and Zhang, Pan and Wang, Lei},
  title = {Yao.jl: Extensible, Efficient Framework for Quantum Algorithm Design},
  journal = {Quantum},
  volume = {4},
  pages = {341},
  year = {2020}
}

@article{Liu2023SIAM,
  author = {Liu, Jin-Guo and Gao, Xun and Cain, Madelyn and Lukin, Mikhail D. and Wang, Sheng-Tao},
  title = {Computing solution space properties of combinatorial optimization problems via generic tensor networks},
  journal = {SIAM Journal on Scientific Computing},
  year = {2023}
}

@misc{AlphaEvolve2025,
  author = {{Google DeepMind}},
  title = {AlphaEvolve: A Gemini-powered coding agent for designing advanced algorithms},
  year = {2025},
  howpublished = {\url{https://deepmind.google/blog/alphaevolve}}
}

@article{DWave2025Science,
  author = {Bernstein, Dan and others},
  title = {Demonstration of quantum computational advantage using D-Wave Advantage2},
  journal = {Science},
  year = {2025}
}

@misc{ProblemReductions2025,
  author = {Liu, Jin-Guo and others},
  title = {problem-reductions: A Rust library for NP-hard problem reductions},
  year = {2025},
  howpublished = {\url{https://github.com/CodingThrust/problem-reductions}}
}
```

**Step 3: Verify compilation**

Run: `cd /Users/liujinguo/Documents/nsfc2026 && make pdf`
Expected: PDF compiles without bibliography errors

**Step 4: Commit changes**

```bash
git add ref.bib
git commit -m "feat: add core references for LLM problem reduction proposal"
```

---

## Task 2: Write 立项依据 Section

**Files:**
- Modify: `sections/一依据.tex`

**Goal:** Explain WHY this research matters (~6-8 pages)

**Structure:**
1. 研究背景与战略意义 (1 page)
2. 物理计算平台现状 (2 pages)
3. 问题规约的核心挑战 (1.5 pages)
4. LLM在算法发现领域的突破 (1.5 pages)
5. 本项目的科学问题与价值 (1 page)

**Step 1: Clear template content**

Remove the template instructions, keep only the actual content placeholder.

**Step 2: Write Section 1.1 - 研究背景与战略意义**

```latex
\section{研究背景与战略意义}

量子计算是当今物理学最重要的前沿之一，也是国家科技竞争的关键领域。"十四五"规划和2035年远景目标纲要均将发展量子技术作为重中之重。近年来，多种物理计算平台取得了突破性进展：里德堡原子阵列实现了超过289个量子比特的相干操控\cite{Ebadi2022Science}，D-Wave量子退火机展示了超过5000个量子比特的优化能力，张量网络算法在经典计算机上实现了千比特规模自旋玻璃的精确求解\cite{Liu2021PRL}。

然而，这些物理计算平台面临一个共同的核心挑战：\textbf{每种平台只能原生求解特定类型的数学问题}。里德堡原子阵列擅长单位圆盘图上的最大独立集问题，D-Wave量子退火机处理二次无约束二值优化(QUBO)问题，张量网络算法高效处理有界树宽的图模型。而现实世界中的NP困难问题，如调度优化、蛋白质折叠、电路设计等，通常不直接属于这些类型。

\textbf{问题规约}——将一个计算问题高效转化为另一个计算问题——是连接实际应用与物理计算平台的关键桥梁。然而，传统的问题规约研究依赖于人工设计规约方案（gadget），这不仅耗时费力，而且容易出错，严重制约了物理计算平台的实际应用。

近年来，大语言模型(LLM)在代码生成、算法合成和数学推理方面取得了惊人进展。Google DeepMind的AlphaEvolve在2025年成功改进了20\%的开放数学问题的已知最优解\cite{AlphaEvolve2025}。这为\textbf{利用LLM自动化问题规约设计}开辟了全新的可能。

本项目旨在研究如何利用大语言模型自动发现、验证和优化问题规约规则，构建连接NP困难问题与物理计算平台的智能化桥梁。
```

**Step 3: Write Section 1.2 - 物理计算平台现状**

```latex
\section{物理计算平台与原生问题类型}

\subsection{里德堡原子阵列}

里德堡原子阵列利用原子间的van der Waals相互作用实现量子计算。里德堡阻塞效应——处于里德堡态的原子会阻止一定范围内的其他原子激发——天然地对应于独立集问题的约束。

2022年，哈佛大学Lukin课题组在\textit{Science}期刊报道了利用289个里德堡原子求解最大独立集(MIS)问题的实验，观测到了超线性量子加速\cite{Ebadi2022Science}。申请人作为该工作的合作者，负责了张量网络精确解的计算验证工作。

将任意图编码到里德堡阵列需要\textbf{交叉小工具(crossing gadget)}。Nguyen等人\cite{Nguyen2023PRXQuantum}提出了基于国王子图(King's Subgraph, KSG)的编码方案，但其质量因子$Q=\sqrt{2}$导致的能量分离仅为$Q^6=8$，使得实验中约束违规率较高。申请人团队最新提出的三角晶格子图(TLSG)编码\cite{Pan2025Triangular}，质量因子$Q=\sqrt{3}$，能量分离达到$Q^6=27$，\textbf{将约束违规减少了约两个数量级}。

关键洞察：不同的规约方案可能带来数量级的性能差异，这为LLM辅助的规约优化提供了巨大的探索空间。

\subsection{D-Wave量子退火机}

D-Wave系统通过量子退火求解二次无约束二值优化(QUBO)问题。2025年3月，D-Wave宣布其Advantage2系统在特定问题上展现了相对于经典超级计算机的量子计算优势。

将一般NP困难问题映射到QUBO需要精心设计惩罚项和嵌入策略。当前方法依赖于预设的规则库和启发式嵌入算法，缺乏系统的自动化框架。

\subsection{张量网络与分支算法}

张量网络通过将多体波函数分解为张量乘积来高效表示量子态。申请人团队开发的热带张量网络\cite{Liu2021PRL}将传统张量网络的(求和,乘积)代数替换为热带代数(取最大值,求和)，实现了自旋玻璃基态能量的精确计算。在1024自旋的方格子和512比特的D-Wave Chimera图上，单张GPU即可在100秒内完成计算。

这些方法的效率依赖于\textbf{将原问题高效规约为具有有界树宽的图模型}。
```

**Step 4: Write Section 1.3 - 问题规约的核心挑战**

```latex
\section{问题规约的核心挑战}

\subsection{传统规约设计的困境}

NP完全性理论保证所有NP完全问题可以相互多项式时间规约。然而，理论上的可规约性与实际的高效规约之间存在巨大鸿沟：

\begin{enumerate}
    \item \textbf{小工具设计的复杂性}：以三角晶格交叉小工具为例，其包含12个顶点，权重范围1-4。暴力搜索需要枚举$4^{12} \approx 1600$万种权重分配，使得人工设计在计算上不可行。申请人团队通过整数线性规划方法，将搜索时间从指数级降至秒级\cite{Pan2025Triangular}。
    \item \textbf{正确性验证的缺失}：现有规约规则大多缺乏机器可验证的正确性证明，难以保证规约后问题与原问题的解等价。
    \item \textbf{硬件感知的缺乏}：学术文献中的规约往往忽视实际硬件约束（如量子比特连通性、相干时间限制），导致理论最优规约在实际硬件上表现不佳。
\end{enumerate}

\subsection{problem-reductions库的现状与局限}

申请人团队正在开发的problem-reductions库\cite{ProblemReductions2025}旨在实现100+种NP困难问题及其规约规则。当前架构支持：

\begin{lstlisting}[language=rust, basicstyle=\ttfamily\small]
// 示例：独立集问题规约到整数线性规划
let problem = IndependentSet::new(...);
let target = ReduceTo::<ILP>::reduce_to(&problem);
let solution = solve(target);
let original = extract_solution(&problem, &target, &solution);
\end{lstlisting}

然而，该库面临三个关键局限：(1)规约规则需要手工实现；(2)缺乏面向特定硬件的规约优化；(3)没有自动验证规约正确性的机制。
```

**Step 5: Write Section 1.4 - LLM在算法发现领域的突破**

```latex
\section{大语言模型在算法发现领域的突破}

2024-2025年，大语言模型在算法设计和数学发现方面取得了一系列突破性进展：

\subsection{AlphaEvolve与数学问题发现}

Google DeepMind的AlphaEvolve\cite{AlphaEvolve2025}将大语言模型与进化算法结合，应用于50多个开放数学问题。关键成果包括：
\begin{itemize}
    \item 改进了20\%问题的已知最优解
    \item 发现了4×4矩阵的48次乘法算法，突破了Strassen 50年的纪录
    \item 确立了11维接吻数问题的新下界（593个球体）
\end{itemize}

\subsection{LLM作为组合优化求解器}

HeuriGym基准测试\cite{HeuriGym2025}评估了LLM在九类组合优化问题上的表现。结果表明，GPT-o4-mini和Gemini-2.5-Pro能够模仿并迭代改进启发式策略，但与专家设计的工具仍有差距。

最新研究表明，经过微调的7B参数LLM可以在七类NP困难问题上达到1-8\%的最优性差距，超越GPT-4o和领域专用启发式算法。

\subsection{数学推理能力的飞跃}

\begin{itemize}
    \item \textbf{rStar-Math}：结合蒙特卡洛树搜索与步进推理，使Qwen-7B在AIME 2024上达到53\%正确率
    \item \textbf{Gemini Deep Think}：在2025年国际数学奥林匹克竞赛上获得金牌水平表现
    \item \textbf{o1/o3推理模型}：在IMO问题上达到83\%准确率，相比GPT-4o的13\%有质的飞跃
\end{itemize}

这些进展表明，LLM具备了\textbf{发现新算法、证明数学定理}的潜力，为自动化问题规约设计提供了技术基础。
```

**Step 6: Write Section 1.5 - 本项目的科学问题与价值**

```latex
\section{本项目的科学问题与价值}

\subsection{核心科学问题}

本项目聚焦于以下科学问题：

\textbf{如何利用大语言模型自动发现、验证和优化面向物理计算平台的问题规约规则？}

具体包括三个子问题：
\begin{enumerate}
    \item \textbf{规约发现}：如何利用LLM的代码生成和模式识别能力，自动发现新的规约小工具？
    \item \textbf{规约验证}：如何结合LLM推理与形式化验证，确保规约的数学正确性？
    \item \textbf{规约优化}：如何针对特定硬件约束（量子比特连通性、误差模型），优化规约方案的实际性能？
\end{enumerate}

\subsection{科学技术价值}

\begin{enumerate}
    \item \textbf{理论价值}：建立LLM辅助规约设计的方法论框架，推动计算复杂性理论与人工智能的交叉融合。
    \item \textbf{应用价值}：显著降低问题规约的开发门槛，使非专业人员也能利用物理计算平台求解实际优化问题。
    \item \textbf{工具价值}：扩展problem-reductions库，建立面向里德堡原子、D-Wave、张量网络的规约工具链。
\end{enumerate}

\begin{REF}
\subsection*{参考文献}
\vspace{-50pt}
\bibliography{ref}
\end{REF}

\newpage
```

**Step 7: Compile and verify**

Run: `cd /Users/liujinguo/Documents/nsfc2026 && make pdf`
Expected: PDF compiles, 立项依据 section is ~6-8 pages

**Step 8: Commit changes**

```bash
git add sections/一依据.tex
git commit -m "feat: write 立项依据 section for LLM problem reduction proposal"
```

---

## Task 3: Write 研究内容 Section

**Files:**
- Modify: `sections/二内容.tex`

**Goal:** Explain WHAT to do and HOW (~8-10 pages)

**Structure:**
1. 总体研究框架 (1 page)
2. 研究内容一：LLM辅助规约发现 (2.5 pages)
3. 研究内容二：规约正确性验证 (2 pages)
4. 研究内容三：硬件感知规约优化 (2 pages)
5. 特色与创新点 (1 page)
6. 年度研究计划 (1 page)

**Step 1: Write overall framework**

```latex
\section{总体研究框架}

本项目围绕"LLM辅助问题规约"这一核心目标，设计三个相互关联的研究内容：

\begin{figure}[h!]
\centering
\includegraphics[width=0.9\textwidth]{figures/framework.png}
\caption{研究框架示意图}
\end{figure}

\textbf{研究内容一}：开发基于LLM的规约小工具自动发现系统，将人工设计周期从月级缩短到小时级。

\textbf{研究内容二}：建立规约正确性的形式化验证框架，结合LLM生成的证明草稿与自动定理证明器。

\textbf{研究内容三}：针对里德堡原子、D-Wave、张量网络三类平台，开发硬件感知的规约优化策略。

三者形成闭环：发现→验证→优化→实验验证→反馈发现。
```

**Step 2: Write 研究内容一 - LLM辅助规约发现**

```latex
\section{研究内容一：LLM辅助规约小工具自动发现}

\subsection{问题定义}

规约小工具(gadget)是一个小型加权图，其最大权重独立集在选定顶点子集上实现规定的逻辑关系。给定：
\begin{itemize}
    \item 源问题类型（如SAT, 3-Coloring, Clique）
    \item 目标问题类型（如MIS on unit-disk graph, QUBO）
    \item 硬件约束（如格点几何、连通性）
\end{itemize}

目标是自动发现满足以下条件的小工具：
\begin{enumerate}
    \item 正确编码源问题的逻辑约束
    \item 满足目标问题的几何/连通性约束
    \item 最小化顶点/边/量子比特开销
\end{enumerate}

\subsection{技术路线}

\subsubsection{基于LLM的候选生成}

利用GPT-4、Claude等代码生成模型，以prompt engineering方式生成候选小工具：

\begin{lstlisting}[language=python, basicstyle=\ttfamily\small]
prompt = """
Task: Design a crossing gadget for triangular lattice.
Constraint: Two logical edges must cross on a triangular grid.
Goal: When exactly one edge is selected, the gadget is satisfied.
Output: Vertex positions, edge weights, logical-to-physical mapping.
"""
candidates = llm.generate(prompt, n=100, temperature=0.8)
\end{lstlisting}

关键技术点：
\begin{itemize}
    \item 构建规约知识库，包含已有规约规则、复杂性分析、应用案例
    \item 采用few-shot learning，以成功规约作为示例
    \item 利用chain-of-thought prompting引导LLM进行逐步推理
\end{itemize}

\subsubsection{整数线性规划验证}

对LLM生成的候选进行形式化验证：

\begin{align}
\text{minimize} \quad & \sum_{v \in V} c_v x_v \\
\text{subject to} \quad & x_i + x_j \leq 1, \quad \forall (i,j) \in E \text{ (独立性约束)} \\
& \text{逻辑约束（编码目标逻辑函数）}
\end{align}

该方法延续申请人团队在\cite{Pan2025Triangular}中的工作，已成功发现三角晶格交叉小工具。

\subsubsection{进化式优化}

采用AlphaEvolve风格的进化策略：
\begin{enumerate}
    \item LLM生成初始候选集
    \item ILP验证器筛选正确候选
    \item 根据开销指标选择优胜者
    \item LLM基于优胜者变异生成新候选
    \item 迭代直至收敛
\end{enumerate}

\subsection{预期成果}

\begin{itemize}
    \item 开发LLM-ILP混合规约发现系统
    \item 发现5-10种新的规约小工具
    \item 将规约设计周期从月级缩短到小时级
\end{itemize}
```

**Step 3: Write 研究内容二 - 规约正确性验证**

```latex
\section{研究内容二：规约正确性形式化验证}

\subsection{挑战与目标}

规约正确性包含两层含义：
\begin{enumerate}
    \item \textbf{解保持性}：原问题有解当且仅当规约后问题有解
    \item \textbf{解可提取性}：从规约后问题的解可以高效还原原问题的解
\end{enumerate}

现有规约大多依赖人工验证，缺乏机器可检查的正确性证明。

\subsection{技术路线}

\subsubsection{LLM辅助证明草稿生成}

利用LLM的数学推理能力生成证明草稿：

\begin{lstlisting}[basicstyle=\ttfamily\small]
prompt = """
Theorem: The crossing gadget correctly encodes edge crossing.
Proof sketch:
1. If edge A is selected (not B), show gadget configuration.
2. If edge B is selected (not A), show gadget configuration.
3. If both or neither selected, show no valid configuration.
"""
proof_sketch = llm.generate(prompt)
\end{lstlisting}

\subsubsection{与Lean4/mathlib集成}

将LLM生成的证明草稿转化为形式化证明：
\begin{itemize}
    \item 定义规约正确性的形式化规范
    \item 利用LLM将自然语言证明翻译为Lean4代码
    \item 结合自动定理证明器完成证明
\end{itemize}

\subsubsection{SMT求解器验证}

对于小规模小工具，使用SMT求解器（如Z3）进行穷举验证：
\begin{itemize}
    \item 枚举所有可能的输入配置
    \item 验证输出满足目标逻辑关系
    \item 自动生成反例（若验证失败）
\end{itemize}

\subsection{预期成果}

\begin{itemize}
    \item 建立规约正确性的形式化验证框架
    \item 为problem-reductions库中的核心规约提供机器可验证证明
    \item 开发LLM-to-Lean4证明翻译工具
\end{itemize}
```

**Step 4: Write 研究内容三 - 硬件感知规约优化**

```latex
\section{研究内容三：硬件感知规约优化}

\subsection{目标}

针对三类物理计算平台，开发硬件感知的规约优化策略：

\begin{table}[htbp]
\centering
\caption{目标平台与优化目标}
\begin{tabular}{|c|c|c|}
\hline
平台 & 原生问题 & 优化目标 \\
\hline
里德堡原子阵列 & 单位圆盘图MIS & 最小化原子数、最大化质量因子 \\
\hline
D-Wave & QUBO & 最小化嵌入开销、适配Pegasus拓扑 \\
\hline
张量网络 & 图模型 & 最小化树宽、优化收缩顺序 \\
\hline
\end{tabular}
\end{table}

\subsection{技术路线}

\subsubsection{里德堡原子阵列优化}

基于申请人团队的UnitDiskMapping.jl和GadgetSearch.jl：
\begin{itemize}
    \item 探索更高质量因子的晶格几何
    \item 利用LLM生成候选几何配置
    \item 结合数值模拟评估量子优化性能
\end{itemize}

\subsubsection{D-Wave嵌入优化}

\begin{itemize}
    \item 训练LLM理解Pegasus/Zephyr拓扑结构
    \item 生成问题特定的嵌入策略
    \item 与D-Wave Minor Miner对比性能
\end{itemize}

\subsubsection{张量网络收缩优化}

\begin{itemize}
    \item 利用LLM识别问题的结构特征
    \item 生成适配的张量网络分解策略
    \item 集成到GenericTensorNetworks.jl框架
\end{itemize}

\subsection{预期成果}

\begin{itemize}
    \item 开发面向三类平台的规约优化模块
    \item 在标准测试问题上验证性能提升
    \item 与实验团队合作进行硬件验证
\end{itemize}
```

**Step 5: Write 特色与创新点**

```latex
\section{特色与创新点}

\begin{enumerate}
    \item \textbf{首次系统研究LLM辅助问题规约}：将LLM的代码生成、数学推理能力应用于计算复杂性理论核心问题——问题规约的自动化设计。

    \item \textbf{形式化验证保证正确性}：突破传统规约依赖人工验证的局限，建立LLM生成+形式化验证的新范式。

    \item \textbf{硬件感知的端到端框架}：从抽象规约到具体物理平台，建立完整的优化链路。

    \item \textbf{开源工具链}：扩展problem-reductions库，构建可复用、可验证的规约知识库。
\end{enumerate}
```

**Step 6: Write 年度研究计划**

```latex
\section{年度研究计划}

\begin{table}[htbp]
\centering
\caption{四年研究计划}
\begin{tabular}{|c|p{12cm}|}
\hline
年度 & 研究内容与预期成果 \\
\hline
第一年 &
\begin{itemize}[leftmargin=*,topsep=0pt]
    \item 构建规约知识库，整理现有规约规则
    \item 开发LLM-ILP混合规约发现原型系统
    \item 在三角晶格编码问题上验证系统有效性
\end{itemize} \\
\hline
第二年 &
\begin{itemize}[leftmargin=*,topsep=0pt]
    \item 建立规约正确性形式化验证框架
    \item 开发LLM-to-Lean4证明翻译工具
    \item 为5-10种核心规约提供机器可验证证明
\end{itemize} \\
\hline
第三年 &
\begin{itemize}[leftmargin=*,topsep=0pt]
    \item 开发里德堡原子、D-Wave、张量网络的规约优化模块
    \item 在标准测试问题上验证性能
    \item 与实验团队合作进行硬件验证
\end{itemize} \\
\hline
第四年 &
\begin{itemize}[leftmargin=*,topsep=0pt]
    \item 系统整合与开源发布
    \item 撰写综述论文，总结方法论
    \item 推广应用，培养研究生
\end{itemize} \\
\hline
\end{tabular}
\end{table}

\newpage
```

**Step 7: Compile and verify**

Run: `cd /Users/liujinguo/Documents/nsfc2026 && make pdf`
Expected: PDF compiles, 研究内容 section is ~8-10 pages

**Step 8: Commit changes**

```bash
git add sections/二内容.tex
git commit -m "feat: write 研究内容 section for LLM problem reduction proposal"
```

---

## Task 4: Write 研究基础 Section

**Files:**
- Modify: `sections/三1基础.tex`, `sections/三2条件.tex`, `sections/三3正承担.tex`, `sections/三4已完成.tex`

**Goal:** Demonstrate capability to deliver (~6-8 pages total)

**Step 1: Write 研究基础与可行性分析 (三1基础.tex)**

Use content from `personal.md`:

```latex
\subsection{申请人研究背景}

申请人刘金国，香港科技大学（广州）助理教授，博士毕业于南京大学，后在中国科学院物理研究所王磊研究员组和哈佛大学Mikhail Lukin教授组从事博士后研究。期间还担任量子计算公司QuEra Computing Inc.全职顾问6个月。

\subsection{代表性成果}

\begin{enumerate}
    \item \textbf{里德堡原子量子优化}：作为合作者参与了Science 2022年发表的里德堡原子阵列量子优化实验\cite{Ebadi2022Science}，负责张量网络精确解的计算验证。

    \item \textbf{热带张量网络}：提出热带张量网络方法\cite{Liu2021PRL}，将张量网络收缩扩展到组合优化问题，实现了千比特规模自旋玻璃的精确求解。

    \item \textbf{三角晶格编码}：提出三角晶格编码方案\cite{Pan2025Triangular}，将约束违规减少约两个数量级，并开发了整数规划小工具搜索方法。

    \item \textbf{开源软件}：开发了Yao.jl量子模拟器\cite{Luo2020Quantum}（Julia生态最流行的量子模拟器，近千GitHub星标）、GenericTensorNetworks.jl、UnitDiskMapping.jl等系列工具。
\end{enumerate}

\subsection{可行性分析}

\begin{enumerate}
    \item \textbf{理论基础}：申请人在问题规约、张量网络、量子优化方面有深厚积累，发表相关论文20余篇，Google Scholar引用超过2800次。

    \item \textbf{技术储备}：已开发problem-reductions库、GadgetSearch.jl等核心工具，具备快速迭代的软件基础。

    \item \textbf{合作网络}：与哈佛大学Lukin团队、杜克大学Ma团队保持密切合作，可获得实验验证支持。

    \item \textbf{风险应对}：若LLM生成质量不足，可退回到传统ILP方法；若形式化验证困难，可采用SMT穷举验证。
\end{enumerate}
```

**Step 2: Write 工作条件 (三2条件.tex)**

```latex
\subsection{依托平台}

本项目依托香港科技大学（广州）功能枢纽先进材料学域和港科大量子技术中心。量子科技中心由港科大物理系教授与港科大（广州）功能枢纽共同牵头筹建，主要研究领域涵盖量子芯片、量子计算、量子算法、量子光学、量子信息、量子精密测量等，总建筑面积约1,000平方米。

\subsection{计算资源}

依托香港科技大学（广州）HPC AI融合智算中心：
\begin{itemize}
    \item 通用HPC AI平台理论算力6.35 PFlops@FP64
    \item NVIDIA A800 GPU 520张 + A40 GPU 120张
    \item 内存2.3PB，存储SSD 309TB + HDD 3.9PB
\end{itemize}

该算力完全满足大语言模型推理和大规模张量网络收缩的需求。

\subsection{国际合作}

\begin{itemize}
    \item 哈佛大学Mikhail Lukin教授团队：里德堡原子实验验证
    \item 杜克大学Ruichao Ma教授团队：超导量子系统合作
    \item 清华大学、中科院物理所：国内合作网络
\end{itemize}
```

**Step 3: Write 正在承担项目 (三3正承担.tex)**

```latex
\begin{table}[htbp]
\centering
\caption{正在承担的相关科研项目}
\begin{tabular}{|p{2cm}|p{4cm}|p{2cm}|p{2cm}|p{3cm}|}
\hline
资助机构 & 项目名称 & 批准号 & 起止时间 & 与本项目关系 \\
\hline
国家自然科学基金委 & 基于里德堡原子阵列的可并行量子算法研究 & 12404568 & 2025.01-2027.12 & 提供里德堡平台理论基础 \\
\hline
国家重点研发计划 & 量子信息处理的数学基础 & 2024YFE0102500 & 2024.06-2027.05 & 提供形式化方法支持 \\
\hline
广州市科技局 & 单量子门编译算法研究 & SL2023A03J00904 & 2024.01-2025.12 & 提供量子编译经验 \\
\hline
广州市科技局 & 基于张量网络的贝叶斯推断理论 & 2024A04J4304 & 2024.01-2025.12 & 提供张量网络算法基础 \\
\hline
\end{tabular}
\end{table}

上述项目与本项目在研究方法和工具链上互为补充：青年基金项目聚焦里德堡原子的量子算法设计，本项目则聚焦问题规约的自动化；贝叶斯推断项目发展的张量网络技术可直接用于规约验证。
```

**Step 4: Write 完成项目情况 (三4已完成.tex)**

```latex
申请人尚无已资助期满的国家自然科学基金项目。

青年科学基金项目（12404568）于2025年1月开始执行，目前进展顺利。第一年度主要成果包括：

\begin{enumerate}
    \item 发表论文"Dynamic Hologram Generation with Automatic Differentiation"于Physical Review Applied，开发了基于自动微分的动态全息图生成技术。

    \item 发表论文"Encoding computationally hard problems in triangular Rydberg atom arrays"，提出三角晶格编码方案，将约束违规减少约两个数量级。

    \item 申请专利"基于里德堡原子平台的问题映射"（申请中）。

    \item 开源软件UnitDiskMapping.jl、GadgetSearch.jl持续更新维护。
\end{enumerate}

上述工作为本项目奠定了直接的技术基础，尤其是整数规划小工具搜索方法，可以直接扩展为LLM-ILP混合搜索框架。
```

**Step 5: Compile and verify**

Run: `cd /Users/liujinguo/Documents/nsfc2026 && make pdf`
Expected: PDF compiles, 研究基础 section is ~6-8 pages

**Step 6: Commit changes**

```bash
git add sections/三*.tex
git commit -m "feat: write 研究基础 section for LLM problem reduction proposal"
```

---

## Task 5: Write 其他说明 Section

**Files:**
- Modify: `sections/四1同年申请.tex`, `sections/四2同年不一致.tex`, `sections/四3已有不一致.tex`, `sections/四4同年不同职务.tex`, `sections/四6其他.tex`

**Step 1: Write simple declarations**

```latex
% 四1同年申请.tex
无。

% 四2同年不一致.tex
无。

% 四3已有不一致.tex
无。

% 四4同年不同职务.tex
无。

% 四6其他.tex
无需说明的其他情况。
```

**Step 2: Commit changes**

```bash
git add sections/四*.tex
git commit -m "feat: write 其他说明 section"
```

---

## Task 6: Create Framework Figure

**Files:**
- Create: `figures/framework.png` or `figures/framework.pdf`

**Step 1: Create figure using TikZ or external tool**

Create a diagram showing:
- Input: NP-hard problems (SAT, TSP, Clique, etc.)
- LLM-guided reduction discovery
- Formal verification
- Output: Hardware-native representations (MIS, QUBO, TN)
- Feedback loop

**Step 2: Save to figures directory**

**Step 3: Commit**

```bash
git add figures/framework.png
git commit -m "feat: add research framework diagram"
```

---

## Task 7: Final Compilation and Review

**Step 1: Full compilation**

Run: `cd /Users/liujinguo/Documents/nsfc2026 && make clean && make pdf`
Expected: PDF compiles without errors

**Step 2: Page count verification**

Run: `pdfinfo 面上项目-正文-2026.pdf | grep Pages`
Expected: ≤30 pages

**Step 3: Visual review**

- Check formatting consistency
- Verify figure/table placement
- Ensure references are correctly formatted
- Check for orphan/widow lines

**Step 4: Final commit**

```bash
git add -A
git commit -m "chore: finalize NSFC 2026 proposal draft"
```

---

## Summary

| Task | Files | Estimated Pages |
|------|-------|-----------------|
| 1. Bibliography | ref.bib | N/A |
| 2. 立项依据 | 一依据.tex | 6-8 |
| 3. 研究内容 | 二内容.tex | 8-10 |
| 4. 研究基础 | 三*.tex | 6-8 |
| 5. 其他说明 | 四*.tex | 1-2 |
| 6. Framework figure | figures/ | N/A |
| 7. Final review | All | N/A |
| **Total** | | **~25 pages** |

---

## Sources

- [2026年申请书改版公告](https://www.nsfc.gov.cn/p1/3381/2821/99242.html)
- [NSFC申请书撰写技巧](https://www.nsfc.gov.cn/csc/20345/20348/pdf/2018/201806596.pdf)
- [从科学问题谈申请书撰写](https://www.nsfc.gov.cn/csc/20345/20348/pdf/2013/)
- [面上项目研究内容的遴选与撰写](https://www.nsfc.gov.cn/csc/20345/20348/pdf/2009/)
