#!/usr/bin/env bash
# 将执行目录移动到 当前文件所在目录
cd `dirname $0`

# sudo killall -HUP mDNSResponder && sudo killall mDNSResponderHelper && sudo dscacheutil -flushcache

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
    sh ./remote-install.sub.sh COMMON_SERVER_NAME ${COMMON_SERVER_NAME} COMMON_PROXY_HOST ${COMMON_PROXY_HOST}
fi
if [[ ${H5_SERVER_NAME} ]];then
    sh ./remote-install.sub.sh H5_SERVER_NAME ${H5_SERVER_NAME} H5_PROXY_HOST ${H5_PROXY_HOST}
fi
if [[ ${SOCKET_SERVER_NAME} ]];then
    sh ./remote-install.sub.sh SOCKET_SERVER_NAME ${SOCKET_SERVER_NAME} SOCKET_PROXY_HOST ${SOCKET_PROXY_HOST}
fi
if [[ ${ONLINE_SERVICE_SERVER_NAME} ]];then
    sh ./remote-install.sub.sh ONLINE_SERVICE_SERVER_NAME ${ONLINE_SERVICE_SERVER_NAME} ONLINE_SERVICE_PROXY_HOST ${ONLINE_SERVICE_PROXY_HOST} ONLINE_SERVICE_PROXY_HOST_2 ${ONLINE_SERVICE_PROXY_HOST_2}
fi
if [[ ${API_1_SERVER_NAME} ]];then
    sh ./remote-install.sub.sh API_1_SERVER_NAME ${API_1_SERVER_NAME} API_1_PROXY_HOST ${API_1_PROXY_HOST}
fi
if [[ ${API_2_SERVER_NAME} ]];then
    sh ./remote-install.sub.sh API_2_SERVER_NAME ${API_2_SERVER_NAME} API_2_PROXY_HOST ${API_2_PROXY_HOST}
fi
if [[ ${API_3_SERVER_NAME} ]];then
    sh ./remote-install.sub.sh API_3_SERVER_NAME ${API_3_SERVER_NAME} API_3_PROXY_HOST ${API_3_PROXY_HOST}
fi
if [[ ${API_4_SERVER_NAME} ]];then
    sh ./remote-install.sub.sh API_4_SERVER_NAME ${API_4_SERVER_NAME} API_4_PROXY_HOST ${API_4_PROXY_HOST}
fi
if [[ ${API_5_SERVER_NAME} ]];then
    sh ./remote-install.sub.sh API_5_SERVER_NAME ${API_5_SERVER_NAME} API_5_PROXY_HOST ${API_5_PROXY_HOST}
fi
if [[ ${API_6_SERVER_NAME} ]];then
    sh ./remote-install.sub.sh API_6_SERVER_NAME ${API_6_SERVER_NAME} API_6_PROXY_HOST ${API_6_PROXY_HOST}
fi
if [[ ${API_7_SERVER_NAME} ]];then
    sh ./remote-install.sub.sh API_7_SERVER_NAME ${API_7_SERVER_NAME} API_7_PROXY_HOST ${API_7_PROXY_HOST}
fi
if [[ ${API_8_SERVER_NAME} ]];then
    sh ./remote-install.sub.sh API_8_SERVER_NAME ${API_8_SERVER_NAME} API_8_PROXY_HOST ${API_8_PROXY_HOST}
fi
if [[ ${API_9_SERVER_NAME} ]];then
    sh ./remote-install.sub.sh API_9_SERVER_NAME ${API_9_SERVER_NAME} API_9_PROXY_HOST ${API_9_PROXY_HOST}
fi
if [[ ${API_10_SERVER_NAME} ]];then
    sh ./remote-install.sub.sh API_10_SERVER_NAME ${API_10_SERVER_NAME} API_10_PROXY_HOST ${API_10_PROXY_HOST}
fi

if [[ ${ADMIN_SERVER_NAME} ]];then
    sh ./remote-install.sub.sh ADMIN_SERVER_NAME ${ADMIN_SERVER_NAME} ADMIN_PROXY_HOST ${ADMIN_PROXY_HOST}
fi

if [[ ${AGENT_SERVER_NAME} ]];then
    sh ./remote-install.sub.sh AGENT_SERVER_NAME ${AGENT_SERVER_NAME} AGENT_PROXY_HOST ${AGENT_PROXY_HOST}
fi

if [[ ${RELEASE_SERVER_NAME} ]];then
    sh ./remote-install.sub.sh RELEASE_SERVER_NAME ${RELEASE_SERVER_NAME} RELEASE_PROXY_HOST ${RELEASE_PROXY_HOST}
fi

## 添加计划任务
# crontab -e
# 0 0,12 * * * python -c 'import random; import time; time.sleep(random.random() * 3600)' && certbot renew >/dev/null

## 无法转发 (13: Permission denied) while connecting to upstream:[nginx]
# setsebool -P httpd_can_network_connect 1
