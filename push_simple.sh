#!/bin/bash
# push.sh - 简单推送脚本（仅用于后续更新）
# 首次推送请手动完成

cd /home/t/github项目/ha-hacs-esphome-generator

# 设置提交信息
if [ $# -eq 0 ]; then
    commit_msg="更新"
else
    commit_msg="$1"
fi

echo "📦 添加文件..."
git add .

echo "💾 提交: $commit_msg"
git commit -m "$commit_msg"

echo "🚀 推送到GitHub..."
git push

echo "✅ 完成!"