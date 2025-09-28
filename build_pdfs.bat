@echo off
setlocal enabledelayedexpansion

REM ---- Settings ----
set INPUT=Chris_Galvez_Resume.md
set ATS_OUT=Chris_Galvez_Resume_FINAL.pdf
set COLOR_OUT=alt_versions\Chris_Galvez_Resume_COLOR.pdf

REM Common Pandoc flags: same font + margins for both
set PANDOC_COMMON=--pdf-engine=xelatex -V mainfont="TeX Gyre Heros" -V geometry:margin=0.75in

if not exist alt_versions mkdir alt_versions
if not exist tools mkdir tools

echo [1/3] Stripping emojis for ATS-safe build...
python tools\strip_emoji.py "%INPUT%" ".tmp_noemoji.md" || goto :error

echo [2/3] Building ATS PDF (consistent font & margins)...
pandoc ".tmp_noemoji.md" -o "%ATS_OUT%" %PANDOC_COMMON% || goto :error

echo [3/3] Building Color PDF (same layout; colored links)...
pandoc "%INPUT%" -o "%COLOR_OUT%" %PANDOC_COMMON% -V colorlinks=true -V linkcolor=blue || goto :error

del ".tmp_noemoji.md" 2>nul
echo Done.
exit /b 0

:error
echo Build failed. See messages above.
exit /b 1
