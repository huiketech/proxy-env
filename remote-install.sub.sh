#!/usr/bin/env bash
# 将执行目录移动到 当前文件所在目录
cd `dirname $0`

SERVER_NAME_KEY=${1}
SERVER_NAME_VALUE=${2}
PROXY_HOST_KEY=${3}
PROXY_HOST_VALUE=${4}

ssh -o StrictHostKeyChecking=no root@${SERVER_NAME_VALUE} "
if [[ ! -d \"/hk/proxy-env\" ]]; then
  mkdir -p /hk/proxy-env
  cd /hk/proxy-env
  git clone git@github.com:huiketech/proxy-env.git .
fi
cd /hk/proxy-env && git pull
echo \"${SERVER_NAME_KEY}=${SERVER_NAME_VALUE}\" > /hk/proxy-env/.env
echo \"${PROXY_HOST_KEY}=${PROXY_HOST_VALUE}\" >> /hk/proxy-env/.env
sh /hk/proxy-env/install.sh
"
