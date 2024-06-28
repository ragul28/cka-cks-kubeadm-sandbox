## gVisor

* Install gVisor. 
> https://gvisor.dev/docs/user_guide/install/

```sh
curl -fsSL https://gvisor.dev/archive.key | sudo gpg --dearmor -o /usr/share/keyrings/gvisor-archive-keyring.gpg
echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/gvisor-archive-keyring.gpg] https://storage.googleapis.com/gvisor/releases release main" | sudo tee /etc/apt/sources.list.d/gvisor.list > /dev/null

sudo apt-get update && sudo apt-get install -y runsc
```

* Add following lines under `plugins` in `/etc/containerd/config.toml`. Make sure containerd-shim-runsc-v1 is in ${PATH} or in the same directory as containerd binary.
> https://gvisor.dev/docs/user_guide/containerd/quick_start/

```toml
    [plugins."io.containerd.grpc.v1.cri".containerd.runtimes.runsc]
    runtime_type = "io.containerd.runsc.v1"
```

* Restart containerd
```sh
sudo systemctl restart containerd
```

* Test gVisor in k8s
```sh
k label no node01 runtime=gvisor
k create ns sandbox
k -n sandbox apply -f gvisor-test.yaml 
k -n sandbox exec nginx-gvisor -- dmesg
```