param(
    [string]$Mode,
    [string]$TemplateBaseUrl = "https://raw.githubusercontent.com/linxiaobin0023/agent-harness/main"
)

$ErrorActionPreference = "Stop"

function Select-Mode {
    Write-Host "Choose a template package:"
    Write-Host "  1. Minimal (min)"
    Write-Host "  2. Full (full)"
    $choice = Read-Host "Enter 1 or 2"

    if ($choice -eq "1") { return "min" }
    if ($choice -eq "2") { return "full" }

    Write-Host "Invalid input. Exiting."
    exit 1
}

if ([string]::IsNullOrWhiteSpace($Mode)) {
    $Mode = Select-Mode
}

if ($Mode -ne "min" -and $Mode -ne "full") {
    Write-Host "Usage: powershell -ExecutionPolicy Bypass -File .\init.ps1 [-Mode min|full]"
    exit 1
}

Write-Host "Selected mode: $Mode"

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

Write-Host "Downloading version metadata..."
Invoke-WebRequest -Uri $versionUrl -OutFile $versionFile
Write-Host "Downloading template package..."
Invoke-WebRequest -Uri $templateUrl -OutFile $templateFile

Write-Host "Extracting template..."
Expand-Archive -Path $templateFile -DestinationPath (Get-Location) -Force

Write-Host "Installation complete."
Write-Host "Mode: $Mode"
Write-Host "Open Cursor and read .cursor/CURSOR.md first."
