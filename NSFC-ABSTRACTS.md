# 标题建议

推荐标题：LLM辅助组合优化问题规约的自动发现、验证与编译

1) LLM辅助组合优化问题规约的自动发现、验证与编译 —— 理由：方法向，三个核心动词（发现、验证、编译）对应S2/S1/S3三个子目标，"LLM辅助"突出技术路径，24字符，信息科学部偏好
2) 面向组合优化求解器的问题规约编译方法与自动合成 —— 理由：场景向，"面向求解器"锚定软件自动化场景，突出编译器作为核心产出，淡化量子背景，21字符
3) 组合优化问题规约的代价模型、自动合成与编译器构建 —— 理由：判据向，三个并列名词直接对应三个研究方向，突出理论（代价模型）+方法（合成）+系统（编译器）三重贡献，24字符
4) LLM驱动的组合优化规约自动合成与编译优化方法 —— 理由：方法向精简版，强调LLM驱动与编译优化两个方法创新点，避免过长从句，21字符
5) 面向专用求解器的问题规约自动编译：理论、合成与系统 —— 理由：整合向，冒号后三点明示贡献维度，"专用求解器"覆盖量子与经典后端，25字符

# 中文摘要

组合优化问题广泛存在于科学与工程领域，多种专用求解器各擅其长，但将用户问题经多步规约映射到求解器原生表示仍严重依赖专家经验。当前存在三个关键空白：规约代价模型与路径最优性理论尚未建立、规模化规约合成缺乏系统方法、端到端自动编译工具链尚不完备。申请人已构建problem-reductions开源库（20+问题类型、26条非平凡规约规则）并验证了ILP辅助合成的可行性；据此提出LLM驱动的测试驱动方法可将规模扩展至150+条。本项目拟：(1)建立多变量多项式代价模型与Pareto最优路径理论；(2)提出LLM+ILP测试驱动方法合成150+规约规则并证明正确性；(3)构建端到端规约编译器；(4)在代表性硬件加速器上验证编译方案。本项目将建立规约编译的优化理论，发展LLM驱动的合成范式，构建开源编译器及规约知识库，为专用求解器提供通用接口。

# English Abstract

Combinatorial optimization problems arise pervasively in science and engineering. Various specialized solvers excel at their native problem types, yet mapping user problems to solver-native representations via multi-step reductions remains heavily dependent on expert experience. Three critical gaps persist: cost models and path optimality theory for reductions have not been established, scalable reduction synthesis lacks systematic methods, and end-to-end automated compilation toolchains are incomplete. The applicant has built the open-source problem-reductions library (20+ problem types, 26 nontrivial verified reduction rules) and validated the feasibility of ILP-assisted synthesis; accordingly, we propose that LLM-driven test-driven methods can scale rule synthesis to 150+ rules. This project will: (1) establish multivariate polynomial cost models and Pareto-optimal path theory; (2) develop LLM+ILP test-driven methods to synthesize 150+ reduction rules with provable correctness; (3) build an end-to-end reduction compiler; and (4) validate compilation outputs on representative hardware accelerators. This work will establish compiler optimization theory for problem reductions, develop an LLM-driven synthesis paradigm, build an open-source compiler and reduction knowledge base, and provide a universal automated interface for specialized solvers.

## 长度自检

- 中文摘要字符数：366/400 ✅
- 英文摘要字符数：1349/4000 ✅
