output "k8_aval_versions" {
  value = data.azurerm_kubernetes_service_versions.aks.versions
}

output "kr_core_cluster_id" {
  value = length(azurerm_kubernetes_cluster.kr-k8-cluster) > 0 ? azurerm_kubernetes_cluster.kr-k8-cluster[0].id : null
}

output "kr_core_cluster_name" {
  value = length(azurerm_kubernetes_cluster.kr-k8-cluster) > 0 ? azurerm_kubernetes_cluster.kr-k8-cluster[0].name : null
}

output "kr_core_cluster_k8_version" {
  value =  length(azurerm_kubernetes_cluster.kr-k8-cluster) > 0 ? azurerm_kubernetes_cluster.kr-k8-cluster[0].kubernetes_version : null
}