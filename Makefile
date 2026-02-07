# ==============================================================================
# Makefile for NSFC 2026 Proposal
# ==============================================================================
# Targets:
#   make pdf          - Build the proposal PDF (default)
#   make refs-md      - Convert reference PDFs to Markdown (pymupdf4llm)
#   make bib-md       - Convert ref.bib to Markdown (formatted bibliography)
#   make all-md       - Convert both references and bib to Markdown
#   make setup        - Create Python venv and install pymupdf4llm
#   make clean        - Remove LaTeX auxiliary files
#   make distclean    - Remove aux files + generated Markdown
# ==============================================================================

# --- Configuration -----------------------------------------------------------
MAIN_TEX    := 面上项目-正文-2026.tex
MAIN_PDF    := 面上项目-正文-2026.pdf
BIB_FILE    := ref.bib

REF_DIR     := references
MD_DIR      := references/md
SCRIPTS_DIR := scripts
PDF2MD      := $(SCRIPTS_DIR)/pdf2md.sh

VENV_DIR    := .venv
VENV_PYTHON := $(VENV_DIR)/bin/python3

# Bibliography markdown output
BIB_MD      := references/bibliography.md

# --- Default target -----------------------------------------------------------
.PHONY: all
all: pdf

# --- Setup Python venv --------------------------------------------------------
.PHONY: setup
setup: $(VENV_PYTHON)

$(VENV_PYTHON):
	python3 -m venv "$(VENV_DIR)"
	"$(VENV_DIR)/bin/pip" install pymupdf4llm

# --- Build proposal PDF -------------------------------------------------------
.PHONY: pdf
pdf:
	xelatex "$(MAIN_TEX)"
	-bibtex "$(basename $(MAIN_TEX) .tex)"
	xelatex "$(MAIN_TEX)"
	xelatex "$(MAIN_TEX)"

# --- Convert reference PDFs to Markdown ---------------------------------------
# Uses pymupdf4llm for high-quality conversion (preserves formatting, links,
# tables, bold/italic, headers, etc.).
# Shell loop handles filenames with spaces; only re-converts if PDF is newer.
.PHONY: refs-md
refs-md: $(VENV_PYTHON)
	@mkdir -p "$(MD_DIR)"
	@for pdf in "$(REF_DIR)"/*.pdf; do \
		[ -f "$$pdf" ] || continue; \
		md="$(MD_DIR)/$$(basename "$$pdf" .pdf).md"; \
		if [ ! -f "$$md" ] || [ "$$pdf" -nt "$$md" ]; then \
			bash "$(PDF2MD)" "$$pdf" "$$md"; \
		else \
			echo "  Up to date: $$(basename "$$md")"; \
		fi; \
	done

# --- Convert ref.bib to formatted Markdown bibliography -----------------------
.PHONY: bib-md
bib-md: $(BIB_MD)

$(BIB_MD): $(BIB_FILE)
	@echo "  Converting $(BIB_FILE) -> $(BIB_MD)"
	@echo '---'                        >  .tmp_bib.md
	@echo 'bibliography: $(BIB_FILE)' >> .tmp_bib.md
	@echo "nocite: '@*'"               >> .tmp_bib.md
	@echo '---'                        >> .tmp_bib.md
	@echo ''                           >> .tmp_bib.md
	@echo '# Bibliography'             >> .tmp_bib.md
	@pandoc .tmp_bib.md --citeproc -t commonmark --wrap=none -o "$@"
	@rm -f .tmp_bib.md

# --- All Markdown conversions -------------------------------------------------
.PHONY: all-md
all-md: refs-md bib-md

# --- Clean --------------------------------------------------------------------
.PHONY: clean
clean:
	rm -f *.aux *.bbl *.blg *.log *.out *.fdb_latexmk *.fls *.synctex.gz *.gz

.PHONY: distclean
distclean: clean
	rm -rf "$(MD_DIR)"
	rm -f "$(BIB_MD)"

# --- Help ---------------------------------------------------------------------
.PHONY: help
help:
	@echo "Available targets:"
	@echo "  make pdf        - Build proposal PDF with XeLaTeX (default)"
	@echo "  make refs-md    - Convert reference PDFs to Markdown (pymupdf4llm)"
	@echo "  make bib-md     - Convert ref.bib to Markdown bibliography"
	@echo "  make all-md     - Convert both references and bib to Markdown"
	@echo "  make setup      - Create Python venv and install pymupdf4llm"
	@echo "  make clean      - Remove LaTeX auxiliary files"
	@echo "  make distclean  - Remove aux files and generated Markdown"
	@echo "  make help       - Show this help message"
