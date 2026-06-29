#!/data/data/com.termux/files/usr/bin/bash
# 系统信息查看脚本

echo "=============================="
echo "      系统信息报告"
echo "=============================="
echo ""

echo "【设备信息】"
echo "  主机名: $(hostname)"
echo "  系统: $(uname -s)"
echo "  内核: $(uname -r)"
echo "  架构: $(uname -m)"
echo ""

echo "【CPU 信息】"
echo "  核心数: $(nproc)"
if [ -f /proc/cpuinfo ]; then
    echo "  型号: $(grep "model name" /proc/cpuinfo | head -1 | cut -d: -f2 | sed 's/^ //')"
fi
echo ""

echo "【内存信息】"
free -h 2>/dev/null | grep Mem | awk '{print "  总计: " $2 " | 已用: " $3 " | 空闲: " $4}'
echo ""

echo "【存储信息】"
df -h /data 2>/dev/null | tail -1 | awk '{print "  /data 总计: " $2 " | 已用: " $3 " | 可用: " $4 " | 使用率: " $5}'
df -h / 2>/dev/null | tail -1 | awk '{print "  /     总计: " $2 " | 已用: " $3 " | 可用: " $4 " | 使用率: " $5}'
echo ""

echo "【运行时间】"
uptime -p 2>/dev/null || uptime
echo ""

echo "=============================="
