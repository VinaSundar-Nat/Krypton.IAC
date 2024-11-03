resource azuread_group kr-aks-adm {  
  display_name        = "${var.group}-${tostring(terraform.workspace)}-adm"
  description = "az AKS administrators for the ${var.group} cluster."
  security_enabled = true
  members = [data.azurerm_client_config.current.object_id]
}

