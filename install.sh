#!/usr/bin/env bash
# 将执行目录移动到 当前文件所在目录
cd `dirname $0`

if ! command -v nginx >/dev/null 2>&1; then
    sudo yum install -y epel-release
    sudo yum install -y nginx

    ## yum命令出现Loaded plugins: fastestmirror   https://blog.csdn.net/tiweeny/article/details/73333806
    # vi /etc/yum/pluginconf.d/fastestmirror.conf
    # 将 enabled=1 改为 enabled=0
    # vi /etc/yum.conf
    # 将 plugins=1 改为 plugins=0
    # reboot

    ## yum命令出现 No package epel-release available
    # rpm -ivh https://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm

    ## yum安装nginx时报错：No package nginx available.
    # echo -e "[nginx]\nname=nginx repo\nbaseurl=http://nginx.org/packages/centos/\$releasever/\$basearch/\ngpgcheck=0\nenabled=1\n" > /etc/yum.repos.d/nginx.repo

    \cp -f ./conf.d/nginx.conf /etc/nginx/nginx.conf

    ## 旧系统更新 nginx.conf
    # cd /web/env && git pull && \cp -f ./proxy/conf.d/nginx.conf /etc/nginx/nginx.conf && nginx -s reload

    sudo systemctl enable nginx
    sudo systemctl start nginx

    # sudo firewall-cmd --permanent --zone=public --add-service=http
    # sudo firewall-cmd --permanent --zone=public --add-service=https
    # sudo firewall-cmd --permanent --zone=public --add-port=6001
    # sudo firewall-cmd --reload
fi


if ! command -v certbot >/dev/null 2>&1; then
    ## 安装 certbot https://certbot.eff.org/lets-encrypt/centosrhel7-nginx
    sudo yum install -y yum-utils epel-release
    sudo yum-config-manager --enable rhui-REGION-rhel-server-extras rhui-REGION-rhel-server-optional

    sudo yum install -y python2-certbot-nginx

    str_crontab=`sudo cat /etc/crontab`
    str_search="certbot renew"
    result=$(echo $str_crontab | grep "${str_search}")
    if [[ "$result" == "" ]]
    then
        echo "0 0,12 * * * root python -c 'import random; import time; time.sleep(random.random() * 3600)' && certbot renew >> /var/log/certbot.renew.log" | sudo tee -a /etc/crontab > /dev/null
    fi
fi

## 创建 Nginx 配置文件

## 生成证书

EMAIL=lzw122333@gmail.com

COMMON_SERVER_NAME=
COMMON_PROXY_HOST=

H5_SERVER_NAME=
H5_PROXY_HOST=
SOCKET_SERVER_NAME=
SOCKET_PROXY_HOST=
ONLINE_SERVICE_SERVER_NAME=
ONLINE_SERVICE_PROXY_HOST=
ONLINE_SERVICE_PROXY_HOST_2=

API_1_SERVER_NAME=
API_1_PROXY_HOST=
API_2_SERVER_NAME=
API_2_PROXY_HOST=
API_3_SERVER_NAME=
API_3_PROXY_HOST=
API_4_SERVER_NAME=
API_4_PROXY_HOST=
API_5_SERVER_NAME=
API_5_PROXY_HOST=
API_6_SERVER_NAME=
API_6_PROXY_HOST=
API_7_SERVER_NAME=
API_7_PROXY_HOST=
API_8_SERVER_NAME=
API_8_PROXY_HOST=
API_9_SERVER_NAME=
API_9_PROXY_HOST=
API_10_SERVER_NAME=
API_10_PROXY_HOST=

ADMIN_SERVER_NAME=
ADMIN_PROXY_HOST=
AGENT_SERVER_NAME=
AGENT_PROXY_HOST=
RELEASE_SERVER_NAME=
RELEASE_PROXY_HOST=


if [[ -f ./.env ]];then
    source ./.env
fi

if [[ ${COMMON_SERVER_NAME} ]];then
    sh ./install.sub.sh ${COMMON_SERVER_NAME} ${COMMON_PROXY_HOST} '' ./conf.d/common.conf.example
