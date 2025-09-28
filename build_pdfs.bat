@echo off
setlocal enabledelayedexpansion

REM ---- Settings ----
set INPUT=Chris_Galvez_Resume.md
set ATS_OUT=Chris_Galvez_Resume_FINAL.pdf
set COLOR_OUT=alt_versions\Chris_Galvez_Resume_COLOR.pdf

REM Ensure folders exist
if not exist alt_versions mkdir alt_versions
if not exist tools mkdir tools

REM Build ATS-safe (strip emojis, plain font)
echo [1/3] Stripping emojis for ATS-safe build...
python tools\strip_emoji.py "%INPUT%" ".tmp_noemoji.md" || goto :error

echo [2/3] Building ATS PDF...
pandoc ".tmp_noemoji.md" -o "%ATS_OUT%" --pdf-engine=xelatex -V mainfont="TeX Gyre Heros" || goto :error

REM Build Color (keep emojis, use Unicode-friendly font)
echo [3/3] Building Color PDF (Unicode font)...
pandoc "%INPUT%" -o "%COLOR_OUT%" --pdf-engine=xelatex -V mainfont="DejaVu Sans" || goto :error

del ".tmp_noemoji.md" 2>nul
echo Done.
exit /b 0

:error
echo Build failed. See messages above.
exit /b 1
