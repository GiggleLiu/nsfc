# 标题建议

推荐标题：面向量子优化平台的问题规约自动发现、验证与编译方法

1) 面向量子优化平台的问题规约自动发现、验证与编译方法 —— 理由：方法向，三个核心动词（发现、验证、编译）精准对应S2/S1/S3三个子目标，"面向量子优化平台"限定场景，符合信息科学部偏好，25字符
2) LLM辅助面向物理计算平台的问题规约自动发现与验证 —— 理由：延续前期工作题目风格，"物理计算平台"覆盖面更广（含张量网络后端），突出LLM方法创新，25字符
3) 量子优化问题的多步规约代价模型与自动编译器构建 —— 理由：判据向，突出"代价模型"理论贡献与"编译器"系统产出，强调可验证的理论与工程终点，23字符
4) 大语言模型驱动的组合优化问题规约发现与量子平台验证 —— 理由：场景向，突出LLM技术手段和量子平台实验验证，强调从方法到硬件的研究闭环，27字符
5) 面向量子优化硬件的组合优化问题规约理论与自动编译方法 —— 理由：整合向，同时突出"理论"与"方法"双重贡献，"量子优化硬件"直指实验平台，强调跨理论与系统的整体性，27字符

# 中文摘要

量子优化平台（里德堡原子阵列、量子退火机）正迈向实用化规模，但将实际NP难问题映射到平台原生表示需要多步规约链，面临小工具设计的组合爆炸、正确性验证困难和规模化发现不足三重挑战。当前规约设计依赖手工试错，缺乏代价建模理论、规模化发现方法和可证明正确性保障。申请人前期利用整数线性规划在约1600万种构型中自动发现最优编码小工具，验证了计算机辅助规约发现的可行性；据此提出LLM驱动的测试驱动方法可将发现能力扩展至百条以上。本项目将：(1)建立多变量多项式代价模型与Pareto最优路径搜索理论；(2)发展LLM与ILP结合的测试驱动规约发现方法，实现100+规约规则的发现与正确性证明；(3)构建集成规约知识库、路径规划与硬件后端的端到端编译器；(4)在代表性量子优化平台上完成系统性实验验证。本项目将为量子优化问题映射建立理论基础与自动化工具体系，构建开源规约编译器生态，降低量子硬件使用门槛。

# English Abstract

Quantum optimization platforms, including Rydberg atom arrays and quantum annealers, are approaching practical scales, yet mapping real-world NP-hard problems onto their native representations requires multi-step reduction chains, posing three key challenges: combinatorial explosion in gadget design, difficulty in correctness verification, and insufficient scalability of discovery. Current reduction design relies on expert trial-and-error, lacking cost modeling theory, scalable discovery methods, and provable correctness guarantees. Our prior work used integer linear programming (ILP) to automatically discover optimal encoding gadgets from approximately 16 million configurations, validating the feasibility of computer-aided reduction discovery; we hypothesize that large language model (LLM)-driven test-driven methods can extend this capability to over one hundred rules. This project will: (1) establish polynomial cost model theory and Pareto-optimal path search algorithms for multi-step reduction chains; (2) develop an LLM-and-ILP-driven test-driven reduction discovery method to achieve discovery and correctness proofs of 100+ reduction rules covering at least 15 NP-hard problem types; (3) build an end-to-end reduction compiler integrating a reduction knowledge base, path planner, and hardware backends; and (4) conduct systematic experimental validation on a representative quantum optimization platform. This work will establish theoretical foundations and automated tools for quantum optimization problem mapping, create an open-source reduction compiler ecosystem, and lower the barrier for experimental researchers to leverage quantum hardware.

## 长度自检

- 中文摘要字符数：398/400 ✅
- 英文摘要字符数：1670/4000 ✅
