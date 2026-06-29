#!/data/data/com.termux/files/usr/bin/bash
# 文件备份脚本
# 用法: bash 文件备份.sh <源目录> [备份目录]

if [ $# -lt 1 ]; then
    echo "用法: bash 文件备份.sh <源目录> [备份目录]"
    echo "示例: bash 文件备份.sh ~/下载 ~/备份"
    exit 1
fi

SRC_DIR="$1"
BACKUP_DIR="${2:-$HOME/备份}"
DATE=$(date "+%Y%m%d_%H%M%S")
BACKUP_FILE="${BACKUP_DIR}/备份_${DATE}.tar.gz"

if [ ! -d "$SRC_DIR" ]; then
    echo "✗ 错误：源目录不存在"
    exit 1
fi

mkdir -p "$BACKUP_DIR"
echo "正在备份..."
tar -czf "$BACKUP_FILE" -C "$(dirname "$SRC_DIR")" "$(basename "$SRC_DIR")" 2>/dev/null

if [ $? -eq 0 ]; then
    echo "✓ 备份成功！"
    echo "  文件: $BACKUP_FILE"
    echo "  大小: $(du -h "$BACKUP_FILE" | cut -f1)"
else
    echo "✗ 备份失败"
    exit 1
fi
