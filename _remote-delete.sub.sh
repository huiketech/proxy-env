#!/usr/bin/env bash
# 将执行目录移动到 当前文件所在目录
cd `dirname $0`

domain_name=${1}

echo ${domain_name}
ping -c1 ${domain_name}

echo '开始删除';
ssh -o StrictHostKeyChecking=no root@${domain_name} "
    rm -rf /etc/nginx/conf.d/${domain_name}.conf
    certbot delete --cert-name ${domain_name}
    nginx -s reload
"