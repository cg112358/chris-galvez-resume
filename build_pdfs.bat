@echo off
setlocal

set INPUT=Chris_Galvez_Resume.md
set ATS_OUT=output\Chris_Galvez_Resume_FINAL.pdf
set COLOR_OUT=alt_versions\Chris_Galvez_Resume_COLOR.pdf

if not exist alt_versions mkdir alt_versions
if not exist output mkdir output

echo [1/3] Stripping emojis for ATS-safe build...
python tools\strip_emoji.py "%INPUT%" ".tmp_noemoji.md" || goto :error

echo [2/3] Building ATS PDF...
pandoc ".tmp_noemoji.md" -o "%ATS_OUT%" ^
  --pdf-engine=xelatex ^
  -V papersize=letter ^
  -V geometry:letterpaper ^
  -V geometry:left=0.65in ^
  -V geometry:right=0.65in ^
  -V geometry:top=0.6in ^
  -V geometry:bottom=0.7in ^
  -H tex_includes\margins.tex ^
  -H tex_includes\typography.tex || goto :error

echo [3/3] Building Color PDF (Unicode font)...
pandoc "%INPUT%" -o "%COLOR_OUT%" ^
  --pdf-engine=xelatex ^
  -V papersize=letter ^
  -V geometry:letterpaper ^
  -V geometry:left=0.65in ^
  -V geometry:right=0.65in ^
  -V geometry:top=0.6in ^
  -V geometry:bottom=0.7in ^
  -H tex_includes\margins.tex ^
  -H tex_includes\typography.tex ^
  -H tex_includes\color_headers.tex || goto :error

del ".tmp_noemoji.md" >nul 2>&1
echo Done.
exit /b 0

:error
echo Build failed. See messages above.
exit /b 1
