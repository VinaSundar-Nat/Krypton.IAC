locals {
  name_vnet     = "${join("_",["kr","core",tostring(terraform.workspace),"vnet"])}"
}


resource azurerm_virtual_network kr-vnet {
  name                = local.name_vnet
  location            = var.location 
  resource_group_name = var.group
  address_space       = [var.address]
  tags                = var.tags
}










 
  