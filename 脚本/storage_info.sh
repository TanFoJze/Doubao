#!/data/data/com.termux/files/usr/bin/bash
# 存储信息查看脚本

echo "=============================="
echo "      存储使用情况"
echo "=============================="
echo ""

echo "【内部存储】"
df -h /data 2>/dev/null | tail -1 | awk '{
    printf "  总容量: %s\n", $2
    printf "  已使用: %s\n", $3
    printf "  可用:   %s\n", $4
    printf "  使用率: %s\n", $5
}'
echo ""

echo "【Termux 主目录】"
if [ -d "$HOME" ]; then
    du -sh "$HOME" 2>/dev/null | awk '{print "  大小: " $1}'
fi
echo ""

echo "【主要目录大小】"
for dir in "$HOME/storage/shared" "$HOME/storage/downloads" "$HOME/storage/dcim" "$HOME/storage/pictures"; do
    if [ -d "$dir" ]; then
        SIZE=$(du -sh "$dir" 2>/dev/null | cut -f1)
        echo "  $(basename "$dir"): $SIZE"
    fi
done

echo ""
echo "=============================="
