locals {
  name_usr = "${join("_",["kr",tostring(terraform.workspace),"usr","mangidn"])}"
}

resource azurerm_user_assigned_identity kr-usr-mang-idn {
  location            = var.location
  name                = local.name_usr
  resource_group_name = var.group
}

