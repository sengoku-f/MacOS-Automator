#  视频转为 GIF 自定义 v1.3
# -----------------------------------
# 设置环境变量
PATH=$PATH:/usr/local/bin/:/opt/homebrew/bin
# 设置变量
	gifV="GIF压制工具_by_Sengoku_v1.3"
	gifFPS="$(osascript -e 'display dialog "GIF帧数（数字越低越卡顿，GIF体积越小）:" default answer "25" with title "'$gifV'"' -e 'text returned of result' 2>/dev/null | awk '{printf "%.5f", 1/$1 * 100}')"

	#gifEND="$(osascript -e 'display dialog "GIF结束时间 \n\n - 例如:0:23, 1:01 \n - 设为 0:00 为全部 \n" default answer "0:00" with title "'$gifV'"' -e 'text returned of result' 2>/dev/null)"

	gifSIZE="$(osascript -e 'display dialog "GIF大小设置" default answer "480" with title "'$gifV'"' -e 'text returned of result' 2>/dev/null)"

	gifLOSSY="$(osascript -e 'display dialog "GIF质量 (0-100 数字越小,质量越低)" default answer "80" with title "'$gifV'"' -e 'text returned of result' 2>/dev/null)"

for f
do
	dir="$(dirname "$f")"
	name="$(basename "$f")"

	cd "$dir"

	mkdir .temp

	ffmpeg -i "$f" -vf "scale=iw*min(1\,min($gifSIZE/iw\,$gifSIZE/ih)):-1:flags=lanczos" ".temp/%08d.png"

	convert +repage -fuzz 1.6% -delay "$gifFPS" -loop 0 .temp/*.png -layers OptimizePlus -layers OptimizeTransparency .temp.gif

	gifsicle -O3 --lossy="$gifLOSSY" --colors 256 .temp.gif > "${name%.*}.gif"
	
	# 清理
	rm -rf .temp
	rm -rf .temp.gif

done

# 通知
osascript -e 'display notification "FFmpeg Imagemagick converter" with title "转换完成🎉" sound name "Glass"'