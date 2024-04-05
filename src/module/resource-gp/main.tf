locals {
  name_rg = "${join("_",["kr",tostring(terraform.workspace),"rg"])}"
}

resource azurerm_resource_group kr-rg {
  name=local.name_rg
  location=var.location
  tags=var.tags
}