# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

This is an unofficial LaTeX template for NSFC (国家自然科学基金) research proposals. It supports 面上项目 (General Program), 青年基金 (Young Scientists Fund), and 地区项目 (Regional Fund) applications for the 2026 cycle.

## Build Command

```bash
xelatex 面上项目-正文-2026.tex
```

The template **requires XeLaTeX** - do not use pdflatex or other compilers.

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
