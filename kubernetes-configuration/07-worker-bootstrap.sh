#!/bin/bash

kubeadm join 172.24.56.240:6443 --token TOKEN \
    --discovery-token-ca-cert-hash HASH


vim /var/lib/kubelet/kubeadm-flags.env
KUBELET_KUBEADM_ARGS="--node-ip=IP_ADDR, etc"
systemctl daemon-reload && systemctl restart kubelet