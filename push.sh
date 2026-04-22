#!/bin/bash
# push.sh - 智能推送脚本（自动识别首次/后续推送）
# 用法: ./push.sh "提交描述"

# ========== 配置你的信息 ==========
GITHUB_USER="txhtxh11"
GIT_NAME="t"
GIT_EMAIL="t@sp"
# 令牌在执行时交互输入
# ================================

cd /home/t/github项目/ha-hacs-esphome-generator

# 设置提交信息
if [ $# -eq 0 ]; then
    commit_msg="更新"
else
    commit_msg="$1"
fi

echo "📦 检查Git仓库..."

# 检查是否是首次推送
if [ ! -d ".git" ]; then
    echo "🆕 首次推送：初始化Git仓库..."
    git init -b main
    git config user.name "$GIT_NAME"
    git config user.email "$GIT_EMAIL"
    git add .
    git commit -m "首次提交：ESPHome YAML Generator HACS集成"

    # 交互输入令牌
    read -s -p "请输入GitHub个人令牌: " GITHUB_TOKEN
    echo ""

    REMOTE_URL="https://${GITHUB_USER}:${GITHUB_TOKEN}@github.com/${GITHUB_USER}/ha-hacs-esphome-generator.git"
    echo "🔗 添加远程仓库..."
    git remote add origin "$REMOTE_URL"

    echo "🚀 推送到GitHub..."
    echo "⚠️  如果远程已有内容，将强制覆盖..."
    git push -u origin main --force

    # 推送成功后去掉 URL 中的令牌，后续用缓存
    git remote set-url origin "https://github.com/${GITHUB_USER}/ha-hacs-esphome-generator.git"

    echo "✅ 首次推送完成！"
    exit 0
fi

# 后续推送流程
git config user.name "$GIT_NAME"
git config user.email "$GIT_EMAIL"

# 确保主分支名为 main
CURRENT_BRANCH=$(git symbolic-ref --short HEAD 2>/dev/null)
if [ "$CURRENT_BRANCH" = "master" ]; then
    echo "🔄 将分支 master 重命名为 main..."
    git branch -M main
fi

# 检查是否有远程仓库
if ! git remote | grep -q origin; then
    read -s -p "请输入GitHub个人令牌: " GITHUB_TOKEN
    echo ""
    REMOTE_URL="https://${GITHUB_USER}:${GITHUB_TOKEN}@github.com/${GITHUB_USER}/ha-hacs-esphome-generator.git"
    echo "🔗 添加远程仓库..."
    git remote add origin "$REMOTE_URL"
    # 后续推送也去掉令牌
    git remote set-url origin "https://github.com/${GITHUB_USER}/ha-hacs-esphome-generator.git"
fi

echo "📦 添加文件..."
git add .

if git diff --cached --quiet; then
    echo "⚠️  没有需要提交的变更"
    exit 0
fi

echo "💾 提交: $commit_msg"
git commit -m "$commit_msg"

echo "🚀 推送到GitHub..."
if git rev-parse --abbrev-ref --symbolic-full-name @{upstream} &>/dev/null; then
    git push
else
    git push -u origin main
fi

echo "✅ 完成!"
