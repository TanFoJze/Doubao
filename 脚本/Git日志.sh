#!/data/data/com.termux/files/usr/bin/bash
# Git 提交日志查看脚本
# 用法: bash Git日志.sh [数量]

COUNT="${1:-10}"

echo "=============================="
echo "      Git 提交日志"
echo "=============================="
echo ""

if [ ! -d .git ]; then
    echo "✗ 当前目录不是 Git 仓库"
    exit 1
fi

git log --pretty=format:"%h | %an | %ad | %s" --date=format:"%Y-%m-%d %H:%M" -n "$COUNT" | sed 's/^/  /'

echo ""
echo ""
echo "=============================="
