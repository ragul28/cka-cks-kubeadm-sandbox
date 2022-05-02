# KubeDM Cluster setup

## Install containerd
> https://kubernetes.io/docs/setup/production-environment/container-runtimes/

## Install kubedm
> https://kubernetes.io/docs/setup/production-environment/tools/kubeadm/install-kubeadm/

## Create kubedm cluster Master node
> https://kubernetes.io/docs/setup/production-environment/tools/kubeadm/create-cluster-kubeadm/

* Cluster Init with cri socket
```sh
sudo kubeadm init --pod-network-cidr=10.90.0.0/16 --cri-socket unix:///run/containerd/containerd.sock
```

### Configure kubectl access
```sh
mkdir -p $HOME/.kube
sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
sudo chown $(id -u):$(id -g) $HOME/.kube/config
```

### Deploy Flannel as a network plugin
kubectl apply -f https://raw.githubusercontent.com/flannel-io/flannel/master/Documentation/kube-flannel.yml

* Join worker nodes
```sh
telnet <MASTER_IP> 6443

kubeadm join <MASTER_IP>:6443 --token l0o18o.xy58cwxhqdglwroa \
    --discovery-token-ca-cert-hash sha256:d213075f844a5349a76feb31cafca541bc5a7c6744997807f51afea533dd2ecd
```

## K8s version

* Setup version: 1.22.8
* Latest version: 1.23.6


