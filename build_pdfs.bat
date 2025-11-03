@echo off
setlocal

set INPUT=Chris_Galvez_Resume.md
set ATS_OUT=Chris_Galvez_Resume_FINAL.pdf
set COLOR_OUT=alt_versions\Chris_Galvez_Resume_COLOR.pdf

if not exist alt_versions mkdir alt_versions
if not exist tex_includes mkdir tex_includes

echo [1/3] Stripping emojis for ATS-safe build...
python tools\strip_emoji.py "%INPUT%" ".tmp_noemoji.md" || goto :error

echo [2/3] Building ATS PDF (B/W)...
pandoc ".tmp_noemoji.md" -o "%ATS_OUT%" --pdf-engine=xelatex ^
  -V mainfont="Latin Modern Roman" ^
  -V geometry:margin=1in ^
  -V colorlinks=false -V linkcolor=black -V urlcolor=black ^
  -M title="Chris Galvez - Resume (ATS)" ^
  -M author="Chris Galvez" ^
  -M subject="Software/QA Resume" ^
  -M keywords="QA, Python, Automation, Resume" ^
  -H tex_includes\typography.tex || goto :error

echo [3/3] Building Color PDF (blue headers)...
pandoc "%INPUT%" -o "%COLOR_OUT%" --pdf-engine=xelatex ^
  -V mainfont="Latin Modern Roman" ^
  -V geometry:margin=1in ^
  -V colorlinks=false -V linkcolor=black -V urlcolor=black ^
  -M title="Chris Galvez - Resume (Color)" ^
  -M author="Chris Galvez" ^
  -M subject="Software/QA Resume" ^
  -M keywords="QA, Python, Automation, Resume" ^
  -H tex_includes\typography.tex ^
  -H tex_includes\color_headers.tex || goto :error


del ".tmp_noemoji.md" >nul 2>&1
echo Done.
exit /b 0

:error
echo Build failed. See messages above.
exit /b 1
