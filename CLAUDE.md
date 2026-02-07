# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

This is an NSFC (国家自然科学基金) 面上项目 (General Program) proposal for the 2026 cycle.

### Research Topic

**LLM辅助面向物理计算平台的问题规约自动发现与验证**
(LLM-assisted Automatic Discovery and Verification of Problem Reductions for Physical Computing Platforms)

#### Core Scientific Question
How to leverage large language models to automatically discover, verify, and optimize problem reductions for physical computing platforms?

#### Three Research Directions
1. **LLM辅助规约小工具自动发现** - Using LLM + ILP (Integer Linear Programming) to automatically generate and verify reduction gadgets
2. **规约正确性形式化验证** - Formal verification with Lean4/mathlib integration
3. **硬件感知规约优化** - Hardware-aware optimization for Rydberg atoms, D-Wave, and tensor networks

#### Key Technical Terms
- 问题规约 (problem reduction) - mapping one problem to another
- 小工具/gadget - basic structures encoding source problem constraints
- 里德堡原子阵列 (Rydberg atom arrays) - quantum computing platform
- D-Wave量子退火机 - quantum annealing hardware
- 张量网络 (tensor networks) - computational method
- QUBO - Quadratic Unconstrained Binary Optimization
- MIS - Maximum Independent Set
- 单位圆盘图 (unit-disk graph) - native problem for Rydberg arrays

### Planning Documents
- `plan.md` - High-level research plan with key problems to solve
- `personal.md` - Personal notes (not tracked)
- `survey.md` - Literature survey notes

### Applicant Background
刘金国博士 (Dr. Liu Jinguo), 香港科技大学（广州）助理教授
- PhD: Nanjing University (advisor: Prof. Wang Qianghua)
- Postdoc: CAS Institute of Physics (advisor: Prof. Wang Lei), Harvard (advisor: Prof. Mikhail Lukin)
- Industry: QuEra Computing Inc. consultant
- Key software: Yao.jl, GenericTensorNetworks.jl, UnitDiskMapping.jl

### Previous Related Work
- 2024 Rydberg proposal: `~/Documents/nsfc2024rydberg/main/main.tex` - Focus on parallel quantum algorithms for Rydberg atoms
- The current proposal builds on applicant's experience with tensor networks, Rydberg optimization, and open-source quantum software

## Writing Guidelines

### Language & Style
- Write in **Chinese** (正文全部使用中文)
- Use formal academic Chinese with technical precision
- Follow 国家自然科学基金 formatting conventions
- Reference style: GB/T 7714 (handled by `bibs/` citation files)

### LaTeX Conventions
- Use `\textbf{}` for emphasis of key terms
- Use `\cite{}` for citations (defined in `ref.bib`)
- Section structure is NSFC-mandated - do not modify headers
- Figures go in `figures/`, reference as `\includegraphics{filename}`

### Content Guidelines
- 正文 (main text) should not exceed 30 pages
- Be specific about methodology and expected outcomes
- Connect all research directions in a coherent framework
- Emphasize applicant's prior work and unique qualifications

## Build Commands

All workflows are managed via `Makefile`. Run `make help` to see all targets.

```bash
make pdf          # Build proposal PDF with XeLaTeX (default)
make setup        # Create Python venv and install pymupdf4llm
make refs-md      # Convert reference PDFs to Markdown (references/md/)
make bib-md       # Convert ref.bib to Markdown bibliography
make all-md       # Convert both references and bib to Markdown
make clean        # Remove LaTeX auxiliary files
make distclean    # Remove aux files + generated Markdown
```

The template **requires XeLaTeX** - do not use pdflatex or other compilers.

### Dependencies

- **XeLaTeX** (via texlive): `brew install texlive`
- **pandoc**: for bib-to-markdown conversion (`make bib-md`)
- **Python 3.10+** + **pymupdf4llm**: for PDF-to-markdown conversion (`make setup` creates a `.venv` automatically)

## Project Structure

- `面上项目-正文-2026.tex` - Main document (do not modify)
- `nsfc.sty` - Core template styles (avoid modifying unless necessary)
- `sections/` - Content files to edit:
  - `一依据.tex` - 立项依据 (Research rationale)
  - `二内容.tex` - 研究内容 (Research content)
  - `三1基础.tex` to `三4已完成.tex` - 研究基础 (Research foundation)
  - `四*.tex` - 其他说明 (Other declarations)
  - `个性化设置.sty` - User settings (font, color, math font)
- `figures/` - Images (referenced as `\includegraphics{filename}`)
- `ref.bib` - Bibliography
- `bibs/` - GB/T 7714 citation style files
- `fonts/` - Chinese fonts (楷体, 宋体) and math fonts
- `references/` - Research paper PDFs for reference
- `references/md/` - Generated Markdown from reference PDFs (via `make refs-md`)
- `scripts/pdf2md.sh` - Helper script for PDF-to-Markdown conversion using pymupdf4llm

## Configuration

Edit `sections/个性化设置.sty` for:
- Title highlight color: `\definecolor{HighLight}{RGB}{r,g,b}`
- Body font: toggle between 楷体 (`\MS@kaitrue`) and 宋体 (`\MS@songtrue`)
- Content visibility: `\MS@ontrue` (show) or `\MS@offtrue` (hide for structure-only view)
- Math font: set `\selectedmathfont` (options: latinmodern-math, asana-math, cambria-math, texgyrebonum-math, texgyreschola-math, texgyredejavu-math, texgyretermes-math, texgyrepagella-math)

## Key Constraints

- The 正文 (main text) should not exceed 30 pages per NSFC guidelines
- Do not modify section headings or the text in parentheses - these are NSFC-mandated
- Platform support: macOS, Windows, Linux, Overleaf

## Key References (in ref.bib)

### Applicant's Core Work
- `Ebadi2022Science` - Rydberg quantum optimization (Science, 289 qubits)
- `Liu2021PRL` - Tropical tensor networks (PRL)
- `Liu2023SIAM` - Generic tensor networks (SIAM)
- `Nguyen2023PRXQuantum` - King's subgraph encoding (PRX Quantum)
- `Pan2025Triangular` - Triangular lattice encoding (in review)
- `Luo2020Quantum` - Yao.jl quantum simulator

### External Key References
- `AlphaEvolve2025` - Google DeepMind's LLM + evolution system
- `DWave2025Science` - D-Wave quantum advantage (Science)
- `Lucas2014Frontiers` - NP-complete problem reductions review

## Section Content Summary

| File | Content | Status |
|------|---------|--------|
| `一依据.tex` | 立项依据 - Background, significance, literature review | Written |
| `二内容.tex` | 研究内容 - Research framework, 3 directions, timeline | Written |
| `三1基础.tex` | 研究基础 - Applicant background, prior work | Written |
| `三2条件.tex` | 工作条件 - Lab, computing, collaborations | Needs content |
| `三3正承担.tex` | 正在承担项目 - Current grants | Empty/无 |
| `三4已完成.tex` | 已完成项目 - Completed grants | Empty/无 |
| `四1同年申请.tex` | 同年申请说明 | Needs update |
| `四2-6*.tex` | Other declarations | Empty/无 |

## Workflow Tips

1. **Build PDF**: Run `make pdf` to compile with XeLaTeX
2. **Check references**: Ensure all `\cite{}` keys exist in `ref.bib`
3. **View structure**: Set `\MS@offtrue` in `个性化设置.sty` for outline view
4. **Page count**: Check PDF doesn't exceed 30 pages

## Related Repositories

- Previous proposal: `~/Documents/nsfc2024rydberg/`
- Website/blogs referenced in plan.md: `~/website/happy-binaries-website/`
