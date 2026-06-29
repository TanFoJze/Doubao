#!/data/data/com.termux/files/usr/bin/bash
# IP地址查询脚本

echo "=============================="
echo "      IP 地址查询"
echo "=============================="
echo ""

echo "【本机 IP】"
ip addr show 2>/dev/null | grep "inet " | grep -v 127.0.0.1 | while read line; do
    IFACE=$(echo "$line" | awk '{print $NF}')
    IP=$(echo "$line" | awk '{print $2}')
    echo "  $IFACE: $IP"
done
echo ""

echo "【公网 IP】"
PUB_IP=$(curl -s ifconfig.me 2>/dev/null)
if [ -n "$PUB_IP" ]; then
    echo "  $PUB_IP"
    echo ""
    
    echo "【IP 归属地】"
    curl -s "ipinfo.io/$PUB_IP" 2>/dev/null | grep -E "city|region|country|org" | head -4 | sed 's/^/  /'
else
    echo "  获取失败，请检查网络"
fi

echo ""
echo "=============================="
