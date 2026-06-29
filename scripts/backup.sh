#!/bin/bash
# 文件备份脚本
# 用法: ./backup.sh <源目录> <备份目录>

if [ $# -ne 2 ]; then
    echo "用法: $0 <源目录> <备份目录>"
    exit 1
fi

SRC_DIR="$1"
BACKUP_DIR="$2"
DATE=$(date "+%Y%m%d_%H%M%S")
BACKUP_FILE="${BACKUP_DIR}/backup_${DATE}.tar.gz"

if [ ! -d "$SRC_DIR" ]; then
    echo "错误：源目录不存在"
    exit 1
fi

mkdir -p "$BACKUP_DIR"
tar -czf "$BACKUP_FILE" -C "$(dirname "$SRC_DIR")" "$(basename "$SRC_DIR")"

if [ $? -eq 0 ]; then
    echo "✓ 备份成功: $BACKUP_FILE"
    echo "  文件大小: $(du -h "$BACKUP_FILE" | cut -f1)"
else
    echo "✗ 备份失败"
    exit 1
fi
