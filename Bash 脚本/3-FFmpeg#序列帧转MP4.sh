# 序列帧转 MP4 v1.3
# 更新修复奇偶像素&半透明像素
#-----------------------------
# 设置环境变量
PATH=$PATH:/usr/local/bin/:/opt/homebrew/bin

for f in "$@"
do
	dir="$(dirname "$f")"
	name="$(basename "$f")"

	cd "$f"

	# 过滤 png 和 jpg
	# imagelist="$(ls -d "$PWD"/*.png || ls -d "$PWD"/*.jpg)"
	# 图片输出为清单
	# echo "$imagelist" | perl -ne '$_ =~ s/\n$//; print "file '"'"'$_'"'"'\n"' > images.txt

	# 查找 PNG 和 JPG 并列出清单
	find "$PWD" -name "*.png" -o -name "*.jpg" -maxdepth 1 -mindepth 1 | sort | sed "s/^/file '/;s/$/'/" > images.txt

	ffmpeg -r 25 -f concat -safe 0 -i images.txt -c:v libx264 -preset 8 -x264opts crf=23.5:keyint=infinite:min-keyint=1:scenecut=60:partitions=all:direct=auto:me=umh:merange=32:subme=10:trellis=2:rc-lookahead=60:ref=6:bframes=6:b-adapt=2:deblock=1,1:qcomp=0.5:psy-rd=0.3,0:aq-mode=2:aq-strength=0.8 -r 25 -pix_fmt yuv420p -an -filter_complex "color=black,format=rgb24[c];[c][0]scale2ref[c][i];[c][i]overlay=format=auto:shortest=1,setsar=1,pad=ceil(iw/2)*2:ceil(ih/2)*2" -y out.mp4

	#重命名
	mv -f out.mp4 "$f.mp4"

	# 清理
	rm -rf images.txt

done

# 发送通知
osascript -e 'display notification "转换完成👍🏻" with title "FFmpeg 转换器" sound name "Glass"'