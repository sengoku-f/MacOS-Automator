# 序列帧上下通道 v1.5
# parallel多线程
#-----------------------------

# 设置环境变量
PATH=$PATH:/usr/local/bin/

for f in "$@"
do
	# 设置变量
	dir="$(dirname "$f")"
	name="$(basename "$f")"

	cd "$f"
	
	# 查找 PNG 列出清单
	#ls -d "$PWD"/*.png | perl -ne '$_ =~ s/\n$//; print "file '"'"'$_'"'"'\n"' > images.txt

	find "$PWD" -name "*.png" -maxdepth 1 -mindepth 1 | sort | sed "s/^/file '/;s/$/'/" > images.txt

done
# 定位目录路径
cd "$dir"
# 设置日志
#LOG="$dir/log"
# 设置帧速率
#FPS=25
# 开始转换
# 转换 MP4 RGB
find "$PWD" -type f -name "images.txt" | parallel --max-args 1 --load 90% ffmpeg -r 25 -f concat -safe 0 -i {} -c:v libx264 -pix_fmt yuv420p -an -y "'{//}/output_rgb.mp4'"

# 转换 MP4 Alpha
find "$PWD" -type f -name "images.txt" | parallel --max-args 1 --load 90% ffmpeg -r 25 -f concat -safe 0 -i {} -vf "'[in] format=rgba, split [T1], fifo, lutrgb=r=maxval:g=maxval:b=maxval,[T2] overlay [out]; [T1] fifo, lutrgb=r=minval:g=minval:b=minval [T2]'" -an -y "'{//}/output_alpha.mp4'"

# 合并 MP4
find "$PWD" -type f -name "*_rgb.mp4" | parallel --max-args 1 --load 90% ffmpeg -i "'{//}/output_rgb.mp4'" -i "'{//}/output_alpha.mp4'" -filter_complex vstack=inputs=2 -c:v libx264 -preset 8 -x264opts crf=23.5:keyint=infinite:min-keyint=1:scenecut=60:partitions=all:direct=auto:me=umh:merange=32:subme=10:trellis=2:rc-lookahead=60:ref=6:bframes=6:b-adapt=2:deblock=1,1:qcomp=0.5:psy-rd=0.3,0:aq-mode=2:aq-strength=0.8 -an -y "'{//}.mp4'"

# 清理
find "$PWD" -type f -name "images.txt" -print0 | xargs -0 rm -rf
find "$PWD" -type f -name "*_rgb.mp4" -print0 | xargs -0 rm -rf
find "$PWD" -type f -name "*_alpha.mp4" -print0 | xargs -0 rm -rf

# 发送通知
osascript -e 'display notification "FFmpeg converter" with title "转换完成🎉" sound name "Glass"'