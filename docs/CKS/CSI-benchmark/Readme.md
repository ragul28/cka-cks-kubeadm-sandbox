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