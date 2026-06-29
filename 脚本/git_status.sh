#!/data/data/com.termux/files/usr/bin/bash
# Git 状态查看脚本

echo "=============================="
echo "      Git 仓库状态"
echo "=============================="
echo ""

if [ ! -d .git ]; then
    echo "✗ 当前目录不是 Git 仓库"
    exit 1
fi

# 当前分支
BRANCH=$(git rev-parse --abbrev-ref HEAD)
echo "当前分支: $BRANCH"
echo ""

# 远程仓库
echo "远程仓库:"
git remote -v | sed 's/^/  /'
echo ""

# 状态
echo "文件状态:"
git status -s | while read line; do
    echo "  $line"
done

if [ -z "$(git status -s)" ]; then
    echo "  工作区干净，没有变更"
fi

echo ""

# 最近提交
echo "最近 5 次提交:"
git log --oneline -5 | sed 's/^/  /'

echo ""
echo "=============================="
