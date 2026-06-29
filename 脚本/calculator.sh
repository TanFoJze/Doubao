#!/data/data/com.termux/files/usr/bin/bash
# 简单计算器脚本

echo "=============================="
echo "      简单计算器"
echo "=============================="
echo ""
echo "支持运算: + - * / % ^"
echo "输入 q 退出"
echo ""

while true; do
    read -p "请输入算式: " EXPR
    
    if [ "$EXPR" = "q" ] || [ "$EXPR" = "Q" ]; then
        break
    fi
    
    if [ -z "$EXPR" ]; then
        continue
    fi
    
    # 替换 ^ 为 ** 用于幂运算
    EXPR=$(echo "$EXPR" | sed 's/\^/**/g')
    
    RESULT=$(echo "scale=4; $EXPR" | bc 2>/dev/null)
    
    if [ $? -eq 0 ]; then
        echo "  = $RESULT"
    else
        echo "  ✗ 算式错误，请重新输入"
    fi
    echo ""
done

echo ""
echo "再见！"
echo "=============================="
