#!/data/data/com.termux/files/usr/bin/bash
# Git 一键推送脚本
# 用法: bash 一键推送.sh [提交信息]
# 交互式输入用户名和 token（如果未配置）

echo "=============================="
echo "     Git 一键推送工具"
echo "=============================="
echo ""

# 检查是否为 Git 仓库
if [ ! -d .git ]; then
    echo "✗ 当前目录不是 Git 仓库"
    exit 1
fi

# 检查是否有远程仓库
if ! git remote get-url origin &>/dev/null; then
    echo "未配置远程仓库"
    echo "请先运行「绑定Git仓库.sh」配置远程仓库"
    exit 1
fi

# 获取提交信息
COMMIT_MSG="${1:-$(date "+%Y-%m-%d %H:%M:%S")}"

# 检查是否有变更
if git diff --quiet && git diff --cached --quiet; then
    # 检查是否有未跟踪文件
    if [ -z "$(git ls-files --others --exclude-standard)" ]; then
        echo "没有需要提交的变更"
        exit 0
    fi
fi

echo "提交信息: $COMMIT_MSG"
echo ""

# 添加所有变更
echo "正在添加文件..."
git add .

# 提交
echo "正在提交..."
git commit -m "$COMMIT_MSG" 2>/dev/null

if [ $? -ne 0 ]; then
    echo "没有新的变更需要提交"
    exit 0
fi

# 获取当前分支
BRANCH=$(git rev-parse --abbrev-ref HEAD)
echo "当前分支: $BRANCH"
echo ""

# 推送
echo "正在推送到远程仓库..."
git push origin "$BRANCH"

if [ $? -eq 0 ]; then
    echo ""
    echo "✓ 推送成功！"
    echo "  分支: $BRANCH"
    echo "  提交: $COMMIT_MSG"
else
    echo ""
    echo "✗ 推送失败"
    echo "可能原因:"
    echo "  1. Token 过期或权限不足"
    echo "  2. 网络连接问题"
    echo "  3. 远程仓库有新的提交，请先 pull"
    exit 1
fi

echo ""
echo "=============================="
