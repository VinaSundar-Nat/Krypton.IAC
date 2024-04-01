locals {
  name_subnet   = "${join("_",["kr","core",tostring(terraform.workspace),"subnet"])}"
}


resource "azurerm_subnet" "kr-subnet" {
  name                 = local.name_subnet
  resource_group_name  = var.group
  virtual_network_name = var.vnet
  address_prefixes     = ["10.0.2.0/24"]
  service_endpoints    = var.endpoints  
}


resource "azurerm_subnet_network_security_group_association" "kr-subnet" {
  subnet_id                 = azurerm_subnet.kr-subnet.id
  network_security_group_id = var.nsg

  depends_on = [
    azurerm_subnet.kr-subnet
  ]
}








 
  