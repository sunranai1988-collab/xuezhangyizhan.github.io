# 一键部署到 GitHub Pages
# 双击运行，或右键 -> 使用 PowerShell 运行

$ErrorActionPreference = "Stop"

Write-Host ""
Write-Host "============================================" -ForegroundColor Cyan
Write-Host "       🚀 一键部署到 GitHub Pages" -ForegroundColor Cyan
Write-Host "============================================" -ForegroundColor Cyan
Write-Host ""

$scriptPath = Split-Path -Parent $MyInvocation.MyCommand.Path
Set-Location $scriptPath

try {
    git status | Out-Null
} catch {
    Write-Host "❌ 当前目录不是 Git 仓库" -ForegroundColor Red
    Write-Host ""
    Read-Host "按回车键退出"
    exit 1
}

$changes = git status --porcelain

if ([string]::IsNullOrEmpty($changes)) {
    Write-Host "✅ 没有新的改动，不需要部署" -ForegroundColor Green
    Write-Host ""
    Write-Host "💡 提示：把新的HTML文件放进当前文件夹后再运行" -ForegroundColor Yellow
    Write-Host ""
    Read-Host "按回车键退出"
    exit 0
}

Write-Host "📝 检测到以下改动：" -ForegroundColor Yellow
$changes | ForEach-Object { Write-Host "   $_" -ForegroundColor Gray }
Write-Host ""

Write-Host "🔄 正在提交并上传..." -ForegroundColor Cyan
Write-Host ""

$timestamp = Get-Date -Format "yyyy-MM-dd HH:mm"
git add .
git commit -m "更新测试页面 - $timestamp" | Out-Null
git push 2>&1 | Out-Null

Write-Host ""
Write-Host "============================================" -ForegroundColor Green
Write-Host "       ✅ 部署成功！" -ForegroundColor Green
Write-Host "============================================" -ForegroundColor Green
Write-Host ""
Write-Host "📌 网页会在 2-3 分钟后自动更新" -ForegroundColor Yellow
Write-Host ""
Write-Host "🔗 首页地址：" -ForegroundColor Cyan
Write-Host "   https://sunranai1988-collab.github.io/xuezhangyizhan.github.io/" -ForegroundColor White
Write-Host ""
Write-Host "💬 聊天反应力测试：" -ForegroundColor Cyan
Write-Host "   https://sunranai1988-collab.github.io/xuezhangyizhan.github.io/chat-test.html" -ForegroundColor White
Write-Host ""

Read-Host "按回车键退出"
