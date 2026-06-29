#!/data/data/com.termux/files/usr/bin/bash
# 天气查询脚本
# 用法: bash 天气查询.sh [城市名]

CITY="${1:-北京}"

echo "=============================="
echo "   天气查询 - $CITY"
echo "=============================="
echo ""

curl -s "wttr.in/$CITY?lang=zh&format=%l:+%c+%t+%w+%h" 2>/dev/null

if [ $? -ne 0 ]; then
    echo "获取天气信息失败，请检查网络连接"
    exit 1
fi

echo ""
echo ""
echo "详细天气:"
curl -s "wttr.in/$CITY?lang=zh&0" 2>/dev/null

echo ""
echo "=============================="
