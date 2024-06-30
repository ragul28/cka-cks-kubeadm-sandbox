variable "project" {}
variable "environment" {}

variable "aws_region" {}

##VPC
variable "main_vpc_cidr_block" {
  default = "10.25.0.0/24"
}

variable "az_set" {
  default = ["us-east-1c", "us-east-1a"]
}

variable "public_subnets" {
  default = ["10.25.0.0/26", "10.25.0.64/26"]
}

variable "private_subnets" {
  default = ["10.25.0.128/26", "10.25.0.192/26"]
}

variable "enable_natgw" {}

##Master
variable "master_instance_type" {}
variable "master_disk_size" {}
variable "master_count" {}
variable "master_name" {}
variable "master_ssh_publickey" {}
variable "master_ssh_privatekey" {}
variable "master_username" {}

##Worker
variable "worker_instance_type" {}
variable "worker_disk_size" {}
variable "worker_count" {}
variable "worker_name" {}
variable "worker_ssh_publickey" {}
variable "worker_ssh_privatekey" {}
variable "worker_username" {}

## Kube
variable "kube_version" {}