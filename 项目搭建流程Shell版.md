项目搭建流程shell版

```shell
1.1 购买域名
登录亚马逊平台, 搜索route53 选择注册域 搜索想要的域名 添加到购物车
注册1年,不续订 

1.2 域名解析 
线路2的 api.2.xxx.xx  CNAME hk2.apigroup.link
线路3的 api.3.xxx.xx  CNAME hk22.apigroup.link
线路4的 api.4.xxx.xx  CNAME sg21.apigroup.link
线路5的 api.5.xxx.xx  CNAME sg22.apigroup.link
admin.6899.xx, agent.6762.xx, *.xx  ipv4 服务器公网ip

2. 创建数据库
创建数据库(hk_hzhuan)
创建用户, 选择数据库权限, 导入数据表
DB_DATABASE = hk_hzhuan
DB_USERNAME = hk_hzhuan
DB_PASSWORD = oihYTA&OHkJNKH&t

3. 项目代码搭建, 连接git
tar -zcvf xx-xxx.tar.gz xx-xx   压缩文件
scp xx-xxx.tar.gz root@'目标服务器':/hk   传输文件
没有公钥匙钥时 
拷贝当前服务器的公钥 到目标服务器的.ssh/authorized_keys 文件内
tar -zxvf xx-xxx.tar.gz		解压文件

4. 配置文件搭建
配置文件时 netstat -ntlp 查询端口号占用情况
580x 600x 540x +1之后 更改配置文件

本地 创建.env文件 

例如：
# wz-云易
H5_SERVER_NAME=h5.theyunyi.net (h5.域名
H5_PROXY_HOST=http://127.0.0.1:5801 （127.0.0.1:端口号

ONLINE_SERVICE_SERVER_NAME=online-service.theyunyi.net（客服服务器配置
ONLINE_SERVICE_PROXY_HOST=http://online-service.hk.5.inhosts.net:5893
ONLINE_SERVICE_PROXY_HOST_2=http://online-service.hk.5.inhosts.net:2020

API_1_SERVER_NAME=api.1.theyunyi.net 
API_1_PROXY_HOST=http://127.0.0.1:5801
API_2_SERVER_NAME=api.2.theyunyi.net
API_2_PROXY_HOST=http://18.162.226.0:5801
API_3_SERVER_NAME=api.3.theyunyi.net
API_3_PROXY_HOST=http://18.162.226.0:5801
API_4_SERVER_NAME=api.4.theyunyi.net
API_4_PROXY_HOST=http://18.162.226.0:5801
API_5_SERVER_NAME=api.5.theyunyi.net
API_5_PROXY_HOST=http://18.162.226.0:5801

ADMIN_SERVER_NAME=admin.6899.theyunyi.net
ADMIN_PROXY_HOST=http://18.162.226.0:5801
AGENT_SERVER_NAME=agent.6762.theyunyi.net
AGENT_PROXY_HOST=http://18.162.226.0:5801

PROJECT_HOST=com-money-6.5.inhosts.net 
PROJECT_ROOT_DIR=/hk
PROJECT_NAME=wz-yunyi

APP_NAME=wz-yunyi
SESSION_DOMAIN=theyunyi.net
APP_PROXY_HOST=http://18.162.226.0:5801

DB_CONNECTION=mysql
DB_HOST=com-money-4.cibvbxlljocs.ap-east-1.rds.amazonaws.com
DB_PORT=3306
DB_DATABASE=wz_yunyi
DB_USERNAME=wz
DB_PASSWORD=d3oteXVueWk=
DB_CHARSET=utf8mb4
DB_COLLATION=utf8mb4_unicode_ci

# Point to the path of your applications code on your host
APP_CODE_PATH_HOST=/hk/wz-yunyi

# Choose storage path on your machine. For all storage systems
DATA_PATH_HOST=~/.laradock/wz-yunyi/data

# Define the prefix of container names. This is useful if you have multiple projects that use laradock to have seperate containers per project.
COMPOSE_PROJECT_NAME=wz-yunyi

NGINX_HOST_HTTP_PORT=5801
NGINX_HOST_HTTPS_PORT=5401

NGINX_LUA_HOST_HTTP_PORT=5801
NGINX_LUA_HOST_HTTPS_PORT=5401

LARAVEL_ECHO_SERVER_PORT=6001


# wz-云易

REACT_APP_CODE=wz-yunyi
PUBLIC_URL=https://d38s53scas00u7.cloudfront.net/h5.theyunyi.net
REACT_APP_API_HOST_DEFAULT=https://api.1.theyunyi.net
REACT_APP_API_HOSTS=https://api.1.theyunyi.net,https://api.2.theyunyi.net,https://api.3.theyunyi.net,https://api.4.theyunyi.net,https://api.5.theyunyi.net
REACT_APP_VERSION=2.0.0
REACT_APP_IMG_HOST=https://d38s53scas00u7.cloudfront.net/h5.theyunyi.net
REACT_APP_NAME=云易

#支持的最早iOS应用版本
REACT_APP_EARLIEST_IOS_APP_VERSION=2.0.0
#iOS应用下载地址
REACT_APP_IOS_APP_DOWNLOAD_URL=https://h5.theyunyi.net/d/p
#支持的最早安卓应用版本
REACT_APP_EARLIEST_ANDROID_APP_VERSION=2.0.0
#安卓应用下载地址
REACT_APP_ANDROID_APP_DOWNLOAD_URL=https://h5.theyunyi.net/d/p

没有环境的情况下 到env文件下执行
sh env.build.sh
搭建环境

在本地proxy-env/目录下 运行
sh remote-install.sh
sh remote-update-env.sh
进入项目服务器 env目录下运行
sh project-build/copied.init.sh

完成
```


