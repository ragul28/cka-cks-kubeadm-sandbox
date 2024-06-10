#!/bin/bash
set -eoux pipefail

NODE_ROLE="${1:-worker}"
KUBE_VERSION="${2:-v1.29}"

# containerd preinstall configuration
cat <<EOF | sudo tee /etc/modules-load.d/containerd.conf
overlay
br_netfilter
EOF

sudo modprobe overlay
sudo modprobe br_netfilter

# Setup required sysctl params, these persist across reboots.
cat <<EOF | sudo tee /etc/sysctl.d/99-kubernetes-cri.conf
net.bridge.bridge-nf-call-iptables  = 1
net.ipv4.ip_forward                 = 1
net.bridge.bridge-nf-call-ip6tables = 1
EOF

# Apply sysctl params without reboot
sudo sysctl --system >/dev/null

# Install containerd
## Set up the repository
### Install packages to allow apt to use a repository over HTTPS
sudo apt-get update -qq
sudo apt-get install -yqq \
    apt-transport-https \
    ca-certificates \
    curl \
    gnupg \
    lsb-release >/dev/null

## Add Docker’s official GPG key
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg

## Add Docker apt repository.
echo \
  "deb [arch=amd64 signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu \
  $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

## Install packages
sudo apt-get update -qq
sudo apt-get install -yqq containerd.io >/dev/null

# Configure containerd
sudo mkdir -p /etc/containerd
containerd config default | sudo tee /etc/containerd/config.toml

# https://kubernetes.io/docs/setup/production-environment/tools/kubeadm/install-kubeadm/#configuring-a-cgroup-driver
sudo sed -i "/^\([[:space:]]*SystemdCgroup = \).*/s//\1true/" /etc/containerd/config.toml

# Setup crictl endpoint
cat <<EOF | sudo tee /etc/crictl.yaml
runtime-endpoint: unix:///run/containerd/containerd.sock
EOF

# Install Kubeadm, kubelet & kubectl
sudo mkdir -p /etc/apt/keyrings/
curl -fsSL https://pkgs.k8s.io/core:/stable:/${KUBE_VERSION}/deb/Release.key | sudo gpg --dearmor -o /etc/apt/keyrings/kubernetes-apt-keyring.gpg
echo "deb [signed-by=/etc/apt/keyrings/kubernetes-apt-keyring.gpg] https://pkgs.k8s.io/core:/stable:/${KUBE_VERSION}/deb/ /" | sudo tee /etc/apt/sources.list.d/kubernetes.list

sudo apt-get update -qq
sudo apt-get install -yqq kubelet kubeadm kubectl >/dev/null
sudo apt-mark hold kubelet kubeadm kubectl

### start services
sudo systemctl daemon-reload
sudo systemctl enable containerd
sudo systemctl restart containerd

sudo systemctl enable kubelet
sudo systemctl stop kubelet

if [ "$NODE_ROLE" = "master" ]; then
  ### init k8s
  sudo kubeadm init --pod-network-cidr=10.244.0.0/16 --cri-socket unix:///run/containerd/containerd.sock --ignore-preflight-errors=NumCPU --skip-token-print

  ### Setup kube config
  mkdir -p ~/.kube
  sudo cp -i /etc/kubernetes/admin.conf ~/.kube/config
  sudo chown $(id -u):$(id -g) ~/.kube/config

  ## Create Calico CNI
  CALICO_VERSION=${3:-v3.28.0}
  kubectl create -f https://raw.githubusercontent.com/projectcalico/calico/${CALICO_VERSION}/manifests/tigera-operator.yaml
  curl -fsSL https://raw.githubusercontent.com/projectcalico/calico/${CALICO_VERSION}/manifests/custom-resources.yaml | sed 's/192.168.0.0\/16/10.244.0.0\/16/g' | kubectl apply -f -

  ### Install matric-server
  curl -fsSL https://github.com/kubernetes-sigs/metrics-server/releases/latest/download/components.yaml | sed 's/10250/4443/g' | kubectl apply -f -
  kubectl patch deployment metrics-server -n kube-system --type='json' -p='[{"op": "add", "path": "/spec/template/spec/hostNetwork", "value": true},{"op": "add", "path": "/spec/template/spec/containers/0/args/-", "value": "--kubelet-insecure-tls"}]'
fi