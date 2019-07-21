#!/usr/bin/env bash
# 部署静态资源转发

# 将执行目录移动到 当前文件所在目录
cd `dirname $0`

EMAIL=lzw122333@gmail.com
SERVER_NAME=static-forwarding.iiinn.net

sudo yum install -y epel-release
sudo yum install -y nginx

## yum命令出现Loaded plugins: fastestmirror   https://blog.csdn.net/tiweeny/article/details/73333806
# vi /etc/yum/pluginconf.d/fastestmirror.conf
# 将 enabled=1 改为 enabled=0
# vi /etc/yum.conf
# 将 plugins=1 改为 plugins=0
# reboot

sudo systemctl enable nginx
sudo systemctl start nginx

# sudo firewall-cmd --permanent --zone=public --add-service=http
# sudo firewall-cmd --permanent --zone=public --add-service=https
# sudo firewall-cmd --permanent --zone=public --add-port=6001
# sudo firewall-cmd --reload

## 安装 certbot https://certbot.eff.org/lets-encrypt/centosrhel7-nginx
sudo yum install -y yum-utils epel-release
sudo yum-config-manager --enable rhui-REGION-rhel-server-extras rhui-REGION-rhel-server-optional

sudo yum install -y python2-certbot-nginx

## 创建 Nginx 配置文件

## 生成证书

echo "server {
    server_name  ${SERVER_NAME};

    location ~ ^/([^/]+)/ {
        set \$proxy_host \$1;
        resolver 8.8.8.8;
        rewrite /[^/]+/(.*) /\$1 break;
        proxy_pass https://\$proxy_host;
    }
}" > /etc/nginx/conf.d/static-forwarding.conf;

certbot --nginx -d ${SERVER_NAME} --agree-tos --email "$EMAIL" -n
sed -i s~"listen       80;"~""~g /etc/nginx/conf.d/static-forwarding.conf;
echo "
server {
    if (\$host = ${SERVER_NAME}) {
        return 301 https://\$host\$request_uri;
    } # managed by Certbot


    listen       80;
    server_name  ${SERVER_NAME};
    return 404; # managed by Certbot
}
" >> /etc/nginx/conf.d/static-forwarding.conf

## 添加计划任务
# crontab -e
# 0 0 */5 * * /usr/bin/certbot renew

## 无法转发 (13: Permission denied) while connecting to upstream:[nginx]
# setsebool -P httpd_can_network_connect 1