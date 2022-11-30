#!/bin/bash
# 若命令失败让脚本退出 
set -o errexit
# 若未设置的变量被使用让脚本退出 
set -o nounset
echo "Names without double quotes"
echo names="Tecmint FOSSMint Linusay"
for name in $names;
do
    echo "$name"
done

echo echo "Names with double quotes"
echo
for name in "$names";
do
    echo "$name"
done exit 0

# 设置环境变量
PATH=$PATH:/usr/local/bin/:/opt/homebrew/bin