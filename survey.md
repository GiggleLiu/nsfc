# Survey: LLM-Assisted Problem Reduction for Physical Computing Devices

**Purpose**: This survey supports the NSFC proposal on using Large Language Models (LLMs) to automate the generation of problem reductions, bridging the gap between computationally hard problems and physical computing devices such as Rydberg atom arrays, D-Wave quantum annealers, and classical algorithms based on tensor networks and branching techniques.

---

## 1. Executive Summary

Emerging physical computing platforms—including Rydberg atom arrays, superconducting quantum annealers, and tensor network-based classical algorithms—offer promising avenues for solving computationally hard problems. However, each platform natively supports only a limited class of problem representations:

| Platform | Native Problem Class | Key Constraints |
|----------|---------------------|-----------------|
| Rydberg atom arrays | Maximum Independent Set (MIS) on unit-disk graphs | Geometric connectivity (King's subgraph, triangular lattice) |
| D-Wave quantum annealers | QUBO / Ising models | Limited qubit connectivity (Pegasus/Zephyr topology) |
| Tensor networks | Graphical models with bounded treewidth | Contraction complexity exponential in treewidth |
| Branching algorithms | Various NP-hard problems | Exponential worst-case, but efficient for structured instances |

**The core challenge**: Most real-world NP-hard problems do not naturally map to these native representations. Systematic problem reductions are needed, but manually designing reduction gadgets is labor-intensive, error-prone, and requires deep expertise in both computational complexity and hardware constraints.

**The opportunity**: Recent advances in LLMs for code generation, algorithm synthesis, and mathematical reasoning create an unprecedented opportunity to automate the discovery and verification of problem reductions.

---

## 2. Physical Computing Platforms for Combinatorial Optimization

### 2.1 Rydberg Atom Arrays

Rydberg atom arrays have emerged as a leading platform for quantum optimization. The Rydberg blockade mechanism—where strong van der Waals interactions prevent simultaneous excitation of nearby atoms—naturally enforces independence constraints, making these systems ideally suited for the Maximum Independent Set (MIS) problem on unit-disk graphs.

**Key experimental results** (Ebadi et al., Science 2022):
- Demonstrated quantum optimization on graphs with up to **289 qubits**
- Observed **superlinear quantum speedup** on hard graph instances in the deep circuit regime
- Problem hardness controlled by solution degeneracy and local minima structure
- Tensor network algorithms used for exact characterization of MIS degeneracy

**Hardware encoding approaches**:

1. **King's Subgraph (KSG)** encoding (Nguyen et al., PRX Quantum 2023):
   - Quality factor Q = √2, yielding energetic separation Q⁶ = 8
   - Provably optimal O(n²) vertex overhead for arbitrary graph encoding
   - Significant post-processing required due to constraint violations

2. **Triangular Lattice Subgraph (TLSG)** encoding (Pan et al., 2025):
   - Quality factor Q = √3, yielding energetic separation Q⁶ = 27
   - **Two orders of magnitude reduction** in constraint violations vs. KSG
   - Novel automated gadget search using integer linear programming
   - Potentially eliminates need for post-processing

**Critical insight**: The reduction from arbitrary graphs to unit-disk graphs is fundamental. Different lattice geometries (square vs. triangular) offer different quality factors, with significant implications for solution fidelity.

### 2.2 D-Wave Quantum Annealers

D-Wave systems solve Quadratic Unconstrained Binary Optimization (QUBO) problems via quantum annealing on superconducting qubit arrays.

**2025 Milestones**:
- **Advantage2 prototype** with 5,000+ qubits demonstrated quantum computational advantage over Oak Ridge's Frontier supercomputer (Science, March 2025)
- 20-way qubit connectivity, 40% higher energy scale, longer coherence times
- Final Advantage2 release with 4,400+ qubits announced for Leap Cloud Service

**QUBO Reduction Challenges**:
- Maximum fully-connected QUBO size: ~180 variables on current hardware
- Minor embedding required for dense problems, often increasing qubit count substantially
- Variable reduction formulations can significantly reduce qubit requirements while improving solution accuracy

**Problem Reduction Pipeline**:
```
Original Problem → QUBO Formulation → Minor Embedding → Quantum Annealing → Solution Extraction
```

Each step requires careful optimization; the QUBO formulation step is particularly amenable to LLM assistance.

### 2.3 Tensor Network Methods

Tensor networks provide a unified framework for both quantum simulation and classical combinatorial optimization.

**Tropical Tensor Networks** (Liu, Wang & Zhang, PRL 2021):
- Replace (sum, product) algebra with (max, sum) tropical algebra
- Exact ground state energy via tensor network contraction
- Ground state configuration via automatic differentiation
- Solution counting via mixed tropical-ordinary algebra
- Applications: 1024-spin square lattice, 512-qubit D-Wave chimera graph in <100s on single GPU

**Recent Advances**:
- **MeLoCoToN** (2025): Explicit solution equations for arbitrary combinatorial problems via tensor networks
- **Quick design of feasible tensor networks** (Nakada et al., Quantum 2025): Algebraic construction of constraint-satisfying tensor networks without penalty functions
- **Programming guide for CSPs with tensor networks** (Gao et al., Chinese Physics B 2025): Julia ecosystem for CSP solving with emphasis on problem reductions

**Key insight**: Tensor network contraction complexity is exponential in treewidth. Efficient contraction orders—often discovered via graph decomposition heuristics—are essential for practical applications.

### 2.4 Branching Algorithms

Classical branching algorithms remain highly competitive for many NP-hard problems.

**Automated Discovery of Branching Rules** (Gao et al., 2024):
- Machine learning-guided search for optimal branching rules for MIS
- Discovered rules with provably optimal worst-case complexity O(1.0560ⁿ)
- Demonstrates that AI can discover algorithms matching or exceeding human-designed heuristics

---

## 3. The Problem Reduction Landscape

### 3.1 Classical Reduction Theory

NP-completeness theory provides a rich framework for problem reductions. Key results:
- All NP-complete problems are polynomial-time reducible to each other
- Many problems have natural Ising/QUBO formulations (Lucas, Frontiers in Physics 2014)
- Reduction gadgets encode logical constraints via graph or algebraic constructions

### 3.2 The problem-reductions Library

The [problem-reductions](https://github.com/CodingThrust/problem-reductions) Rust library aims to implement **100+ NP-hard problems and reduction rules** with AI assistance.

**Architecture**:
```rust
// Example: Reduce Independent Set to ILP
let problem = IndependentSet::<i32>::new(...);
let target = ReduceTo::<IntegerLinearProgram>::reduce_to(&problem);
let solution = solve(target);
let original_solution = extraction::solution(&problem, &target, &solution);
```

**Key Features**:
- Generic type system supporting arbitrary numeric types
- Bidirectional reduction with solution extraction
- Integration with external solvers (ILP, SAT, etc.)
- Contribution model: "10 non-trivial reductions → paper authorship"

**Current Gaps**:
- Manual implementation of reduction rules is labor-intensive
- Hardware-specific reductions (to unit-disk graphs, QUBO with topology constraints) are underexplored
- No automated verification of reduction correctness

### 3.3 Hardware-Specific Reduction Challenges

| Target Platform | Reduction Challenge | Current Solutions |
|----------------|--------------------|--------------------|
| Rydberg (KSG) | Arbitrary graph → unit-disk graph | Crossing gadgets (8 vertices optimal) |
| Rydberg (TLSG) | Arbitrary graph → triangular unit-disk | 12-vertex crossing gadget (Pan et al., 2025) |
| D-Wave | QUBO → Pegasus/Zephyr embedding | Minor embedding heuristics |
| Tensor Networks | Problem → graphical model | Factor graph construction |

---

## 4. LLMs for Algorithm and Reduction Discovery

### 4.1 LLMs as Meta-Optimizers

Recent work demonstrates LLMs' capability to generate and improve optimization algorithms:

**HeuriGym Benchmark** (Cornell, 2025):
- Nine combinatorial optimization problems for evaluating LLM reasoning
- Top LLMs (GPT-o4-mini, Gemini-2.5-Pro) can mimic and iteratively refine heuristic strategies
- Substantial gap remains vs. expert-designed tools

**LLMs as End-to-End CO Solvers** (arXiv:2509.16865):
- 7B-parameter LLM achieves 1-8% optimality gap on seven NP-hard problems
- Surpasses GPT-4o and domain-specific heuristics after fine-tuning

**HeurAgenix** (2025):
- Two-stage hyper-heuristic framework: evolve heuristics, then adaptively select
- First LLM-based framework to evolve diverse heuristic pools without external solvers

**Combinatorial Optimization for All** (arXiv:2503.10968):
- LLM-generated algorithm variants improve over baselines without requiring optimization expertise
- Democratizes access to algorithm development

### 4.2 AlphaEvolve and Mathematical Discovery

Google DeepMind's **AlphaEvolve** (2025) represents a paradigm shift:
- Applied to 50+ open mathematical problems
- Improved best-known solutions in **20% of cases**
- Discovered 48-multiplication algorithm for 4×4 matrices, breaking Strassen's 50-year record
- Established new lower bound (593 spheres) for kissing number in 11 dimensions

**Implications for Problem Reductions**:
- AlphaEvolve-style evolution could discover novel reduction gadgets
- Formal verification could ensure correctness of discovered reductions

### 4.3 Mathematical Reasoning Advances

- **rStar-Math** (Microsoft, 2025): Monte Carlo tree search + step-by-step reasoning; Qwen-7B solves 53% of AIME 2024
- **Gemini Deep Think**: Gold medal performance on 2025 International Math Olympiad
- **o1/o3 reasoning models**: 83% accuracy on IMO problems vs. 13% for GPT-4o

**Opportunity**: These reasoning capabilities could be applied to:
1. Proving correctness of reduction rules
2. Discovering novel reductions via search over reduction space
3. Optimizing reduction parameters for specific hardware constraints

---

## 5. Bridging the Gap: LLMs for Hardware-Aware Reductions

### 5.1 The Vision

```
┌──────────────────┐     ┌─────────────────────────────────┐     ┌──────────────────┐
│  Problem Class   │ ──▶ │  LLM-Generated Reduction Code   │ ──▶ │  Hardware-Native │
│  (e.g., SAT,     │     │  + Correctness Proof            │     │  Representation  │
│   TSP, Clique)   │     │  + Complexity Analysis          │     │  (QUBO, MIS, TN) │
└──────────────────┘     └─────────────────────────────────┘     └──────────────────┘
```

### 5.2 Key Technical Challenges

1. **Gadget Discovery**
   - Input: Source problem, target problem, hardware constraints (topology, connectivity)
   - Output: Minimal-overhead gadget construction
   - Current approach: Integer linear programming (Pan et al., 2025)
   - LLM opportunity: Generate candidate gadgets, verify via SMT solvers

2. **Reduction Correctness**
   - Formal verification that reduction preserves solution structure
   - Integration with Lean4/mathlib for automated proofs
   - LLM-generated proof sketches, human/automated verification

3. **Overhead Optimization**
   - Minimize qubit/vertex overhead in reductions
   - Hardware-aware embedding optimization
   - Multi-objective optimization: overhead vs. fidelity vs. coherence time

4. **Solution Extraction**
   - Efficient back-mapping from hardware solutions to original problem
   - Handling hardware errors and constraint violations
   - Probabilistic decoding for noisy quantum outputs

### 5.3 Proposed Methodology

**Phase 1: Knowledge Base Construction**
- Systematically encode existing reduction rules in machine-readable format
- Annotate with complexity bounds, hardware constraints, known limitations
- Build on problem-reductions library

**Phase 2: LLM-Guided Discovery**
- Fine-tune LLMs on reduction examples and computational complexity literature
- Use AlphaEvolve-style iterative refinement for gadget optimization
- Integrate formal verification for correctness guarantees

**Phase 3: Hardware Integration**
- Develop end-to-end pipelines for each platform (Rydberg, D-Wave, TN)
- Benchmark on standard problem instances
- Validate with physical experiments

---

## 6. The PI's Research Foundation

### 6.1 Publication Track Record

Prof. Jin-Guo Liu (HKUST-GZ) has established a strong foundation in this area:

| Publication | Venue | Citations | Relevance |
|-------------|-------|-----------|-----------|
| Quantum optimization of MIS using Rydberg arrays | Science 2022 | 573 | Hardware platform |
| Tropical tensor network for spin glasses | PRL 2021 | N/A | TN optimization |
| Computing solution space properties via generic TNs | SIAM Review 2023 | N/A | TN methods |
| Yao.jl: Quantum algorithm framework | Quantum 2020 | 237 | Software tools |
| Differentiable programming tensor networks | PRX 2019 | 341 | AD for optimization |

### 6.2 Software Ecosystem

- **Yao.jl**: Quantum algorithm design framework
- **TropicalTensors.jl**: Tropical algebra for optimization
- **GenericTensorNetworks.jl**: Solution space analysis
- **UnitDiskMapping.jl**: Graph-to-unit-disk reduction
- **GadgetSearch.jl**: Automated gadget discovery
- **problem-reductions**: Rust library for NP-hard reductions

### 6.3 Recent Work Directly Relevant to Proposal

1. **Encoding hard problems in triangular Rydberg arrays** (Pan et al., 2025):
   - Automated gadget search via integer programming
   - 100× reduction in constraint violations
   - Direct application to LLM-assisted gadget discovery

2. **Programming guide for CSPs with tensor networks** (Gao et al., 2025):
   - Comprehensive framework for reduction-based CSP solving
   - Julia ecosystem demonstrating practical implementation

3. **Automated discovery of branching rules** (Gao et al., 2024):
   - ML-guided algorithm discovery achieving optimal complexity
   - Proof of concept for AI-assisted algorithm design

---

## 7. Research Gaps and Opportunities

### 7.1 Current Limitations

1. **Manual Reduction Design**: Existing reductions are hand-crafted by experts; no systematic automation
2. **Platform Fragmentation**: Different communities (quantum, TN, classical) develop reductions independently
3. **Lack of Formal Verification**: Most reductions lack machine-checkable correctness proofs
4. **Hardware Mismatch**: Academic reductions often ignore practical hardware constraints

### 7.2 Opportunities for LLM-Assisted Approaches

| Opportunity | Technical Approach | Expected Impact |
|-------------|-------------------|-----------------|
| Automated gadget discovery | LLM code generation + ILP verification | 10× faster reduction development |
| Cross-platform reduction library | Unified Rust/Julia framework | Democratize access to hardware |
| Formal verification | LLM proof sketches + Lean4 | Guaranteed correctness |
| Hardware-aware optimization | Reinforcement learning with hardware feedback | Improved solution quality |

### 7.3 Synergies with Emerging Trends

- **Reasoning models** (o1, Gemini Deep Think): Enhanced logical reasoning for reduction design
- **Code generation** (Claude, GPT-4): Direct generation of reduction code
- **Formal methods** (AlphaProof): Automated verification of reduction correctness
- **Hybrid quantum-classical**: Co-design of reductions for hybrid workflows

---

## 8. Conclusion

The convergence of three trends creates a unique opportunity:

1. **Maturing physical platforms**: Rydberg arrays (289+ qubits), D-Wave (5000+ qubits), tensor network methods reaching practical problem sizes

2. **Fundamental need for reductions**: The gap between native hardware representations and real-world problems requires systematic reduction frameworks

3. **LLM capabilities**: State-of-the-art LLMs can generate code, reason about algorithms, and even prove mathematical theorems

By leveraging LLMs to automate the discovery, verification, and optimization of problem reductions, we can:
- **Accelerate** the development of reduction rules from months to hours
- **Democratize** access to specialized hardware for non-experts
- **Guarantee** correctness through formal verification
- **Optimize** for specific hardware constraints and error models

The problem-reductions library provides an ideal foundation, and the PI's established expertise in tensor networks, quantum optimization, and software development uniquely positions this research program for success.

---

## References

### PI's Key Publications
1. Ebadi, S., Keesling, A., Cain, M., ... **Liu, J.-G.**, et al. "Quantum optimization of maximum independent set using Rydberg atom arrays." *Science* 376, 1209-1215 (2022).
2. **Liu, J.-G.**, Wang, L., & Zhang, P. "Tropical Tensor Network for Ground States of Spin Glasses." *Physical Review Letters* 126, 090506 (2021).
3. **Liu, J.-G.**, Gao, X., Cain, M., Lukin, M.D., & Wang, S.-T. "Computing Solution Space Properties of Combinatorial Optimization Problems Via Generic Tensor Networks." *SIAM Review* (2023).
4. Luo, X.-Z., **Liu, J.-G.**, Zhang, P., & Wang, L. "Yao.jl: Extensible, efficient framework for quantum algorithm design." *Quantum* 4, 341 (2020).
5. Pan, X.-W., Zhou, H.-H., Lu, Y.-M., & **Liu, J.-G.** "Encoding computationally hard problems in triangular Rydberg atom arrays." arXiv (2025).
6. Gao, X., Li, X., & **Liu, J.-G.** "Programming guide for solving constraint satisfaction problems with tensor networks." *Chinese Physics B* 34, 050201 (2025).

### LLM and Algorithm Discovery
7. [HeuriGym: Benchmarking LLMs for Combinatorial Optimization](https://www.cs.cornell.edu/gomes/pdf/2025_chen_arxiv_heurigym.pdf) (Cornell, 2025)
8. [LLMs as End-to-End CO Solvers](https://arxiv.org/abs/2509.16865) (2025)
9. [Combinatorial Optimization for All](https://arxiv.org/abs/2503.10968) (2025)
10. [AlphaEvolve: Gemini-powered coding agent](https://deepmind.google/blog/alphaevolve-a-gemini-powered-coding-agent-for-designing-advanced-algorithms/) (DeepMind, 2025)
11. [A smarter way for LLMs to think about hard problems](https://news.mit.edu/2025/smarter-way-large-language-models-think-about-hard-problems-1204) (MIT, 2025)

### Hardware Platforms
12. Nguyen, M.-T., **Liu, J.-G.**, Wurtz, J., et al. "Quantum optimization with arbitrary connectivity using Rydberg atom arrays." *PRX Quantum* 4, 010316 (2023).
13. [D-Wave Quantum Advantage](https://www.nature.com/articles/s41598-025-96220-2) (*Scientific Reports*, 2025)
14. [Quantum annealing benchmarking study](https://www.nature.com/articles/s41534-025-01020-1) (*npj Quantum Information*, 2025)

### Tensor Networks
15. [Quick design of feasible tensor networks for constrained combinatorial optimization](https://quantum-journal.org/papers/q-2025-07-21-1799/) (*Quantum*, 2025)
16. [MeLoCoToN: Explicit Solution Equation via Tensor Networks](https://arxiv.org/abs/2502.05981) (2025)

### Software
17. [problem-reductions library](https://github.com/CodingThrust/problem-reductions) (GitHub)
18. [UnitDiskMapping.jl](https://github.com/QuEraComputing/UnitDiskMapping.jl) (GitHub)
19. [GadgetSearch.jl](https://github.com/isPANN/GadgetSearch.jl) (GitHub)
