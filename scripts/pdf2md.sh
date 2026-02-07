#!/usr/bin/env bash
# Convert a PDF file to Markdown using pymupdf4llm.
# Usage: pdf2md.sh input.pdf output.md
#
# Produces a Markdown file with preserved formatting:
#   headers, bold/italic, tables, links, etc.

set -euo pipefail

if [ $# -lt 2 ]; then
    echo "Usage: $0 <input.pdf> <output.md>" >&2
    exit 1
fi

# Resolve to absolute paths
INPUT="$(cd "$(dirname "$1")" && pwd)/$(basename "$1")"
OUTPUT="$(mkdir -p "$(dirname "$2")" && cd "$(dirname "$2")" && pwd)/$(basename "$2")"

# Locate the project venv (relative to this script)
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
PROJECT_DIR="$(dirname "$SCRIPT_DIR")"
VENV_PYTHON="${PROJECT_DIR}/.venv/bin/python3"

if [ ! -x "$VENV_PYTHON" ]; then
    echo "Error: Python venv not found at ${PROJECT_DIR}/.venv" >&2
    echo "Run: make setup" >&2
    exit 1
fi

"$VENV_PYTHON" -c "
import sys, pymupdf4llm
md = pymupdf4llm.to_markdown(sys.argv[1])
with open(sys.argv[2], 'w', encoding='utf-8') as f:
    f.write(md)
" "$INPUT" "$OUTPUT" 2>/dev/null

echo "  Converted: $(basename "$INPUT") -> $(basename "$OUTPUT")"
