locals {
  name_usr = "${join("_",["kr","core",tostring(terraform.workspace),"usr","mangidn"])}"
  name_kv_usr = "${join("_",["kr","kv",tostring(terraform.workspace),"usr","mangidn"])}"
}

resource azurerm_user_assigned_identity kr-usr-mang-idn {
  location            = var.location
  name                = local.name_usr
  resource_group_name = var.group
}

resource azurerm_user_assigned_identity kr-kv-mang-idn {
  name                = local.name_kv_usr
  location            = var.location
  resource_group_name = var.group
}

