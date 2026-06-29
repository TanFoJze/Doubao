#!/data/data/com.termux/files/usr/bin/bash
# 网站状态检测脚本
# 用法: bash 网站检测.sh <网址>

if [ $# -lt 1 ]; then
    echo "用法: bash 网站检测.sh <网址>"
    echo "示例: bash 网站检测.sh https://www.baidu.com"
    exit 1
fi

URL="$1"

echo "=============================="
echo "   网站状态检测"
echo "=============================="
echo ""
echo "检测网址: $URL"
echo ""

echo -n "状态: "
STATUS=$(curl -s -o /dev/null -w "%{http_code}" --connect-timeout 10 "$URL" 2>/dev/null)

if [ -z "$STATUS" ]; then
    echo "连接失败"
    echo "  可能原因: 网络问题、网址错误、网站宕机"
else
    case "$STATUS" in
        2*)
            echo "正常 ($STATUS)"
            ;;
        3*)
            echo "重定向 ($STATUS)"
            ;;
        4*)
            echo "客户端错误 ($STATUS)"
            ;;
        5*)
            echo "服务器错误 ($STATUS)"
            ;;
        *)
            echo "状态码: $STATUS"
            ;;
    esac
    
    # 显示响应时间
    TIME=$(curl -s -o /dev/null -w "%{time_total}s" --connect-timeout 10 "$URL" 2>/dev/null)
    echo "响应时间: $TIME"
fi

echo ""
echo "=============================="
