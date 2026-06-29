#!/bin/bash
# 天气查询脚本
# 用法: ./weather.sh [城市名]

CITY="${1:-北京}"

echo "=============================="
echo "   天气查询 - $CITY"
echo "=============================="
echo ""

# 使用 wttr.in 获取天气信息（简化版）
curl -s "wttr.in/$CITY?format=3" 2>/dev/null

if [ $? -ne 0 ]; then
    echo "获取天气信息失败，请检查网络连接"
    exit 1
fi

echo ""
echo "=============================="
