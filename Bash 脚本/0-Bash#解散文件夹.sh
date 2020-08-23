version="解散文件夹 v1.1 by Sengoku"
# 更新同名文件夹模式
# -------------------------------------------
# 设置环境变量
PATH=$PATH:/usr/local/bin/
for f in "$@"
do
	# 父文件夹
	dir="$(dirname "$f")"
	name="$(basename "$f")"

	cd "$dir"

	# 子文件夹
	# subfile="$(find "$f" -maxdepth 1 -mindepth 1 -name "$name")"
	subdir="$(dirname $(find "$f" -maxdepth 1 -mindepth 1 -name "$name"))"
	subname="$(basename $(find "$f" -maxdepth 1 -mindepth 1 -name "$name"))"
	# 判断文件名
	if [ "$subname" = "$name" ]; then
			# 定位到子目录
			cd "$subdir"
			# 重命名
			mv -n "$subname" "$subname"_bak
			# 定位到根目录
			cd "$dir"
			# 删除".DS_Store"文件
			find "$f" -name ".DS_Store" -delete
			# 移动所有文件到根目录
			find "$f" -maxdepth 1 -mindepth 1 -not -path "*/\.*" -print0 | xargs -0 -P 8 -J {} mv -n {} "."
			# 如果父文件夹为空则删除
			find "$name" -depth -maxdepth 0 -type d -empty -exec rmdir {} \;
			# 重命名原始文件名
			mv -n "$subname"_bak "$subname"
		elif [ -z "$subname" ]; then
			cd "$dir"
			# 删除".DS_Store"文件
			find "$f" -name ".DS_Store" -delete
			# 移动所有文件到根目录
			find "$f" -maxdepth 1 -mindepth 1 -not -path "*/\.*" -print0 | xargs -0 -P 8 -J {} mv -n {} "."
	fi

done

# 删除根目录下所有空文件夹
find "$dir" -depth -maxdepth 1 -mindepth 1 -type d -empty -exec rmdir {} \;
# 通知
osascript -e 'display notification "'"$version"'" with title "所有文件已移动🎉" sound name "Glass"'