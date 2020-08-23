# 序列帧上下通道 v1.2
#-----------------------------

# 设置环境变量
PATH=$PATH:/usr/local/bin/

for f in "$@"
do
	# 设置变量
	dir="$(dirname "$f")"
	name="$(basename "$f")"

	cd "$f"
	
	# 列出 PNG 清单
	#ls -d "$PWD"/*.png | perl -ne '$_ =~ s/\n$//; print "file '"'"'$_'"'"'\n"' > images.txt

	find "$PWD" -name "*.png" -o -name "*.jpg" -maxdepth 1 -mindepth 1 | sort | sed "s/^/file '/;s/$/'/" > images.txt

	# 转换 MP4 RGB
	ffmpeg -r 25 -f concat -safe 0 -i images.txt -c:v libx264 -r 25 -pix_fmt yuv420p -an -y output_rgb.mp4

	# 转换 MP4 Alpha
	ffmpeg -r 25 -f concat -safe 0 -i images.txt -r 25 -vf "[in] format=rgba, split [T1], fifo, lutrgb=r=maxval:g=maxval:b=maxval,[T2] overlay [out]; [T1] fifo, lutrgb=r=minval:g=minval:b=minval [T2]" -an -y output_alpha.mp4

	# 合并 MP4
	ffmpeg -i output_rgb.mp4 -i output_alpha.mp4 -filter_complex vstack=inputs=2 -c:v libx264 -preset 8 -x264opts crf=23.5:keyint=infinite:min-keyint=1:scenecut=60:partitions=all:direct=auto:me=umh:merange=32:subme=10:trellis=2:rc-lookahead=60:ref=6:bframes=6:b-adapt=2:deblock=1,1:qcomp=0.5:psy-rd=0.3,0:aq-mode=2:aq-strength=0.8 -an -y out.mp4

	#重命名
	mv -f out.mp4 "$f.mp4"

	# 清理
	rm -rf images.txt
	rm -rf output_rgb.mp4
	rm -rf output_alpha.mp4

done

# 发送通知
osascript -e 'display notification "FFmpeg converter" with title "转换完成🎉" sound name "Glass"'
