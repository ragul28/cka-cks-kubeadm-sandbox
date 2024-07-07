# CKA & CKS Kubeadm Sandbox

Setup a vanilla Kubernetes cluster using Kubeadm in AWS with Terraform. This project creates the necessary network, compute resources, and Kubeadm provisioning. This making it perfect for practicing CKA and CKS skills.

## 🚀 Features
- Automated Cluster Provisioning: Utilize Terraform to automate the provisioning of Kubernetes clusters in AWS.This includes dependencies such as containerd, Kubeadm, kubelet, and kubectl.
- Calico CNI: Calico installed as part of cluster Provisioning.
- Kubernetes Certification: Basic Guides and docs tailored for CKA and CKS exam.

## 🛠️ Getting started

* Make sure AWS credentials are config using aws cli.
* Clone project 

* Fill with necessary variables in `tfvars` file.
```sh
cp terraform.tfvars.sample terraform.tfvars
```
* Export to use different profile
```sh
Export AWS_PROFILE=<profile_name>
```
* Run the terraform to create aws stack using Make.
```sh
make plan
make apply
```

* Verify cluster components are healthy & then from the master node retrieve the join command to run it on worker nodes
```sh
kubectl get --raw='/readyz?verbose'

kubeadm token create --print-join-command --ttl 0
``` 

* Verify the nodes are listed with system pods running healthy
```sh
kubectl get no
kubectl get po -A
```

## 📚 Documentation
List of available in the docs directory, including setup guides, usage instructions, and troubleshooting tips.

- **[CKA](./docs/CKA/Readme.md)**
  - [Cluster setup guide](./docs/CKA/Readme.md#kubedm-cluster-setup)
  - [Cluster version upgrade](./docs/CKA/Readme.md#upgrade-cluster)
  - [CNI setup](./docs/CKA/Readme.md#network-plugin)
  - [ETCD operations](./docs/CKA/ETCD.md) 
- **[CKS](./docs/CKS/Readme.md)**
  - [Pod Security Standards](https://kubernetes.io/docs/concepts/security/pod-security-standards/)
  - [Security context](https://kubernetes.io/docs/tasks/configure-pod-container/security-context/)
      - [AppArmor](./docs/CKS/SystemHardening/Readme.md)
      - [Seccomp](https://kubernetes.io/docs/tutorials/security/seccomp/)
  - [Sandbox RuntimeClass](https://kubernetes.io/docs/concepts/containers/runtime-class/) - [gVisor](./docs/CKS/Sandbox/Readme.md)
  - [Audit](./docs/CKS/CSI-benchmark/Readme.md#enabling-audit)
  - [Certificate Signing Requests](https://kubernetes.io/docs/reference/access-authn-authz/certificate-signing-requests/#normal-user):
  - [ImagePolicyWebhook](https://kubernetes.io/docs/reference/access-authn-authz/admission-controllers/#imagepolicywebhook)
  - [Networkpolicy](https://kubernetes.io/docs/concepts/services-networking/network-policies/)
  - [Falco](./docs/CKS/Falco/Readme.md)
  - [OPA](https://www.openpolicyagent.org/docs/latest/kubernetes-primer/)
  - [CSI Benchmark](./docs/CKS/CSI-benchmark/Readme.md)