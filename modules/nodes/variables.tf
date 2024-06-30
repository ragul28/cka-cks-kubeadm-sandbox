variable "project" {}
variable "vpc_id" {}

variable "node_subnet_id" {}
variable "node_instance_type" {}
variable "node_disk_size" {}
variable "node_count" {}
variable "node_name" {}

variable "node_ssh_publickey" {}
variable "node_ssh_privatekey" {}
variable "node_username" {}

variable "node_role" {
  default = "worker"
  type = string
}

variable "kube_version" {
  type = string
}