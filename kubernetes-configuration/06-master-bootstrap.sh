#!/bin/bash

kubeadm init --control-plane-endpoint "HAPROXY_HOST:6443" --upload-certs --pod-network-cidr=10.10.0.0/16

kubeadm init --apiserver-advertise-address=10.104.0.2 --control-plane-endpoint "10.104.0.10:6443" --upload-certs --pod-network-cidr=10.10.0.0/16 --v=5 

--apiserver-advertise-address=10.104.0.4 --v=5
--apiserver-advertise-address=10.104.0.6 --v=5

mkdir -p $HOME/.kube
  sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
  sudo chown $(id -u):$(id -g) $HOME/.kube/config

kubectl apply -f https://docs.projectcalico.org/manifests/calico.yaml

# For master as worker
#kubectl taint nodes --all node-role.kubernetes.io/master- 