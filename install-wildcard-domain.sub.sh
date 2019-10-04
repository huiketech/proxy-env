#!/usr/bin/env bash
# 将执行目录移动到 当前文件所在目录
cd `dirname $0`

if [[ ! ${1} ]]; then
    echo '未指定 域名(不用写 *.)';
    exit;
fi

proxy_host=http://127.0.0.1:5882

#/root/.acme.sh/acme.sh --issue --dns dns_gd -d *.${1}

mkdir -p /etc/nginx/ssl/${1}
/root/.acme.sh/acme.sh --installcert -d *.${1} \
        --key-file /etc/nginx/ssl/${1}/privkey.pem \
        --fullchain-file /etc/nginx/ssl/${1}/fullchain.pem \
        --reloadcmd "service nginx force-reload"

echo "server {
    listen       80;
    server_name  *.${1};

    location / {
        proxy_set_header  Host  \$host;
        proxy_set_header  X-real-ip \$remote_addr;
        proxy_set_header  X-Forwarded-For \$proxy_add_x_forwarded_for;
        proxy_pass ${proxy_host};
    }

    listen 443 ssl; # managed by Certbot
    ssl_certificate /etc/nginx/ssl/${1}/fullchain.pem; # managed by Certbot
    ssl_certificate_key /etc/nginx/ssl/${1}/privkey.pem; # managed by Certbot
    include /etc/letsencrypt/options-ssl-nginx.conf; # managed by Certbot
    ssl_dhparam /etc/letsencrypt/ssl-dhparams.pem; # managed by Certbot
}" > /etc/nginx/conf.d/${1}.conf

service nginx force-reload