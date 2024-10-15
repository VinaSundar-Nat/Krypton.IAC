data "azuread_client_config" "current" {}

resource azuread_application kr-loc-dev-app {  
  display_name        = "${var.group}-${tostring(terraform.workspace)}-localapp"
  description = "az application for to authorize storage blobs for local development ."
  count = tostring(terraform.workspace) == "dev" ? 1 : 0
  # single tenant
  sign_in_audience = "AzureADMyOrg" 
  owners       = [data.azuread_client_config.current.object_id]
}

resource "azuread_service_principal" "kr_loc_sp" {
  count = tostring(terraform.workspace) == "dev" ? 1 : 0
  client_id = azuread_application.kr-loc-dev-app[count.index].client_id
  owners       = [data.azuread_client_config.current.object_id]  
  # tags = var.tags
}
