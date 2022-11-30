# 图片缩小 50% v1.2
# 更新为 parallel 并行处理
# -----------------------------
# 设置环境变量
PATH=$PATH:/usr/local/bin/:/opt/homebrew/bin
# 设置路径变量
var="$1"
# 获取文件信息
dir="$(dirname "$var")"
name="$(basename "$var")"
# 定位目录路径
cd "$dir"

#echo "$PWD"
# 开始转换
find "$@" -maxdepth 0 | parallel --max-args 1 --load 90% --plus magick {} -resize 50% "{.}.{+.}"
 

osascript -e 'display notification "Imagemagick converter" with title "转换完成🎉" sound name "Glass"'