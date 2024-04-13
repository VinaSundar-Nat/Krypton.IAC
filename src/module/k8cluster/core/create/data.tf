
data "azurerm_kubernetes_service_versions" "aks" {
  location = var.location
  include_preview = false
}

output "versions" {
  value = data.azurerm_kubernetes_service_versions.aks.versions
}

output "latest_version" {
  value = data.azurerm_kubernetes_service_versions.aks.latest_version
}