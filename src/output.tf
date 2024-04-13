output "kr_rg_name" {
  value = module.deploy-kr-rg.kr_rg_name
}

output "kr-vnet-core-details" {
  value = format("NAME : %s ID %s", module.deploy-kr-vnet-core.kr_vnet_name, module.deploy-kr-vnet-core.kr_vnet_id)
}

output "kr-storage-core-details" {
  value = format("ACCOUNT : %s CONTAINER %s", module.deploy-kr-storage-core.kr-storage-account_name, module.deploy-kr-storage-core.kr_storage_container_name)
}

output "kr-k8-aval-versions" {
  value = module.deploy-kr-k8-cluster.k8_aval_versions
}

output "kr-k8-core-details" {
  value = format("K8CLUSTER : %s K8CLUSTERID %s", module.deploy-kr-k8-cluster.kr_core_cluster_name, module.deploy-kr-k8-cluster.kr_core_cluster_id)
}
