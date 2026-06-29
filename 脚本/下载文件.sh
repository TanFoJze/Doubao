#!/data/data/com.termux/files/usr/bin/bash
# 文件下载脚本
# 用法: bash 下载文件.sh <网址> [保存路径]

if [ $# -lt 1 ]; then
    echo "用法: bash 下载文件.sh <网址> [保存路径]"
    echo "示例: bash 下载文件.sh https://example.com/file.zip ~/下载/"
    exit 1
fi

URL="$1"
SAVE_PATH="${2:-$HOME/storage/downloads}"

mkdir -p "$SAVE_PATH"

echo "=============================="
echo "      文件下载"
echo "=============================="
echo ""
echo "下载地址: $URL"
echo "保存路径: $SAVE_PATH"
echo ""

echo "开始下载..."
curl -L -o "$SAVE_PATH/$(basename "$URL")" "$URL" --progress-bar

if [ $? -eq 0 ]; then
    echo ""
    echo "✓ 下载成功！"
    echo "  文件: $SAVE_PATH/$(basename "$URL")"
    echo "  大小: $(du -h "$SAVE_PATH/$(basename "$URL")" | cut -f1)"
else
    echo ""
    echo "✗ 下载失败"
    exit 1
fi

echo ""
echo "=============================="
