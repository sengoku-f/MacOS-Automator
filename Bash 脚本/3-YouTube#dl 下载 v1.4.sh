versions="YouTube-dl 下载 v1.4 by Sengoku"
# 添加版本号,修改通知
# 添加下载时间显示
# ——————————————
# 设置环境变量
PATH=$PATH:/usr/local/bin/
# 设置变量
url=$1
# 询问是否用代理
	CONFIG="$(osascript -e 'display dialog "是否使用代理下载 \n\n - 回车选择代理 \n - 空格选择直连 \n" buttons {"直连", "代理"} default button "代理" with title "'"$versions"'"')"

if [ "$CONFIG" = "button returned:代理" ]; then
    timeout=`(time youtube-dl --proxy socks5://127.0.0.1:1086 "$url") 2>&1 | awk '/real/ { print $NF }'`
    osascript -e 'display notification "YouTube-dl program" with title "下载完成🎉\t耗时'$timeout'" subtitle "" sound name "Glass"'
else
    timeout=`(time youtube-dl "$url") 2>&1 | awk '/real/ { print $NF }'`
    osascript -e 'display notification "YouTube-dl program" with title "下载完成🎉\t耗时'$timeout'" subtitle "" sound name "Glass"'
fi