#!/bin/bash
# 系统信息查看脚本

echo "=============================="
echo "      系统信息报告"
echo "=============================="
echo ""

echo "【主机名】"
hostname
echo ""

echo "【操作系统】"
cat /etc/os-release | grep PRETTY_NAME | cut -d'"' -f2
echo ""

echo "【内核版本】"
uname -r
echo ""

echo "【运行时间】"
uptime -p
echo ""

echo "【CPU 信息】"
echo "  型号: $(grep "model name" /proc/cpuinfo | head -1 | cut -d: -f2 | sed 's/^ //')"
echo "  核心数: $(nproc)"
echo ""

echo "【内存使用】"
free -h | grep Mem | awk '{print "  总计: " $2 " | 已用: " $3 " | 空闲: " $4}'
echo ""

echo "【磁盘使用】"
df -h / | tail -1 | awk '{print "  总计: " $2 " | 已用: " $3 " | 可用: " $4 " | 使用率: " $5}'
echo ""

echo "【网络信息】"
ip addr show | grep "inet " | grep -v 127.0.0.1 | awk '{print "  IP: " $2}'
echo ""

echo "=============================="
