#!/usr/bin/env bash

# 将执行目录移动到 当前文件所在目录
cd `dirname $0`

domain_name_array=(
'api.3.baitongjinfu.com'
)

host_ip=18.163.17.193

for domain_name in "${domain_name_array[@]}"
do
    echo '====start====';
    echo ${domain_name};
    # 返回 1 表示不存在
    php remote-delete.php ${domain_name} ${host_ip}
    OP_MODE=$?
    echo ${OP_MODE}
    if [[ ${OP_MODE} == '1' ]];then
        echo '开始删除';
        echo ${domain_name};
        ssh root@${host_ip} "
            rm -rf /etc/nginx/conf.d/${domain_name}.conf
            certbot delete --cert-name ${domain_name}
        "
    fi
    echo '====end====';
    echo '';
done
