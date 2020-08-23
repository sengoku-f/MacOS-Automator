# 裁剪图片 v1.2
# 添加批量操作,添加修改图片尺寸
#--------------------------------------------------------
# 设置环境变量
PATH=$PATH:/usr/local/bin/
# 询问操作
CONFIG="$(osascript -e 'display dialog "图片裁剪" buttons {"批量裁剪", "单独裁剪","批量调整大小"} default button "批量调整大小" with title "裁剪图片 by Sengoku v1.2"')"
# 批量裁剪
if [ "$CONFIG" = "button returned:批量裁剪" ]; then
    # 获取原始图片尺寸
		imageSIZE="$(magick identify -ping -format "%wx%h\n" "$1" | tail -1)"
		# 输入修改尺寸
		imageRESIZE="$(osascript -e 'display dialog "设置裁剪尺寸:\n 50％-----等比缩小50%\n 宽度-----给定宽度,高度自适应 \n x高度-----给定高度,宽度自适应" default answer "'$imageSIZE'" with title "裁剪图片 by Sengoku v1.2"' -e 'text returned of result' 2>/dev/null)"
		# 开始循环
		for f
		do
			dir="$(dirname "$f")"
			name="$(basename "$f")"
			cd "$dir"
			# 开始转换
			magick "$f" -resize "$imageRESIZE"^ -gravity center -extent "$imageRESIZE" "${f%.*}_$imageRESIZE.${f##*.}"
		done
fi
# 单独裁剪
if [ "$CONFIG" = "button returned:单独裁剪" ]; then
		# 开始循环
		for f
		do
			dir="$(dirname "$f")"
			name="$(basename "$f")"

			cd "$dir"
			# 获取原始图片尺寸
			imageSIZE="$(magick identify -ping -format "%wx%h" "$f")"
			# 输入修改尺寸
			imageRESIZE="$(osascript -e 'display dialog "设置裁剪尺寸:\n 50％-----等比缩小50%\n 宽度-----给定宽度,高度自适应 \n x高度-----给定高度,宽度自适应" default answer "'$imageSIZE'" with title "裁剪图片 by Sengoku v1.2"' -e 'text returned of result' 2>/dev/null)"
			# 开始转换
			magick "$f" -resize "$imageRESIZE"^ -gravity center -extent "$imageRESIZE" "${f%.*}_$imageRESIZE.${f##*.}"
		done
fi
# 批量调整大小
if [ "$CONFIG" = "button returned:批量调整大小" ]; then
    # 获取原始图片尺寸
		imageSIZE="$(magick identify -ping -format "%wx%h\n" "$1" | tail -1)"
		# 输入修改尺寸
		imageRESIZE="$(osascript -e 'display dialog "设置裁剪尺寸:\n 50％-----等比缩小50%\n 宽度-----给定宽度,高度自适应 \n x高度-----给定高度,宽度自适应" default answer "'$imageSIZE'" with title "裁剪图片 by Sengoku v1.2"' -e 'text returned of result' 2>/dev/null)"
		# 开始循环
		for f
		do
			dir="$(dirname "$f")"
			name="$(basename "$f")"
			cd "$dir"
			# 开始转换
			magick "$f" -resize "$imageRESIZE" "${f%.*}_$imageRESIZE.${f##*.}"
		done
fi
# 通知
osascript -e 'display notification "转换完成👍🏻" with title "Imagemagick 转换器" sound name "Glass"'
