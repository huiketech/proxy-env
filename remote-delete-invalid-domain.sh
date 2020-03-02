#!/usr/bin/env bash

# 将执行目录移动到 当前文件所在目录
cd `dirname $0`

domain_name_array=(
'api.2.2.sibeike.org'
'api.2.2.thespek.net'
'api.2.ant-w.net'
'api.2.beilina.net'
'api.2.daosy.net'
'api.2.kelide.org'
'api.2.qlzhuan.net'
'api.2.qlzhuan.shuagroup.net'
'api.2.sbeike2.net'
'api.2.sibeike.org'
'api.2.taoduoduo.org'
'api.2.taojiduo.net'
'api.2.thebeiyang.com'
'api.2.theebao.net'
'api.2.theetao.net'
'api.2.thegyapp.net'
'api.2.thespek.net'
'api.2.thexmf.net'
'api.2.ttgou.org'
'api.2.xyct.net'
'api.2.yqdan.net'
'api.2.yzhuan.org'
'api.2.yzhuan.shuagroup.net'
'api.2.zrbang.net'
'online-service.taoyj188.com'
)

host_ip=18.162.107.225

for domain_name in "${domain_name_array[@]}"
do
    echo '====start====';
    echo ${domain_name};
    # 返回 1 表示不存在
    php ./_remote-delete-check-domain.php ${domain_name} ${host_ip}
    OP_MODE=$?
    echo ${OP_MODE}
    if [[ ${OP_MODE} == '1' ]];then
        echo '开始删除';
        echo ${domain_name};
        ssh root@${host_ip} "
            rm -rf /etc/nginx/conf.d/${domain_name}.conf
            certbot delete --cert-name ${domain_name}
            nginx -s reload
        "
    fi
    echo '====end====';
    echo '';
done
