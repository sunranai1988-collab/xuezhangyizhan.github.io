@echo off
chcp 65001 >nul
title 一键部署到 GitHub Pages

echo ============================================
echo        🚀 一键部署到 GitHub Pages
echo ============================================
echo.

cd /d "%~dp0"

git status >nul 2>&1
if %errorlevel% neq 0 (
    echo ❌ 当前目录不是 Git 仓库
    echo.
    pause
    exit /b 1
)

for /f "delims=" %%i in ('git status --porcelain') do set changes=%%i

if "%changes%"=="" (
    echo ✅ 没有新的改动，不需要部署
    echo.
    echo 提示：把新的HTML文件放进当前文件夹后再运行
    echo.
    pause
    exit /b 0
)

echo 📝 检测到以下改动：
git status --short
echo.

echo 🔄 正在提交并上传...
echo.

git add .
git commit -m "更新测试页面 - %date:~0,4%-%date:~5,2%-%date:~8,2% %time:~0,2%:%time:~3,2%"
git push

if %errorlevel% equ 0 (
    echo.
    echo ============================================
    echo        ✅ 部署成功！
    echo ============================================
    echo.
    echo 📌 网页会在 2-3 分钟后自动更新
    echo 🔗 访问地址：
    echo    https://sunranai1988-collab.github.io/xuezhangyizhan.github.io/
    echo.
) else (
    echo.
    echo ❌ 部署失败，请检查网络或 GitHub 权限
    echo.
)

pause
