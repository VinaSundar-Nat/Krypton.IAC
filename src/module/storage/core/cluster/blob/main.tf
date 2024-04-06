locals {
  name_account      = "${join("",["kr","core",tostring(terraform.workspace),"account"])}" 
  name_container    = "${join("",["kr","core",tostring(terraform.workspace),"container"])}" 
  blob_container    = "${join("_",["kr","core",tostring(terraform.workspace),"blob"])}" 
}

resource azurerm_storage_account kr-storage-account {
  name                     = local.name_account
  resource_group_name      = var.group
  location                 = var.location 
  account_tier             = var.tier
  account_kind             = var.kind
  account_replication_type = var.replication
  tags                     = var.tags

  network_rules {
    default_action            = "Deny"
    virtual_network_subnet_ids = [var.subnet]
  }
}

resource azurerm_template_deployment kr-storage-container {
  name                = "kr-storage-template-deploy"
  resource_group_name = var.group
  deployment_mode     = "Incremental"

  depends_on = [
    azurerm_storage_account.kr-storage-account
  ]

  parameters = {
    account   = "${azurerm_storage_account.kr-storage-account.name}"    
    container = "${local.name_container}"
  }

  template_body = "${file("${path.module}/container-arm.json")}"
}
