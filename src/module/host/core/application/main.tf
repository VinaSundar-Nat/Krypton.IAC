data "azuread_client_config" "current" {}

locals {
  should_create_app = jsondecode(trimspace(file("${path.module}/../resource/response.txt")))["appId"] == "xxxx" && tostring(terraform.workspace) == "dev"
  should_create_sp = jsondecode(trimspace(file("${path.module}/../resource/response.txt")))["spId"] == "xxxx" && tostring(terraform.workspace) == "dev"
}

resource azuread_application kr-loc-dev-app { 
  count = local.should_create_app ? 1 : 0
  
display_name        = "${var.group}-${tostring(terraform.workspace)}-localapp"
  description = "az application for to authorize storage blobs for local development ."
  # single tenant
  sign_in_audience = "AzureADMyOrg" 
  owners       = [data.azuread_client_config.current.object_id]
  # tags = [var.tags]
}

resource "azuread_service_principal" "kr_loc_sp" {   
  count = local.should_create_sp ? 1 : 0
  client_id = azuread_application.kr-loc-dev-app[0].client_id
  owners       = [data.azuread_client_config.current.object_id]  
}
