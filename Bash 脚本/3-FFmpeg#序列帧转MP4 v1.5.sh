# 序列帧转 MP4 v1.5
# 修复帧速率问题
# 更新 parallel 并行处理
# 更新修复奇偶像素&半透明像素
#-----------------------------
# 设置环境变量
PATH=$PATH:/usr/local/bin/:/opt/homebrew/bin

for f in "$@"
do
	dir="$(dirname "$f")"
	name="$(basename "$f")"

	cd "$f"

	# 查找 PNG 和 JPG 并列出清单
	find "$PWD" -name "*.png" -o -name "*.jpg" -maxdepth 1 -mindepth 1 | sort | sed "s/^/file '/;s/$/'/" > images.txt

done
# 定位目录路径
cd "$dir"

# 设置帧速率
FPS=25
# 开始转换
find "$PWD" -type f -name "images.txt" | parallel --max-args 1 --load 90% ffmpeg -r $FPS -f concat -safe 0 -i {} -c:v libx264 -preset 8 -x264opts crf=23.5:keyint=infinite:min-keyint=1:scenecut=60:partitions=all:direct=auto:me=umh:merange=32:subme=10:trellis=2:rc-lookahead=60:ref=6:bframes=6:b-adapt=2:deblock=1,1:qcomp=0.5:psy-rd=0.3,0:aq-mode=2:aq-strength=0.8 -vf "'color=black,format=rgb24,fps=fps=$FPS[c];[c][0]scale2ref[c][i];[c][i]overlay=format=auto:shortest=1,setsar=1,pad=ceil(iw/2)*2:ceil(ih/2)*2'" -pix_fmt yuv420p -an -y "'{//}.mp4'"


# 清理
find "$PWD" -type f -name "images.txt" -print0 | xargs -0 rm -rf

# 发送通知
osascript -e 'display notification "FFmpeg converter" with title "转换完成🎉" sound name "Glass"'