# 裁剪图片 v1.0
#--------------------------------------------------------
# 设置环境变量
PATH=$PATH:/usr/local/bin/:/opt/homebrew/bin:/opt/homebrew/bin
# 开始循环
for f
do
	dir="$(dirname "$f")"
	name="$(basename "$f")"

	cd "$dir"
	# 获取原始图片尺寸
	imageSIZE="$(magick identify -ping -format "%wx%h" "$f")"
	# 输入修改尺寸
	imageRESIZE="$(osascript -e 'display dialog "设置裁剪尺寸:\n 50％-----等比缩小50%\n 宽度-----给定宽度,高度自适应 \n x高度-----给定高度,宽度自适应" default answer "'$imageSIZE'" with title "裁剪图片 by Sengoku v1.0"' -e 'text returned of result' 2>/dev/null)"
	# 开始转换
	magick "$f" -resize "$imageRESIZE"^ -gravity center -extent "$imageRESIZE" "${f%.*}_$imageRESIZE.${f##*.}"
done
# 通知
osascript -e 'display notification "转换完成👍🏻" with title "Imagemagick 转换器" sound name "Glass"'




# \n N％       高度和宽度均按指定的百分比缩放 \n W%xH％    高度和宽度分别按指定的百分比缩放（只需要一个％符号） \n 宽度      给定宽度,高度自动选择以保留宽高比 \n x高度     给定高度,自动选择宽度以保留宽高比 \n 宽x高     给定高度和宽度的最大值,并保留宽高比