param(
    [string]$Mode,
    [string]$TemplateBaseUrl = "https://raw.githubusercontent.com/linxiaobin0023/agent-harness/main"
)

$ErrorActionPreference = "Stop"

function Select-Mode {
    Write-Host "请选择要安装的模板版本："
    Write-Host "  1. 精简版（min）"
    Write-Host "  2. 全量版（full）"
    $choice = Read-Host "请输入 1 或 2"

    if ($choice -eq "1") {
        return "min"
    }

    if ($choice -eq "2") {
        return "full"
    }

    Write-Host "输入无效，已退出。"
    exit 1
}

if ([string]::IsNullOrWhiteSpace($Mode)) {
    $Mode = Select-Mode
}

if ($Mode -ne "min" -and $Mode -ne "full") {
    Write-Host "Usage: powershell -ExecutionPolicy Bypass -File .\init.ps1 [-Mode min|full]"
    exit 1
}

Write-Host "当前选择的模板版本：$Mode"

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

Write-Host "正在下载模板元数据..."
Invoke-WebRequest -Uri $versionUrl -OutFile $versionFile
Invoke-WebRequest -Uri $templateUrl -OutFile $templateFile

Write-Host "正在解压模板..."
Expand-Archive -Path $templateFile -DestinationPath (Get-Location) -Force

Write-Host "安装完成。"
Write-Host "当前模式：$Mode"
Write-Host "请先打开 Cursor 并阅读 .cursor/CURSOR.md。"
