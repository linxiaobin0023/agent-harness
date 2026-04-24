param(
    [string]$Mode,
    [string]$TemplateBaseUrl = "https://raw.githubusercontent.com/linxiaobin0023/agent-harness/main"
)

$ErrorActionPreference = "Stop"

$Ansi = [char]27
function Write-Stage([string]$Stage, [string]$Message, [string]$ColorCode) {
    Write-Host "$Ansi[$ColorCode m[$Stage] $Message$Ansi[0m"
}

function Select-Mode {
    Write-Stage "SELECT" "Choose a template package:" "36"
    Write-Host "  1. Minimal (min)"
    Write-Host "  2. Full (full)"
    $choice = Read-Host "Enter 1 or 2"

    if ($choice -eq "1") { return "min" }
    if ($choice -eq "2") { return "full" }

    Write-Stage "ERROR" "Invalid input. Exiting." "31"
    exit 1
}

if ([string]::IsNullOrWhiteSpace($Mode)) {
    $Mode = Select-Mode
}

if ($Mode -ne "min" -and $Mode -ne "full") {
    Write-Stage "ERROR" "Usage: powershell -ExecutionPolicy Bypass -File .\init.ps1 [-Mode min|full]" "31"
    exit 1
}

Write-Stage "SELECT" "Selected mode: $Mode" "36"

if ($Mode -eq "min") {
    $versionFileName = "releases/min/version.json"
    $templateFileName = "releases/min/template.zip"
} else {
    $versionFileName = "releases/full/version.json"
    $templateFileName = "releases/full/template.zip"
}

$versionUrl = "$TemplateBaseUrl/$versionFileName"
$templateUrl = "$TemplateBaseUrl/$templateFileName"
$versionFile = Join-Path $env:TEMP "agent-harness-$Mode-version.json"
$templateFile = Join-Path $env:TEMP "agent-harness-$Mode-template.zip"
$cursorDir = Join-Path (Get-Location) ".cursor"

Write-Stage "DOWNLOAD" "Downloading version metadata..." "33"
Invoke-WebRequest -Uri $versionUrl -OutFile $versionFile
Write-Stage "DOWNLOAD" "Downloading template package..." "33"
Invoke-WebRequest -Uri $templateUrl -OutFile $templateFile

if (-not (Test-Path $cursorDir)) {
    New-Item -ItemType Directory -Path $cursorDir | Out-Null
}

Write-Stage "EXTRACT" "Extracting template into .cursor..." "32"
Expand-Archive -Path $templateFile -DestinationPath $cursorDir -Force

Write-Stage "DONE" "Installation complete." "32"
Write-Stage "DONE" "Mode: $Mode" "32"
Write-Stage "DONE" "Open Cursor and read .cursor/CURSOR.md first." "32"
