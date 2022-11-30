#!/bin/bash
# 批量图片去黑 v1.0 by sengoku
#--------------------------------------------------------
# 设置环境变量
PATH=$PATH:/usr/local/bin/:/opt/homebrew/bin
# 开始循环
for f in $(ls *.jpg)
do
	dir="$(dirname "$f")"
	name="$(basename "$f")"

	cd "$dir"
	# 开始转换
	color2alpha -ca black "$f" "${f%.*}_un.png"
done