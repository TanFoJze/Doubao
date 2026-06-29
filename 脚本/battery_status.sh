#!/data/data/com.termux/files/usr/bin/bash
# 电池状态查看脚本（需要 Termux API）

echo "=============================="
echo "      电池状态"
echo "=============================="
echo ""

if command -v termux-battery-status &> /dev/null; then
    termux-battery-status
else
    echo "提示: 需要安装 Termux API 才能查看详细电池信息"
    echo "安装命令: pkg install termux-api"
    echo ""
    
    # 尝试从系统文件读取
    if [ -f /sys/class/power_supply/battery/capacity ]; then
        echo "电量: $(cat /sys/class/power_supply/battery/capacity)%"
    fi
    if [ -f /sys/class/power_supply/battery/status ]; then
        echo "状态: $(cat /sys/class/power_supply/battery/status)"
    fi
fi

echo ""
echo "=============================="