fi
if [[ ${H5_SERVER_NAME} ]];then
    sh ./install.sub.sh ${H5_SERVER_NAME} ${H5_PROXY_HOST} '' ./conf.d/common.conf.example
fi
if [[ ${SOCKET_SERVER_NAME} ]];then
    sh ./install.sub.sh ${SOCKET_SERVER_NAME} ${SOCKET_PROXY_HOST} '' ./conf.d/socket.conf.example
fi
if [[ ${ONLINE_SERVICE_SERVER_NAME} ]];then
    sh ./install.sub.sh ${ONLINE_SERVICE_SERVER_NAME} ${ONLINE_SERVICE_PROXY_HOST} ${ONLINE_SERVICE_PROXY_HOST_2} ./conf.d/online-service.conf.example
fi
if [[ ${API_1_SERVER_NAME} ]];then
    sh ./install.sub.sh ${API_1_SERVER_NAME} ${API_1_PROXY_HOST} '' ./conf.d/common.conf.example
fi
if [[ ${API_2_SERVER_NAME} ]];then
    sh ./install.sub.sh ${API_2_SERVER_NAME} ${API_2_PROXY_HOST} '' ./conf.d/common.conf.example
fi
if [[ ${API_3_SERVER_NAME} ]];then
    sh ./install.sub.sh ${API_3_SERVER_NAME} ${API_3_PROXY_HOST} '' ./conf.d/common.conf.example
fi
if [[ ${API_4_SERVER_NAME} ]];then
    sh ./install.sub.sh ${API_4_SERVER_NAME} ${API_4_PROXY_HOST} '' ./conf.d/common.conf.example
fi
if [[ ${API_5_SERVER_NAME} ]];then
    sh ./install.sub.sh ${API_5_SERVER_NAME} ${API_5_PROXY_HOST} '' ./conf.d/common.conf.example
fi
if [[ ${API_6_SERVER_NAME} ]];then
    sh ./install.sub.sh ${API_6_SERVER_NAME} ${API_6_PROXY_HOST} '' ./conf.d/common.conf.example
fi
if [[ ${API_7_SERVER_NAME} ]];then
    sh ./install.sub.sh ${API_7_SERVER_NAME} ${API_7_PROXY_HOST} '' ./conf.d/common.conf.example
fi
if [[ ${API_8_SERVER_NAME} ]];then
    sh ./install.sub.sh ${API_8_SERVER_NAME} ${API_8_PROXY_HOST} '' ./conf.d/common.conf.example
fi
if [[ ${API_9_SERVER_NAME} ]];then
    sh ./install.sub.sh ${API_9_SERVER_NAME} ${API_9_PROXY_HOST} '' ./conf.d/common.conf.example
fi
if [[ ${API_10_SERVER_NAME} ]];then
    sh ./install.sub.sh ${API_10_SERVER_NAME} ${API_10_PROXY_HOST} '' ./conf.d/common.conf.example
fi

if [[ ${ADMIN_SERVER_NAME} ]];then
    sh ./install.sub.sh ${ADMIN_SERVER_NAME} ${ADMIN_PROXY_HOST} '' ./conf.d/common.conf.example
fi

if [[ ${AGENT_SERVER_NAME} ]];then
    sh ./install.sub.sh ${AGENT_SERVER_NAME} ${AGENT_PROXY_HOST} '' ./conf.d/common.conf.example
fi

if [[ ${RELEASE_SERVER_NAME} ]];then
    sh ./install.sub.sh ${RELEASE_SERVER_NAME} ${RELEASE_PROXY_HOST} '' ./conf.d/common.conf.example
fi

## 添加计划任务
# echo "0 0,12 * * * root python -c 'import random; import time; time.sleep(random.random() * 3600)' && certbot renew" | sudo tee -a /etc/crontab > /dev/null
# crontab -e
# 0 0,12 * * * python -c 'import random; import time; time.sleep(random.random() * 3600)' && certbot renew >/dev/null

## 无法转发 (13: Permission denied) while connecting to upstream:[nginx]
setsebool -P httpd_can_network_connect 1