#!/data/data/com.termux/files/usr/bin/bash
# 批量重命名脚本
# 用法: bash 批量重命名.sh <目录> <前缀> <扩展名>

if [ $# -ne 3 ]; then
    echo "用法: bash 批量重命名.sh <目录> <前缀> <扩展名>"
    echo "示例: bash 批量重命名.sh ./图片 照片 jpg"
    exit 1
fi

DIR="$1"
PREFIX="$2"
EXT="$3"
COUNT=1

if [ ! -d "$DIR" ]; then
    echo "✗ 错误：目录不存在"
    exit 1
fi

cd "$DIR" || exit 1

echo "开始批量重命名..."
for file in *."$EXT"; do
    if [ -f "$file" ]; then
        NEW_NAME="${PREFIX}_$(printf "%03d" $COUNT).${EXT}"
        mv "$file" "$NEW_NAME"
        echo "  $file → $NEW_NAME"
        COUNT=$((COUNT + 1))
    fi
done

echo ""
echo "✓ 完成！共重命名 $((COUNT - 1)) 个文件"
