#!/data/data/com.termux/files/usr/bin/bash
# 查找大文件脚本
# 用法: bash 查找大文件.sh [目录] [大小限制MB]

DIR="${1:-$HOME}"
SIZE="${2:-10}"

echo "=============================="
echo "  查找大于 ${SIZE}MB 的文件"
echo "  目录: $DIR"
echo "=============================="
echo ""

find "$DIR" -type f -size +${SIZE}M -exec du -h {} \; 2>/dev/null | sort -rh | head -20

echo ""
echo "=============================="
