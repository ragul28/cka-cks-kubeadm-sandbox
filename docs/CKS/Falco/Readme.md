# CKS Setup

### install Falco

* Install Falco from official repo. [docs](https://falco.org/docs/install-operate/installation/). During the dialog window selects `Automatic selection` to pick best driver for the node.
```sh
curl -fsSL https://falco.org/repo/falcosecurity-packages.asc | sudo gpg --dearmor -o /usr/share/keyrings/falco-archive-keyring.gpg

echo "deb [signed-by=/usr/share/keyrings/falco-archive-keyring.gpg] https://download.falco.org/packages/deb stable main" | \
sudo tee -a /etc/apt/sources.list.d/falcosecurity.list

apt-get update -y
sudo apt install -y dkms make linux-headers-$(uname -r)
sudo apt install -y clang llvm
sudo apt install -y dialog

sudo apt-get install -y falco
```

## Getting start

* Test the Falco detection by running pod as interactive shell.
```sh
kubectl run -i --tty busybox --image=busybox:1.28 -- sh
```
> If Falco installed on selected nodes use nodesSlector or affinity rule to schedule the pods

* Check the logs
```sh
tail -f /var/log/syslog
```

* Update using the following config & testing the rules
```
vim /etc/falco/falco_rules.yaml
systemctl stop falco-modern-bpf.service

/usr/bin/falco
```

## Falco config links
* [Supported fields on rules](https://falco.org/docs/reference/rules/supported-fields/)
* [Default rules](https://falco.org/docs/reference/rules/default-rules/)
* [Support syscall events](https://falco.org/docs/reference/rules/supported-events/)