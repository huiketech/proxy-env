#!/usr/bin/env bash
# 将执行目录移动到 当前文件所在目录
cd `dirname $0`

PROJECT_HOST=
PROJECT_ROOT_DIR=
PROJECT_NAME=

if [[ -f ./.env ]];then
    source ./.env
fi

element_array=(
# env
    'APP_CODE_PATH_HOST'
    'DATA_PATH_HOST'
    'COMPOSE_PROJECT_NAME'
    'NGINX_HOST_HTTP_PORT'
    'NGINX_HOST_HTTPS_PORT'

    'NGINX_LUA_HOST_HTTP_PORT'
    'NGINX_LUA_HOST_HTTPS_PORT'

    'LARAVEL_ECHO_SERVER_PORT'

# app agent admin
    'APP_NAME'
    'APP_DEBUG'
    'APP_PROXY_HOST'

    'SESSION_DOMAIN'

    'DB_CONNECTION'
    'DB_HOST'
    'DB_PORT'
    'DB_DATABASE'
    'DB_USERNAME'
    'DB_PASSWORD'

# web
    'REACT_APP_CODE'
    'PUBLIC_URL'
    'REACT_APP_API_HOST_DEFAULT'
    'REACT_APP_API_HOSTS'
    'REACT_APP_VERSION'
    'REACT_APP_IMG_HOST'
    'REACT_APP_NAME'
    'REACT_APP_EARLIEST_IOS_APP_VERSION'
    'REACT_APP_IOS_APP_DOWNLOAD_URL'
    'REACT_APP_EARLIEST_ANDROID_APP_VERSION'
    'REACT_APP_ANDROID_APP_DOWNLOAD_URL'
)

# env
env_file=${PROJECT_ROOT_DIR}/${PROJECT_NAME}/env/.env
for element in "${element_array[@]}"
do
    eval element_value=\$${element}
    sed -i "s@^${element}=[^\r\n]*@${element}=${element_value}@g" "${env_file}"
done

# api
env_file=${PROJECT_ROOT_DIR}/${PROJECT_NAME}/app/www/.env
for element in "${element_array[@]}"
do
    eval element_value=\$${element}
    if [[ "${element}" = "APP_NAME" ]];then
        element_value="${element_value}-api"
    fi
    sed -i "s@^${element}=[^\r\n]*@${element}=${element_value}@g" "${env_file}"
done

# agent
env_file=${PROJECT_ROOT_DIR}/${PROJECT_NAME}/agent/www/.env
for element in "${element_array[@]}"
do
    eval element_value=\$${element}
    if [[ "${element}" = "APP_NAME" ]];then
        element_value="${element_value}-agent"
    fi
    sed -i "s@^${element}=[^\r\n]*@${element}=${element_value}@g" "${env_file}"
done

# admin
env_file=${PROJECT_ROOT_DIR}/${PROJECT_NAME}/admin/www/.env
for element in "${element_array[@]}"
do
    eval element_value=\$${element}
    if [[ "${element}" = "APP_NAME" ]];then
        element_value="${element_value}-admin"
    fi
    sed -i "s@^${element}=[^\r\n]*@${element}=${element_value}@g" "${env_file}"
done

# web
env_file=${PROJECT_ROOT_DIR}/${PROJECT_NAME}/web/www/.env.production.local
for element in "${element_array[@]}"
do
    eval element_value=\$${element}
    sed -i "s@^${element}=[^\r\n]*@${element}=${element_value}@g" "${env_file}"
done