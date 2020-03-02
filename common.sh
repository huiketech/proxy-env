#!/usr/bin/env bash


cd /hk/proxy-env/ && \
    git pull && \
    \cp -f ./conf.d/nginx.conf /etc/nginx/nginx.conf && \
    \cp -f ./conf.d/default_server.crt /etc/nginx/default_server.crt && \
    \cp -f ./conf.d/default_server.key /etc/nginx/default_server.key && \
    nginx -t && nginx -s reload

