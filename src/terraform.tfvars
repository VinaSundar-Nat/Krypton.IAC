az-location = {
  default = "West US 2",
  dev     = "East US",
  prod    = "Australia East",
  stage   = "Australia East",
  uat     = "West US 2",
  dr      = "South India"
}

az-nsg-sourceip = {
  default = "192.168.1.104",
  dev     = "192.168.1.104",
  prod    = "192.168.1.104",
  stage   = "192.168.1.104",
  uat     = "192.168.1.104",
  dr      = "192.168.1.104"
}

az-vnet-address = {
  default = "10.0.0.0/16",
  dev     = "10.0.0.0/16",
  prod    = "10.0.0.0/16",
  stage   = "10.0.0.0/16",
  uat     = "10.0.0.0/16",
  dr      = "10.0.0.0/16"
}

az-vault-retention = {
  default = "7",
  dev     = "7",
  prod    = "10",
  stage   = "7",
  uat     = "7",
  dr      = "10"
}

az-cosmos-consistency = {
  default = "Eventual",
  dev     = "Eventual",
  prod    = "BoundedStaleness",
  stage   = "BoundedStaleness",
  uat     = "ConsistentPrefix",
  dr      = "Session"
}

az-storage-tier = {
  default = "Standard",
  dev     = "Standard",
  prod    = "Standard",
  stage   = "Standard",
  uat     = "Standard",
  dr      = "Standard"
}

az-storage-replication = {
  default = "LRS",
  dev     = "LRS",
  prod    = "GRS",
  stage   = "GRS",
  uat     = "LRS",
  dr      = "GRS"
}

az-storage-allowrule = {
  "default" = ["123.243.244.129"],
  "dev"     = ["123.243.244.129"],
  "prod"    = [],
  "stage"   = [],
  "uat"     = [],
  "dr"      = ["123.243.244.129"]
}

aks_max_pods = {
  "default" = 10,
  "dev"     = 10,
  "prod"    = 30,
  "stage"   = 30,
  "uat"     = 10,
  "dr"      = 10
}

aks-vm-size = {
  default = "standard_b2ps_v2",
  dev     = "Standard_D2_v4",
  prod    = "standard_b2pls_v2",
  stage   = "Standard_D2as_v4",
  uat     = "Standard_D2as_v4",
  dr      = "Standard_D2_v4"
}

az-keyvault-key-perm = {
  "default" = ["Get", "List"],
  "dev"     = ["Get", "List"],
  "prod"    = ["Get", "List"],
  "stage"   = ["Get", "List"],
  "uat"     = ["Get", "List"],
  "dr"      = ["Get", "List"]
}

az-keyvault-sec-perm = {
  "default" = ["Get", "List", "Set", "Delete", "Backup", "Purge", "Restore", "Recover"],
  "dev"     = ["Get", "List", "Set", "Delete", "Backup", "Purge", "Restore", "Recover"],
  "prod"    = ["Get", "List"],
  "stage"   = ["Get", "List"],
  "uat"     = ["Get", "List", "Set", "Delete", "Backup", "Purge", "Restore", "Recover"],
  "dr"      = ["Get", "List", "Set", "Delete", "Backup", "Purge", "Restore", "Recover"],
}

az-keyvault-cert-perm = {
  "default" = ["Get", "List"],
  "dev"     = ["Get", "List"],
  "prod"    = ["Get", "List"],
  "stage"   = ["Get", "List"],
  "uat"     = ["Get", "List"],
  "dr"      = ["Get", "List"]
}

