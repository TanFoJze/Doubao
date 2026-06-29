#!/data/data/com.termux/files/usr/bin/bash
# 待办清单脚本
# 用法: bash 待办清单.sh [add/list/done/clear] [内容]

TODO_FILE="$HOME/.todo_list"
touch "$TODO_FILE"

echo "=============================="
echo "      待办清单"
echo "=============================="
echo ""

case "${1:-list}" in
    add)
        shift
        if [ -z "$*" ]; then
            echo "用法: bash 待办清单.sh add <内容>"
            exit 1
        fi
        echo "[ ] $*" >> "$TODO_FILE"
        echo "✓ 已添加: $*"
        ;;
    
    list)
        echo "待办事项:"
        echo ""
        if [ -s "$TODO_FILE" ]; then
            cat -n "$TODO_FILE" | sed 's/^/  /'
        else
            echo "  暂无待办事项"
        fi
        ;;
    
    done)
        shift
        if [ -z "$1" ]; then
            echo "用法: bash 待办清单.sh done <序号>"
            exit 1
        fi
        LINE_NUM="$1"
        sed -i "${LINE_NUM}s/\[ \]/[✓]/" "$TODO_FILE"
        echo "✓ 已标记第 $LINE_NUM 项为完成"
        ;;
    
    clear)
        > "$TODO_FILE"
        echo "✓ 已清空所有待办事项"
        ;;
    
    *)
        echo "用法:"
        echo "  bash 待办清单.sh list          查看清单"
        echo "  bash 待办清单.sh add <内容>    添加事项"
        echo "  bash 待办清单.sh done <序号>   标记完成"
        echo "  bash 待办清单.sh clear         清空清单"
        ;;
esac

echo ""
echo "=============================="
