#!/data/data/com.termux/files/usr/bin/bash
# 随机密码生成脚本
# 用法: bash 生成密码.sh [长度] [数量]

LENGTH="${1:-16}"
COUNT="${2:-1}"

echo "=============================="
echo "    随机密码生成器"
echo "=============================="
echo ""
echo "密码长度: $LENGTH 位"
echo "生成数量: $COUNT 个"
echo ""

echo "生成的密码:"
for i in $(seq 1 $COUNT); do
    PASSWORD=$(cat /dev/urandom | tr -dc 'a-zA-Z0-9!@#$%^&*' | head -c $LENGTH)
    echo "  $i. $PASSWORD"
done

echo ""
echo "=============================="
