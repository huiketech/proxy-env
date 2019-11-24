#!/usr/bin/env bash
# 将执行目录移动到 当前文件所在目录
cd `dirname $0`

SERVER_NAME_KEY=${1}
SERVER_NAME_VALUE=${2}
PROXY_HOST_KEY=${3}
PROXY_HOST_VALUE=${4}
PROXY_HOST_KEY_2=${5}
PROXY_HOST_VALUE_2=${6}

echo ${SERVER_NAME_VALUE}
ssh -o StrictHostKeyChecking=no root@${SERVER_NAME_VALUE} "
if [[ ! -d \"/hk/proxy-env\" ]]; then
    ## 安装 git
    version=2.22.0

    if [[ \`git version\` != \"git version \${version}\" ]]
        then
        yum install -y wget tar

        # 下载安装包
        wget -O git-\${version}.tar.gz https://github.com/git/git/archive/v\${version}.tar.gz
        tar xf git-\${version}.tar.gz

        # 安装依赖包
        yum install -y curl-devel expat-devel gettext-devel openssl-devel zlib-devel
        yum install -y gcc perl-ExtUtils-MakeMaker

        # 卸载旧的git版本（如果之前有安装rpm包）
        yum remove -y git

        # 安装
        (
            cd git-\${version}
            make prefix=/usr/local/git all
            make prefix=/usr/local/git install
        )

        if [[ ! \$PATH =~ \"/usr/local/git/bin\" ]]
        then
            echo \"export PATH=\$PATH:/usr/local/git/bin\" >> /etc/bashrc
            source /etc/bashrc
        fi

        rm -rf git-\${version}.tar.gz git-\${version}
    fi

    mkdir -p /hk/proxy-env
    cd /hk/proxy-env
    git clone git@github.com:huiketech/proxy-env.git .
fi

cd /hk/proxy-env && git pull
echo \"${SERVER_NAME_KEY}=${SERVER_NAME_VALUE}\" > /hk/proxy-env/.env
echo \"${PROXY_HOST_KEY}=${PROXY_HOST_VALUE}\" >> /hk/proxy-env/.env
if [[ \"${PROXY_HOST_KEY_2}\" ]]; then
    echo \"${PROXY_HOST_KEY_2}=${PROXY_HOST_VALUE_2}\" >> /hk/proxy-env/.env
fi
sh /hk/proxy-env/install.sh
"
