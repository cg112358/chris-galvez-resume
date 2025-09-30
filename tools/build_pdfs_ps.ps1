param(
  [string]$AtsOut   = "Chris_Galvez_Resume_FINAL.pdf",
  [string]$ColorOut = "alt_versions/Chris_Galvez_Resume_COLOR.pdf"
)
$ErrorActionPreference = "Stop"

if (Test-Path ".\build_pdfs.bat") { & ".\build_pdfs.bat" }
elseif (Test-Path ".\build_pdfs.sh") { & bash "./build_pdfs.sh" }
else { throw "No build script found (build_pdfs.bat or build_pdfs.sh)." }

Invoke-Item $AtsOut
Invoke-Item $ColorOut
