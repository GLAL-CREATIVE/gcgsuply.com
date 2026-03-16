# GCG SUPPLY 网站部署脚本
Write-Host "正在部署 GCG SUPPLY 网站到 GitHub..." -ForegroundColor Green

cd "D:\GLOBAL_CREATIVE_GROUP_Products\website"

# 检查是否已初始化
if (-not (Test-Path .git)) {
    git init
    git config user.email "GLAL-CREATIVE@outlook.com"
    git config user.name "GLAL-CREATIVE"
}

# 添加远程仓库
git remote remove origin 2>$null
git remote add origin https://github.com/GLAL-CREATIVE/gcgsuply.com.git

# 提交更改
git add .
git commit -m "Update website content" 2>$null

# 推送到 GitHub
Write-Host "正在推送到 GitHub，请在弹出的窗口中登录..." -ForegroundColor Yellow
git push -u origin main

Write-Host "部署完成！" -ForegroundColor Green
Write-Host "请在 GitHub 仓库设置中启用 GitHub Pages" -ForegroundColor Cyan
pause
