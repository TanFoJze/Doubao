#!/data/data/com.termux/files/usr/bin/bash
# 网络信息查看脚本

echo "=============================="
echo "      网络信息"
echo "=============================="
echo ""

echo "【网络接口】"
ip addr show 2>/dev/null | grep "inet " | while read line; do
    IFACE=$(echo "$line" | awk '{print $NF}')
    IP=$(echo "$line" | awk '{print $2}')
    echo "  $IFACE: $IP"
done
echo ""

echo "【公网 IP】"
curl -s ifconfig.me 2>/dev/null && echo ""
echo ""

echo "【DNS 服务器】"
getprop net.dns1 2>/dev/null | while read dns; do
    [ -n "$dns" ] && echo "  DNS: $dns"
done
echo ""

echo "【网络连接测试】"
echo -n "  百度: "
ping -c 1 -W 2 baidu.com 2>/dev/null | grep "time=" | awk '{print $7 "ms"}' || echo "超时"
echo -n "  谷歌: "
ping -c 1 -W 2 google.com 2>/dev/null | grep "time=" | awk '{print $7 "ms"}' || echo "超时"

echo ""
echo "=============================="
