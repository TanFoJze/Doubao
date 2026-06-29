#!/data/data/com.termux/files/usr/bin/bash
# 批量解压脚本
# 用法: bash 批量解压.sh <目录>

if [ $# -lt 1 ]; then
    echo "用法: bash 批量解压.sh <目录>"
    echo "支持格式: zip, tar.gz, gz, tar.bz2"
    exit 1
fi

DIR="$1"
COUNT=0

if [ ! -d "$DIR" ]; then
    echo "✗ 错误：目录不存在"
    exit 1
fi

cd "$DIR" || exit 1

echo "开始批量解压..."
for file in *; do
    if [ -f "$file" ]; then
        case "$file" in
            *.zip)
                unzip -q "$file" && echo "  ✓ $file" && COUNT=$((COUNT + 1))
                ;;
            *.tar.gz|*.tgz)
                tar -xzf "$file" && echo "  ✓ $file" && COUNT=$((COUNT + 1))
                ;;
            *.gz)
                gunzip -k "$file" && echo "  ✓ $file" && COUNT=$((COUNT + 1))
                ;;
            *.tar.bz2)
                tar -xjf "$file" && echo "  ✓ $file" && COUNT=$((COUNT + 1))
                ;;
        esac
    fi
done

echo ""
echo "✓ 完成！共解压 $COUNT 个文件"
