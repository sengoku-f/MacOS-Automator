#!/bin/bash
# 若命令失败让脚本退出 
set -o errexit

# 设置代理
# export https_proxy=http://127.0.0.1:1080 http_proxy=http://127.0.0.1:1080 all_proxy=socks5://127.0.0.1:1080

cd '/home/clash/'

# 设置源路径
mycentos_config="mycentos.black"
# 设置下载链接
mycentos_url="http://127.0.0.1:25500/getprofile?name=profiles/mycentos.ini&token=RXR0gc1c"

# 开始下载 -Ss 静默下载只显示错误信息
curl -Ss "$mycentos_url" -o "$mycentos_config"

# 判断下载的配置是否正确
file_size=`du -s "$mycentos_config" | awk '{print $1}'`
# 如果 file_size 小于 50 
if [ $file_size -gt 50 ]; then
    # 重命名
    mv "$mycentos_config" "mycentos.yaml"
    # clash api 重载配置
    curl -i -X PUT -H "Content-Type:application/json" -H "Authorization:Bearer clash.donxj.com" -d '{"path":"/home/clash/mycentos.yaml"}' http://127.0.0.1:9090/configs
  else
    echo "配置下载错误:" `cat "$mycentos_config"`
    # 删除
    rm -f "$mycentos_config"
fi


exit 0