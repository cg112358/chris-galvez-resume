#!/usr/bin/env bash
set -euo pipefail

INPUT="Chris_Galvez_Resume.md"
ATS_OUT="output/Chris_Galvez_Resume_FINAL.pdf"
COLOR_OUT="alt_versions/Chris_Galvez_Resume_COLOR.pdf"

mkdir -p alt_versions output

echo "[1/3] Stripping emojis for ATS-safe build..."
python tools/strip_emoji.py "$INPUT" ".tmp_noemoji.md"

echo "[2/3] Building ATS PDF..."
pandoc ".tmp_noemoji.md" -o "$ATS_OUT" \
  --pdf-engine=xelatex \
  -V papersize=letter \
  -V geometry:letterpaper \
  -V geometry:left=0.65in \
  -V geometry:right=0.65in \
  -V geometry:top=0.6in \
  -V geometry:bottom=0.7in \
  -H "tex_includes/margins.tex" \
  -H "tex_includes/typography.tex"

echo "[3/3] Building Color PDF (Unicode font)..."
pandoc "$INPUT" -o "$COLOR_OUT" \
  --pdf-engine=xelatex \
  -V papersize=letter \
  -V geometry:letterpaper \
  -V geometry:left=0.65in \
  -V geometry:right=0.65in \
  -V geometry:top=0.6in \
  -V geometry:bottom=0.7in \
  -H "tex_includes/margins.tex" \
  -H "tex_includes/typography.tex" \
  -H "tex_includes/color_headers.tex"

rm -f ".tmp_noemoji.md"
echo "Done."
