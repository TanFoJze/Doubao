#!/data/data/com.termux/files/usr/bin/bash
# 翻译脚本（使用免费 API）
# 用法: bash 翻译.sh <要翻译的内容>

if [ $# -lt 1 ]; then
    echo "用法: bash 翻译.sh <要翻译的内容>"
    echo "示例: bash 翻译.sh Hello World"
    exit 1
fi

TEXT="$*"

echo "=============================="
echo "        翻译工具"
echo "=============================="
echo ""
echo "原文: $TEXT"
echo ""

echo "翻译中..."

# 使用 MyMemory 免费翻译 API
RESULT=$(curl -s "https://api.mymemory.translated.net/get?q=${TEXT}&langpair=en|zh-CN" 2>/dev/null)

if [ $? -eq 0 ] && [ -n "$RESULT" ]; then
    TRANSLATION=$(echo "$RESULT" | grep -o '"translatedText":"[^"]*"' | head -1 | cut -d'"' -f4)
    if [ -n "$TRANSLATION" ]; then
        echo "译文: $TRANSLATION"
    else
        echo "✗ 翻译失败"
    fi
else
    echo "✗ 网络请求失败，请检查网络连接"
fi

echo ""
echo "=============================="
