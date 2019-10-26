#!/usr/bin/env bash
# 将执行目录移动到 当前文件所在目录
cd `dirname $0`

host_array=(
#    'a8mg15.info'
#    'a8mg15.online'
#    'a8mg15.site'
#    'a8mg15.space'
#    'a8mg15.xyz'
#    'adfgagav.club'
#    'adfgagav.info'
#    'adfgagav.online'
#    'adfgagav.site'
#    'adfgagav.space'
#    'adfgagav.xyz'
#    'andagaij.com'
#    'andagaij.net'
#    'andagaij.org'
#    'andagij.com'
#    'andajij.com'
#    'anmg15.me'
#    'anmg15.online'
#    'anmg15.site'
#    'anmg15.space'
#    'anmg15.xyz'
#    'bjh3kg.me'
#    'bjh3kg.online'
#    'bjh3kg.site'
#    'bjh3kg.space'
#    'bjh3kg.xyz'

    'iriojk.com'
    'eoehgr.com'
    'upjbf.com'
    'eqpeig.com'
    'iwxihf.com'
    'arjvx.com'
    'ciurw.net'
    'qpeig.xyz'
    'ytbgo.xyz'
    'oehgr.xyz'
    'iytnd.xyz'
    'vifps.xyz'
    'riojk.xyz'
    'itjbf.xyz'
    'orjvx.xyz'
    'otisf.xyz'
    'wxihf.xyz'
    'roijh.xyz'
    'iotrc.xyz'
    'ciurw.xyz'
);

domain_proxy_ip=103.100.63.137

scp ./install-wildcard-domain.sub.sh root@${domain_proxy_ip}:/root/install-wildcard-domain.sub.sh
for element in ${host_array[@]}
do
    ssh -o StrictHostKeyChecking=no root@${domain_proxy_ip} "sh /root/install-wildcard-domain.sub.sh ${element}"
done
