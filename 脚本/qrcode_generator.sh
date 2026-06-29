#!/data/data/com.termux/files/usr/bin/bash
# 二维码生成脚本
# 用法: bash 二维码生成.sh <内容> [输出文件名]

if [ $# -lt 1 ]; then
    echo "用法: bash 二维码生成.sh <内容> [输出文件名]"
    echo "示例: bash 二维码生成.sh https://www.baidu.com 二维码.png"
    exit 1
fi

CONTENT="$1"
OUTPUT="${2:-qrcode.png}"

echo "=============================="
echo "     二维码生成器"
echo "=============================="
echo ""

# 检查是否有 qrencode
if command -v qrencode &> /dev/null; then
    qrencode -o "$OUTPUT" -s 8 "$CONTENT"
    echo "✓ 二维码已生成: $OUTPUT"
    echo "  大小: $(du -h "$OUTPUT" | cut -f1)"
else
    echo "提示: 未安装 qrencode，使用在线 API 生成"
    echo ""
    
    # 使用在线 API 生成
    URL_ENCODED=$(echo "$CONTENT" | sed 's/ /%20/g')
    curl -s -o "$OUTPUT" "https://api.qrserver.com/v1/create-qr-code/?size=200x200&data=$URL_ENCODED"
    
    if [ $? -eq 0 ] && [ -f "$OUTPUT" ]; then
        echo "✓ 二维码已生成: $OUTPUT"
        echo "  大小: $(du -h "$OUTPUT" | cut -f1)"
    else
        echo "✗ 生成失败，请检查网络连接"
        exit 1
    fi
fi

echo ""
echo "安装 qrencode 可离线生成: pkg install qrencode"
echo "=============================="
