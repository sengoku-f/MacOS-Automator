#!/bin/bash
# 测试脚本
#--------------------------------------------------------
# 设置环境变量
PATH=$PATH:/usr/local/bin/:/opt/homebrew/bin
# 开始循环
for f in *.jpg *.png;
do
	dir="$(dirname "$f")"
	name="$(basename "$f")"

	cd "$dir"
	# 开始转换
	echo "$f"
done