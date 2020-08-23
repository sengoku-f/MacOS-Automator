#!/bin/bash
# 若命令失败让脚本退出 
set -o errexit

# 设置源路径
sourcepath=~/Library/Services/
# 设置目标路径
destpath=~/Git/MacOS-Automator/服务

# 同步"Services"文件夹内容到"服务",排除 '_gsdata_' 'QuickLook'
rsync -cavu --delete --delete-excluded --exclude '_gsdata_' --exclude 'QuickLook' "$sourcepath" "$destpath"

exit 0