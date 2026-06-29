#!/data/data/com.termux/files/usr/bin/bash
# 倒计时脚本
# 用法: bash 倒计时.sh [秒数]

SECONDS="${1:-60}"

echo "=============================="
echo "      倒计时"
echo "=============================="
echo ""

for ((i=SECONDS; i>=0; i--)); do
    printf "\r  剩余时间: %02d:%02d " $((i/60)) $((i%60))
    sleep 1
done

echo ""
echo ""
echo "✓ 时间到！"

# 播放提示音（如果有 termux-media-player 或 termux-vibrate）
if command -v termux-vibrate &> /dev/null; then
    termux-vibrate -d 1000 2>/dev/null
fi

echo ""
echo "=============================="
