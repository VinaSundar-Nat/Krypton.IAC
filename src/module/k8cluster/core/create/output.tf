output "k8_aval_versions" {
  value = data.azurerm_kubernetes_service_versions.aks.versions
}

output "kr_core_cluster_id" {
  value = azurerm_kubernetes_cluster.kr-k8-cluster.id
}

output "kr_core_cluster_name" {
  value = azurerm_kubernetes_cluster.kr-k8-cluster.name
}

output "kr_core_cluster_k8_version" {
  value = azurerm_kubernetes_cluster.kr-k8-cluster.kubernetes_version
}