param(
    [ValidateSet("min", "full")]
    [string]$Mode,
    [string]$TemplateBaseUrl = "https://raw.githubusercontent.com/linxiaobin0023/agent-harness/main"
)

$ErrorActionPreference = "Stop"

function Write-Info([string]$Message) {
    Write-Host $Message
}

if (-not $Mode) {
    Write-Host "请选择要安装的模板版本："
    Write-Host "  1. 精简版（min）"
    Write-Host "  2. 全量版（full）"
    $choice = Read-Host "请输入 1 或 2"

    switch ($choice) {
        "1" { $Mode = "min" }
        "2" { $Mode = "full" }
        default {
            Write-Host "输入无效，已退出。"
            exit 1
        }
    }
}

Write-Info "当前选择的模板版本：$Mode"

$versionFileName = if ($Mode -eq "min") { "version-min.json" } else { "version-full.json" }
$templateFileName = if ($Mode -eq "min") { "template-min.zip" } else { "template-full.zip" }

Write-Info "正在下载模板元数据..."
$versionUrl = "$TemplateBaseUrl/$versionFileName"
$templateUrl = "$TemplateBaseUrl/$templateFileName"

$versionFile = Join-Path $env:TEMP "agent-harness-$Mode-version.json"
$templateFile = Join-Path $env:TEMP "agent-harness-$Mode-template.zip"

Invoke-WebRequest -Uri $versionUrl -OutFile $versionFile
Invoke-WebRequest -Uri $templateUrl -OutFile $templateFile

Write-Info "正在解压模板..."
Expand-Archive -Path $templateFile -DestinationPath (Get-Location) -Force

Write-Info "安装完成。"
Write-Info "当前模式：$Mode"
Write-Info "请先打开 Cursor 并阅读 .cursor/CURSOR.md。"
