locals {
  name_nsg      = "${join("_",["kr","core",tostring(terraform.workspace),"nsg"])}" 
  name_sec_rule_in_p80 = "${join("_",["kr",tostring(terraform.workspace),"p80","sec_rule_inbound"])}"
  name_sec_rule_in_p443 = "${join("_",["kr",tostring(terraform.workspace),"p443","sec_rule_inbound"])}"
  name_sec_rule_out_p443 = "${join("_",["kr",tostring(terraform.workspace),"p443","sec_rule_outbound"])}"
}

resource "azurerm_network_security_group" "kr-nsg" {
  name                = local.name_nsg
  location            = var.location        
  resource_group_name = var.group
  tags                = var.tags

  security_rule {
    name                       = local.name_sec_rule_in_p80
    priority                   = 200
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "80"
    source_address_prefix      = var.nsg_sourceip
    destination_address_prefix = "*"
  }

  security_rule {
    name                       = local.name_sec_rule_in_p443
    priority                   = 201
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "443"
    source_address_prefix      = var.nsg_sourceip
    destination_address_prefix = "*"
  }

  security_rule {
    name                       = local.name_sec_rule_out_p443
    priority                   = 201
    direction                  = "Outbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "443"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }

}





 
  