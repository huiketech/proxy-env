#!/usr/bin/env bash
# 将执行目录移动到 当前文件所在目录
cd `dirname $0`

## 生成证书

EMAIL=lzw122333@gmail.com

SERVER_NAME=${1}
PROXY_HOST=${2}
PROXY_HOST_2=${3}
CONF_EXAMPLE=${4}

if [[ ${SERVER_NAME} ]]
then
    \cp -f ${CONF_EXAMPLE} /etc/nginx/conf.d/${SERVER_NAME}.conf

    sed -i s~SERVER_NAME~"${SERVER_NAME}"~g /etc/nginx/conf.d/${SERVER_NAME}.conf
    sed -i s~PROXY_HOST~"${PROXY_HOST}"~g /etc/nginx/conf.d/${SERVER_NAME}.conf
    if [[ ${PROXY_HOST_2} ]];then
        sed -i s~PROXY_HOST_2~"${PROXY_HOST_2}"~g /etc/nginx/conf.d/${SERVER_NAME}.conf
    fi
    sudo certbot --nginx -d ${SERVER_NAME} --agree-tos --email "$EMAIL" -n --redirect
fi