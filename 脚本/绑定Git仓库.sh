#!/data/data/com.termux/files/usr/bin/bash
# 一键绑定远程 Git 仓库脚本
# 用法: bash 绑定Git仓库.sh
# 交互式输入用户名、token 和仓库地址

echo "=============================="
echo "   Git 仓库一键绑定工具"
echo "=============================="
echo ""

# 检查是否为 Git 仓库
if [ ! -d .git ]; then
    echo "当前目录不是 Git 仓库"
    read -p "是否初始化 Git 仓库？(y/N): " INIT_GIT
    if [ "$INIT_GIT" = "y" ] || [ "$INIT_GIT" = "Y" ]; then
        git init
        echo "✓ Git 仓库已初始化"
    else
        echo "已取消"
        exit 1
    fi
fi

echo ""
read -p "请输入 GitHub 用户名: " USERNAME
read -p "请输入 GitHub Token: " TOKEN
read -p "请输入仓库名 (例如: Doubao): " REPO_NAME

if [ -z "$USERNAME" ] || [ -z "$TOKEN" ] || [ -z "$REPO_NAME" ]; then
    echo "✗ 用户名、Token 和仓库名都不能为空"
    exit 1
fi

REMOTE_URL="https://${USERNAME}:${TOKEN}@github.com/${USERNAME}/${REPO_NAME}.git"

echo ""
echo "正在绑定远程仓库..."

# 检查是否已有 origin
if git remote get-url origin &>/dev/null; then
    read -p "已存在 origin 远程仓库，是否覆盖？(y/N): " OVERWRITE
    if [ "$OVERWRITE" = "y" ] || [ "$OVERWRITE" = "Y" ]; then
        git remote set-url origin "$REMOTE_URL"
        echo "✓ 远程仓库地址已更新"
    else
        echo "已取消"
        exit 1
    fi
else
    git remote add origin "$REMOTE_URL"
    echo "✓ 远程仓库已添加"
fi

echo ""
echo "远程仓库地址: https://github.com/${USERNAME}/${REPO_NAME}.git"
echo ""

# 首次推送
read -p "是否立即首次推送 main 分支？(y/N): " FIRST_PUSH
if [ "$FIRST_PUSH" = "y" ] || [ "$FIRST_PUSH" = "Y" ]; then
    git add .
    git commit -m "初始提交" 2>/dev/null
    git push -u origin main
    if [ $? -eq 0 ]; then
        echo "✓ 首次推送成功！"
    else
        echo "✗ 推送失败，请检查 Token 权限或仓库是否存在"
    fi
fi

echo ""
echo "=============================="
