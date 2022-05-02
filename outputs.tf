output "master_node_ips" {
  value = module.k8s-master.node_ips
}

output "worker_node_ips" {
  value = module.k8s-worker.node_ips
}