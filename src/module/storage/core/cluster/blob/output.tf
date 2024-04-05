output "kr-storage-account_name" {
  value = azurerm_storage_account.kr-storage-account.name
}

output "kr-storage-account_id" {
  value = azurerm_storage_account.kr-storage-account.id
}

output "kr_storage_container_name" {
  value = azurerm_template_deployment.kr-storage-container.outputs["containername"]
}

output "kr_storage_container_id" {
  value = azurerm_template_deployment.kr-storage-container.outputs["containerid"]
}

