# CKS

## KubeDM Cluster setup

* Install containerd
> https://kubernetes.io/docs/setup/production-environment/container-runtimes/

* Install kubedm
> https://kubernetes.io/docs/setup/production-environment/tools/kubeadm/install-kubeadm/

* Create kubedm cluster Master node
> https://kubernetes.io/docs/setup/production-environment/tools/kubeadm/create-cluster-kubeadm/

* Cluster Init with cri socket
```sh
sudo kubeadm init --pod-network-cidr=10.244.0.0/16 --cri-socket unix:///run/containerd/containerd.sock
```

* Configure kubectl access
```sh
mkdir -p $HOME/.kube
sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
sudo chown $(id -u):$(id -g) $HOME/.kube/config
```
* SSH into the master node retrieve the join command & run it on worker nodes
```sh
kubeadm token create --print-join-command --ttl 0
```
> Test the master node connection using `telnet <MASTER_IP> 6443`

### Network plugin

* Install Flannel for minimal network plugin  
```sh
kubectl apply -f https://raw.githubusercontent.com/flannel-io/flannel/master/Documentation/kube-flannel.yml
```
* Or use Calico network plugin. [Installation setups](https://docs.tigera.io/calico/latest/getting-started/kubernetes/self-managed-onprem/onpremises)

> https://kubernetes.io/docs/concepts/cluster-administration/networking/#how-to-implement-the-kubernetes-network-model


### Check cluster status

```sh
kubectl get componentstatuses
kubectl get --raw='/readyz?verbose'
```

## Upgrade cluster
> https://kubernetes.io/docs/tasks/administer-cluster/kubeadm/kubeadm-upgrade/
