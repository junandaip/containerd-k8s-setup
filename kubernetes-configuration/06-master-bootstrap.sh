#!/bin/bash

kubeadm init --control-plane-endpoint "HAPROXY_HOST:6443" --upload-certs --pod-network-cidr=10.10.0.0/16

kubeadm init --apiserver-advertise-address=192.168.56.11 --control-plane-endpoint "192.168.56.56:6443" --upload-certs --pod-network-cidr=10.10.0.0/16 --v=5 

--apiserver-advertise-address=192.168.56.12
--apiserver-advertise-address=192.168.56.13

mkdir -p $HOME/.kube
  sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
  sudo chown $(id -u):$(id -g) $HOME/.kube/config

kubectl apply -f https://docs.projectcalico.org/manifests/calico.yaml

# For master as worker
#kubectl taint nodes --all node-role.kubernetes.io/master- 