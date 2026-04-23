#!/bin/bash
# ============================================
# 📝 使用说明
# ============================================
# 1. 保存脚本：将本文件保存为 push.sh，放在你的项目根目录。
# 2. 赋予执行权限：chmod +x push.sh
# 3. 运行：./push.sh
#
# 功能：首次推送 / 后续更新 全自动
# 特点：不上传自身、相对目录、任意项目通用、自动处理无远程仓库的情况
# ============================================

set -e  # 遇到错误立即退出

echo "=== 通用 GitHub 一键推送脚本 ==="
echo ""
echo "功能：首次推送 / 后续更新 全自动"
echo "特点：不上传自身、相对目录、任意项目通用、自动处理无远程仓库的情况"
echo ""

# 切换到脚本所在目录（任意位置都能用）
cd "$(dirname "$0")"

# 忽略 push.sh 自身，绝对不上传
if [ ! -f .gitignore ]; then
  echo "push.sh" > .gitignore
  echo "✅ 已创建 .gitignore 忽略脚本自身"
else
  grep -qxF "push.sh" .gitignore || echo "push.sh" >> .gitignore
fi

# 检查是否 Git 仓库，不是就自动初始化
if ! git rev-parse --git-dir > /dev/null 2>&1; then
  echo "❌ 当前不是 Git 仓库，正在初始化..."
  git init
  echo "✅ Git 仓库初始化完成"
fi

# 固定你的身份信息（可自行修改）
git config user.name "txhtxh11"
git config user.email "txh1122@live.com"

# 检测文件变更，没有就跳过提交
if git diff --quiet && git diff --cached --quiet && [ -z "$(git ls-files --others --exclude-standard)" ]; then
  echo "⚠️ 没有文件变更，跳过提交"
else
  echo "📁 添加所有文件..."
  git add .
  echo "✅ 提交更改..."
  git commit -m "Update: $(date '+%Y-%m-%d %H:%M:%S')"
fi

# 检查是否已绑定远程仓库 origin
if ! git remote get-url origin > /dev/null 2>&1; then
  echo "⚠️ 当前项目未绑定远程仓库 (origin)"
  echo "请在 GitHub 上创建新仓库后，复制仓库地址（如 https://github.com/用户名/仓库名.git）"
  read -p "请输入 GitHub 仓库地址: " REPO_URL
  git remote add origin "$REPO_URL"
  echo "✅ 远程仓库已添加"
fi

# 获取当前分支名（如果处于 detached HEAD 则报错）
CURRENT_BRANCH=$(git branch --show-current)
if [ -z "$CURRENT_BRANCH" ]; then
  echo "❌ 无法获取当前分支名，请确保不在 detached HEAD 状态"
  echo "可以尝试先执行: git checkout -b main"
  exit 1
fi

echo ""
echo "🔗 当前远程仓库: $(git remote get-url origin)"
echo "🌿 当前分支: $CURRENT_BRANCH"
echo ""
echo "🚀 正在推送到 GitHub ($CURRENT_BRANCH 分支)..."
echo ""
echo "🔑 如提示输入："
echo "用户名：txhtxh11"
echo "密码：你的 GitHub 令牌（ghp_开头）"
echo ""

# 推送（通用所有仓库，使用当前分支）
if git push -u origin "$CURRENT_BRANCH"; then
  echo ""
  echo "🎉 推送成功！"
  echo "仓库地址: $(git remote get-url origin | sed 's/\.git$//')"
else
  echo ""
  echo "❌ 推送失败！"
  echo "常见原因："
  echo "  - 令牌无效或权限不足（需要 repo 范围）"
  echo "  - 远程仓库已有不同历史（可尝试先 git pull --rebase）"
  echo "  - 网络问题"
  echo "  - GitHub 安全拦截（去仓库 Settings → Code security → Secret scanning 解除）"
  exit 1
fi

echo ""
read -p "按回车退出"
