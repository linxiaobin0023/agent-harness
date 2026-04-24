param(
    [string]$Mode,
    [string]$TemplateBaseUrl = "https://raw.githubusercontent.com/linxiaobin0023/agent-harness/main"
)

$ErrorActionPreference = "Stop"

function Write-Stage([string]$Stage, [string]$Message, [ConsoleColor]$Color) {
    Write-Host "[$Stage] $Message" -ForegroundColor $Color
}

function Select-Mode {
    Write-Stage "SELECT" "Choose a template package:" Cyan
    Write-Host "  1. Minimal (min)"
    Write-Host "  2. Full (full)"
    $choice = Read-Host "Enter 1 or 2"

    if ($choice -eq "1") { return "min" }
    if ($choice -eq "2") { return "full" }

    Write-Stage "ERROR" "Invalid input. Exiting." Red
    exit 1
}

if ([string]::IsNullOrWhiteSpace($Mode)) {
    $Mode = Select-Mode
}

if ($Mode -ne "min" -and $Mode -ne "full") {
    Write-Stage "ERROR" "Usage: powershell -ExecutionPolicy Bypass -File .\init.ps1 [-Mode min|full]" Red
    exit 1
}

Write-Stage "SELECT" "Selected mode: $Mode" Cyan

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
$projectRoot = Get-Location

Write-Stage "DOWNLOAD" "Downloading version metadata..." Yellow
Invoke-WebRequest -Uri $versionUrl -OutFile $versionFile
Write-Stage "DOWNLOAD" "Downloading template package..." Yellow
Invoke-WebRequest -Uri $templateUrl -OutFile $templateFile

Write-Stage "EXTRACT" "Extracting template into project root..." Green
Expand-Archive -Path $templateFile -DestinationPath $projectRoot -Force

Write-Stage "DONE" "Installation complete." Green
Write-Stage "DONE" "Mode: $Mode" Green
Write-Stage "DONE" "Open Cursor and read .cursor/CURSOR.md first." Green
