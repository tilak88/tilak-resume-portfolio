$ErrorActionPreference = 'Stop'
$root = Split-Path -Parent (Split-Path -Parent $MyInvocation.MyCommand.Path)
$tectonic = Join-Path $root '.tools\tectonic-msvc\tectonic.exe'
if (-not (Test-Path -LiteralPath $tectonic)) { throw "Tectonic not found at $tectonic" }
Push-Location (Join-Path $root 'resumes')
try {
    & $tectonic ai_ml_resume.tex --only-cached
    if ($LASTEXITCODE -ne 0) { throw 'AI/ML resume build failed' }
    & $tectonic sde_system_resume.tex --only-cached
    if ($LASTEXITCODE -ne 0) { throw 'SDE/system resume build failed' }
} finally { Pop-Location }

