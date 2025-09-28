#!/usr/bin/env bash
set -euo pipefail

INPUT="Chris_Galvez_Resume.md"
ATS_OUT="Chris_Galvez_Resume_FINAL.pdf"
COLOR_OUT="alt_versions/Chris_Galvez_Resume_COLOR.pdf"

PANDOC_COMMON=(--pdf-engine=xelatex -V mainfont="TeX Gyre Heros" -V geometry:margin=0.75in)

mkdir -p alt_versions tools

echo "[1/3] Stripping emojis for ATS-safe build..."
python tools/strip_emoji.py "$INPUT" ".tmp_noemoji.md"

echo "[2/3] Building ATS PDF..."
pandoc ".tmp_noemoji.md" -o "$ATS_OUT" "${PANDOC_COMMON[@]}"

echo "[3/3] Building Color PDF (same layout; colored links)..."
pandoc "$INPUT" -o "$COLOR_OUT" "${PANDOC_COMMON[@]}" -V colorlinks=true -V linkcolor=blue

rm -f ".tmp_noemoji.md"
echo "Done."
