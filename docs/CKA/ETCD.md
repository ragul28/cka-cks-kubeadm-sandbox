# ETCD

## Etcd backup
> https://kubernetes.io/docs/tasks/administer-cluster/configure-upgrade-etcd/


* Install etcdctl tool. (Verify ctl version inside pod)
```sh
k exec etcd-ip-10-25-0-48 -n kube-system -- etcdctl version
wget https://github.com/etcd-io/etcd/releases/download/v3.5.6/etcd-v3.5.6-linux-amd64.tar.gz
tar xzvf etcd-v3.4.13-linux-amd64.tar.gz
sudo mv etcd-v3.4.13-linux-amd64/etcdctl /usr/local/bin
```

* Getting backup using etcdctl
```sh
export ETCDCTL_API=3
kubectl get pods etcd-node-1 -n kube-system -o=jsonpath='{.spec.containers[0].command}' | jq
sudo etcdctl snapshot save --endpoints 127.0.0.1:2379 snapshot.db --cacert /etc/kubernetes/pki/etcd/ca.crt --cert /etc/kubernetes/pki/etcd/server.crt --key /etc/kubernetes/pki/etcd/server.key
sudo etcdctl --write-out=table snapshot status snapshot.db
```

## ETCD Restore
> https://kubernetes.io/docs/tasks/administer-cluster/configure-upgrade-etcd/#restoring-an-etcd-cluster

* Stop the static system pods
```sh
sudo mv /etc/kubernetes/manifests/kube* /tmp/
```

* Etcd Restore from backup
```sh
sudo etcdctl --endpoints 127.0.0.1:2379 snapshot restore snapshot.db --data-dir /var/lib/etcd-backup --cacert /etc/kubernetes/pki/etcd/ca.crt --cert /etc/kubernetes/pki/etcd/server.crt --key /etc/kubernetes/pki/etcd/server.key
```

* Update etcd data path
```sh
sudo vim /etc/kubernetes/manifests/etcd.yaml
```
> update spec with following arg `--data-dir=/var/lib/etcd-backup`. Plus change mount & host path on ectd  manifests

* Wait few sec until etcd pod updated & bring back kube static pod revert manifests
```
sudo mv /tmp/kube* /etc/kubernetes/manifests/
```