# Script by Sengoku
# 图片拼图 v1.2
# ——————————————
# 设置环境变量
PATH=$PATH:/usr/local/bin/
# 设置变量
ARG="$1"
# 获取日期
ddate=`date +%Y-%m-%d-%H%M%S`
# 设置输出路径
ooutput="${ARG%/*}/concact-$ddate.png"
# 用户选择
CONFIG="$(osascript -e 'display dialog "选择拼图方向" buttons {"水平拼图", "垂直拼图"} default button "垂直拼图" with title "图片拼图 v1.2 by Sengoku"')"
# 手动输入压制参数，并保存作为下一次的值
	if [ "$CONFIG" = "button returned:垂直拼图" ]; then
			magick "$@" -background none -append "$ooutput" && osascript -e 'display notification "拼接完成👍🏻" with title "Imagemagick 转换器" sound name "Glass"'
		elif [ "$CONFIG" = "button returned:水平拼图" ]; then
			magick "$@" -background none +append "$ooutput" && osascript -e 'display notification "拼接完成👍🏻" with title "Imagemagick 转换器" sound name "Glass"'
		fi
