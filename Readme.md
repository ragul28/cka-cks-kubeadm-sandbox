# KubeDM Infra setup

Setup vanilla k8s cluster using KubeDM in AWS ec2. Used as sandbox for CKA & CKS.  

## Getting started

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

* SSH into the master node retrieve the join command & run it on worker nodes
```sh
kubeadm token create --print-join-command --ttl 0
```