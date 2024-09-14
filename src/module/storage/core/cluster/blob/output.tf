output "kr-storage-account_name" {
  value = azurerm_storage_account.kr-storage-account.name
}

output "kr-storage-account_id" {
  value = azurerm_storage_account.kr-storage-account.id
}

output "kr_storage_container_name" {
  value = jsondecode(azurerm_resource_group_template_deployment.kr-storage-container.output_content).containername.value
}

output "kr_storage_container_id" {
  value = jsondecode(azurerm_resource_group_template_deployment.kr-storage-container.output_content).containerid.value
  //value = azurerm_resource_group_template_deployment.kr-storage-container.outputs["containerid"]
}

