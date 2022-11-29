module "aws-vpc" {
  source              = "./modules/vpc"
  project             = var.project
  main_vpc_cidr_block = var.main_vpc_cidr_block
  az_set              = var.az_set
  public_subnets      = var.public_subnets
  private_subnets     = var.private_subnets
  enable_natgw        = var.enable_natgw
}

module "k8s-master" {
  source              = "./modules/nodes"
  project             = var.project
  vpc_id              = module.aws-vpc.vpc_id
  node_subnet_id      = module.aws-vpc.pub_subnet_ids[0]
  node_ami            = var.master_ami
  node_instance_type  = var.master_instance_type
  node_disk_size      = var.master_disk_size
  node_count          = var.master_count
  node_name           = var.master_name
  node_ssh_publickey  = var.master_ssh_publickey
  node_ssh_privatekey = var.master_ssh_privatekey
  node_username       = var.master_username
}

module "k8s-worker" {
  source              = "./modules/nodes"
  project             = var.project
  vpc_id              = module.aws-vpc.vpc_id
  node_subnet_id      = module.aws-vpc.pub_subnet_ids[0]
  node_ami            = var.worker_ami
  node_instance_type  = var.worker_instance_type
  node_disk_size      = var.worker_disk_size
  node_count          = var.worker_count
  node_name           = var.worker_name
  node_ssh_publickey  = var.worker_ssh_publickey
  node_ssh_privatekey = var.worker_ssh_privatekey
  node_username       = var.worker_username
}
