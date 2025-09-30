param(
  [string]$AtsOut   = "Chris_Galvez_Resume_FINAL.pdf",
  [string]$ColorOut = "alt_versions/Chris_Galvez_Resume_COLOR.pdf"
)
$ErrorActionPreference = "Stop"

if (Test-Path ".\build_pdfs.bat") { & ".\build_pdfs.bat" }
elseif (Test-Path ".\build_pdfs.sh") { & bash "./build_pdfs.sh" }
else { throw "No build script found (build_pdfs.bat or build_pdfs.sh)." }

New-Item -Force -ItemType Directory preview | Out-Null
Copy-Item -Force $AtsOut   ".\preview\ATS.pdf"
Copy-Item -Force $ColorOut ".\preview\Color.pdf"

# keep your working tree clean
git restore --worktree -- $AtsOut $ColorOut 2>$null

Invoke-Item ".\preview\ATS.pdf"
Invoke-Item ".\preview\Color.pdf"
