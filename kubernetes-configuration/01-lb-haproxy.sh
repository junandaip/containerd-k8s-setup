#!/bin/bash

if [[ $EUID -ne 0 ]]; then
    echo "This script must be run as root" 1>&2
    exit 1
fi

printf "Open firewall\n"

firewall-cmd --add-port 6443/tcp --permanent
firewall-cmd --reload

printf "Install haproxy"

yum -y install haproxy

cat <<EOF | sudo tee /etc/haproxy/haproxy.cfg
listen stats 128.199.77.146:8008
    mode http
    log global
    maxconn 10
    stats enable
    stats hide-version
    stats refresh 10s
    stats show-node
    stats uri  /haproxy?stats

frontend kubernetes
    bind 10.104.0.8:6443
    option tcplog
    mode tcp
    default_backend kubernetes-master-nodes

backend kubernetes-master-nodes
    mode tcp
    balance roundrobin
    option tcp-check
    server k8s-master-1 10.104.0.2:6443 check fall 3 rise 2
    server k8s-master-2 10.104.0.4.12:6443 check fall 3 rise 2
    server k8s-master-3 10.104.0.6.13:6443 check fall 3 rise 2
EOF

setsebool -P haproxy_connect_any=1

printf "Restart"
service haproxy restart
systemctl enable haproxy