#!/usr/bin/env bash
# 将执行目录移动到 当前文件所在目录
cd `dirname $0`

PROJECT_HOST=
PROJECT_ROOT_DIR=
PROJECT_NAME=

if [[ -f ./.env ]];then
    source ./.env
fi

scp ./.env root@${PROJECT_HOST}:/hk/proxy-env/.env

ssh -o StrictHostKeyChecking=no root@${PROJECT_HOST} "
cd /hk/proxy-env && git pull
sh /hk/proxy-env/update-env.sh
"
