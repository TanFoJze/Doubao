#!/data/data/com.termux/files/usr/bin/bash
# 清理缓存脚本

echo "=============================="
echo "      缓存清理工具"
echo "=============================="
echo ""

BEFORE=$(df -h /data | tail -1 | awk '{print $4}')
echo "清理前可用空间: $BEFORE"
echo ""

# 清理 apt 缓存
echo "正在清理 apt 缓存..."
apt clean 2>/dev/null
echo "  ✓ apt 缓存已清理"

# 清理临时文件
echo "正在清理临时文件..."
rm -rf /tmp/* 2>/dev/null
echo "  ✓ 临时文件已清理"

# 清理下载目录（可选）
read -p "是否清理下载目录？(y/N): " CLEAR_DOWNLOAD
if [ "$CLEAR_DOWNLOAD" = "y" ] || [ "$CLEAR_DOWNLOAD" = "Y" ]; then
    rm -rf ~/下载/* 2>/dev/null
    rm -rf ~/storage/downloads/* 2>/dev/null
    echo "  ✓ 下载目录已清理"
fi

AFTER=$(df -h /data | tail -1 | awk '{print $4}')
echo ""
echo "清理后可用空间: $AFTER"
echo ""
echo "✓ 清理完成！"
echo "=============================="
