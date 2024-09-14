locals {
  name_account      = "${join("",["kr","core",tostring(terraform.workspace),"account"])}" 
  name_container    = "${join("",["kr","core","doc",tostring(terraform.workspace),"container"])}" 
  blob_container    = "${join("_",["kr","core","doc",tostring(terraform.workspace),"blob"])}" 
}

resource azurerm_storage_account kr-storage-account {
  name                     = local.name_account
  resource_group_name      = var.group
  location                 = var.location 
  account_tier             = var.tier
  account_kind             = var.kind
  account_replication_type = var.replication
  tags                     = var.tags

  # network_rules {
  #   default_action            = "Deny"
  #   virtual_network_subnet_ids = [var.subnet]
  # }
}

resource "azurerm_storage_account_network_rules" kr-storage-network-rules {
  storage_account_id    = azurerm_storage_account.kr-storage-account.id
  default_action        = "Deny"
  bypass                = var.bypasssettings
  ip_rules              = var.allowip != [] ? var.allowip : null
  virtual_network_subnet_ids = [var.subnet]
}

resource azurerm_resource_group_template_deployment kr-storage-container {
  name                = "kr-storage-template-deploy"
  resource_group_name = var.group
  deployment_mode     = "Incremental"

  template_content = "${file("${path.module}/container-arm.json")}"

  parameters_content  = <<PARAMETERS
    {
        "account": {
            "value": "${azurerm_storage_account.kr-storage-account.name}"
        },
        "container": {
            "value": "${local.name_container}"
        }
    }
    PARAMETERS 

  depends_on = [
    azurerm_storage_account.kr-storage-account
  ]
}
