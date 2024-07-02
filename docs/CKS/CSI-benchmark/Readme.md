# Kube-Bench

## Install

```sh
curl -L https://github.com/aquasecurity/kube-bench/releases/download/v0.7.3/kube-bench_0.7.3_linux_amd64.tar.gz -o kube-bench_0.7.3_linux_amd64.tar.gz
tar -xvf kube-bench_0.7.3_linux_amd64.tar.gz
```

> https://github.com/aquasecurity/kube-bench/blob/main/docs/installation.md

## Running kube-bench

```sh
./kube-bench --config-dir `pwd`/cfg --config `pwd`/cfg/config.yaml
```

## Enabling audit

* Create log folder & policy yaml. [Link](https://kubernetes.io/docs/tasks/debug/debug-cluster/audit/#log-backend)
```sh
mkdir -p /var/log/kubernetes/audit/
vim /etc/kubernetes/audit-policy.yaml
```

* Update the kube-apiserver include audit config & Include the volume mounts
```yaml
  - --audit-policy-file=/etc/kubernetes/audit-policy.yaml
  - --audit-log-path=/var/log/kubernetes/audit/audit.log
  - --audit-log-maxage=3
  - --audit-log-maxbackup=5
  - --audit-log-maxbackup=200
```

## List resources

* System users list
```sh
$ kubectl get clusterrolebindings -o jsonpath='{range .items[*]}{.subjects[?(@.kind=="Group")].name}{"\n"}{end}' | sort | uniq

kubeadm:cluster-admins
system:authenticated
system:authenticated system:unauthenticated
system:bootstrappers:kubeadm:default-node-token
system:masters
system:monitoring
system:nodes
system:serviceaccounts
```

* System userGroups list
```sh
$ kubectl get clusterrolebindings -o jsonpath='{range .items[*]}{.subjects[?(@.kind=="User")].name}{"\n"}{end}' | sort | uniq

system:kube-controller-manager
system:kube-proxy
system:kube-scheduler
```