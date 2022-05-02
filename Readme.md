# KubeDM Infra setup

Setup simple kubedm test infra using terrafrom on AWS.

## Getting started

* Make sure AWS credentials are config using aws cli.
* Clone project 

* Fill with necessary variables in `tfvars` file.
```sh
cp terraform.tfvars.sample terraform.tfvars
```

* Run the terraform to create aws stack using Make.
```sh
make plan
make auto_apply
```

* OR Using reguler terraform cli.
```
terraform init
terraform apply
```