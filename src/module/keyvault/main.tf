locals {
  name_kv     = "${join("0",["kr","core",tostring(terraform.workspace),"kv"])}"
}

resource azurerm_key_vault kr-kv {
  count = var.create_vault == true ? 1 : 0
  name                        = local.name_kv
  location                    = var.location
  resource_group_name         = var.group
  sku_name                    = var.sku
  tenant_id                   = data.azurerm_client_config.current.tenant_id

  purge_protection_enabled    = false
  soft_delete_retention_days  = 7
  tags = var.tags
}

resource azurerm_key_vault_access_policy kr-kv-umgd-access {
  count = var.create_vault == true ? 1 : 0
  key_vault_id = azurerm_key_vault.kr-kv[0].id

  tenant_id     = data.azurerm_client_config.current.tenant_id
  object_id     = var.userPrincipal

   key_permissions = var.key-permissions
  secret_permissions = var.secret-permissions
  certificate_permissions = var.cert-permissions
}

resource azurerm_key_vault_access_policy kr-kv-sp-access {
  count = var.create_vault == true && tostring(terraform.workspace) == "dev" ? 1 : 0
  key_vault_id = azurerm_key_vault.kr-kv[0].id

  tenant_id     = data.azurerm_client_config.current.tenant_id
  object_id     = var.servicePrincipal

  key_permissions = var.key-permissions
  secret_permissions = var.secret-permissions
  certificate_permissions = var.cert-permissions
}