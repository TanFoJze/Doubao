#!/data/data/com.termux/files/usr/bin/bash
# 批量压缩脚本 - 将目录下每个文件单独压缩
# 用法: bash 批量压缩.sh <目录> [格式: zip/gz]

if [ $# -lt 1 ]; then
    echo "用法: bash 批量压缩.sh <目录> [格式: zip/gz]"
    echo "示例: bash 批量压缩.sh ./文档 zip"
    exit 1
fi

DIR="$1"
FORMAT="${2:-gz}"
COUNT=0

if [ ! -d "$DIR" ]; then
    echo "✗ 错误：目录不存在"
    exit 1
fi

cd "$DIR" || exit 1

echo "开始批量压缩（格式: $FORMAT）..."
for file in *; do
    if [ -f "$file" ]; then
        case "$FORMAT" in
            zip)
                zip -q "${file}.zip" "$file"
                ;;
            gz)
                gzip -k "$file"
                ;;
            *)
                echo "✗ 不支持的格式: $FORMAT"
                exit 1
                ;;
        esac
        echo "  ✓ $file"
        COUNT=$((COUNT + 1))
    fi
done

echo ""
echo "✓ 完成！共压缩 $COUNT 个文件"
