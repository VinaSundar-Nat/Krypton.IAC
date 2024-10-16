# We strongly recommend using the required_providers block to set the
# Azure Provider source and version being used
terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~>3.0"
    }
    azuread = {
      source  = "hashicorp/azuread"
      version = "~> 2.0"
    }
    random = {
      source  = "hashicorp/random"
      version = "~>3.0"
    }
    time = {
      source  = "hashicorp/time"
      version = "0.9.1"
    }
  }
}

# Configure the Microsoft Azure Provider
provider "azurerm" {
  features {}
  client_id                   = var.AZ_CLIENT_ID
  client_certificate_path     = var.AZ_CERT_PATH
  client_certificate_password = var.AZ_CERT_PASSWORD
  tenant_id                   = var.AZ_TENNENT_ID
  subscription_id             = var.AZ_SUBSCRIPTION
}

provider "azuread" {
  tenant_id                   = var.AZ_TENNENT_ID
  client_id                   = var.AZ_CLIENT_ID
  client_certificate_path     = var.AZ_CERT_PATH
  client_certificate_password = var.AZ_CERT_PASSWORD
}

module "deploy-kr-rg" {
  source   = "./module/resource-gp"
  location = var.az-location[terraform.workspace]
  tags = {
    env      = terraform.workspace,
    owner    = var.owner
    division = var.division
    source   = var.source_system
  }
}

# Network
module "deploy-kr-nsg-core" {
  source       = "./module/network/core/nsg"
  group        = module.deploy-kr-rg.kr_rg_name
  location     = var.az-location[terraform.workspace]
  nsg_sourceip = var.az-nsg-sourceip[terraform.workspace]
  tags = {
    env      = terraform.workspace,
    owner    = var.owner
    division = var.division
    source   = var.source_system
  }
}

module "deploy-kr-vnet-core" {
  source   = "./module/network/core/vnet"
  group    = module.deploy-kr-rg.kr_rg_name
  location = var.az-location[terraform.workspace]
  address  = var.az-vnet-address[terraform.workspace]
  tags = {
    env      = terraform.workspace,
    owner    = var.owner
    division = var.division
    source   = var.source_system
  }
}

module "deploy-kr-subnet-core" {
  source    = "./module/network/core/subnet"
  group     = module.deploy-kr-rg.kr_rg_name
  location  = var.az-location[terraform.workspace]
  vnet      = module.deploy-kr-vnet-core.kr_vnet_name
  nsg       = module.deploy-kr-nsg-core.kr_nsg_id
  endpoints = var.az-src-endpoints
}

#Identity - user managed identity
module "deploy-kr-host-usr_mang" {
  source   = "./module/host/core/identity"
  group    = module.deploy-kr-rg.kr_rg_name
  location = var.az-location[terraform.workspace]
}

#Local development - application and service principal
module "deploy-kr-host-app_loc" {
  source = "./module/host/core/application"
  group  = module.deploy-kr-rg.kr_rg_name
  tags = {
    env      = terraform.workspace,
    owner    = var.owner
    division = var.division
    source   = var.source_system
  }
}

#Storage
module "deploy-kr-storage-core" {
  source           = "./module/storage/core/cluster/blob"
  group            = module.deploy-kr-rg.kr_rg_name
  location         = var.az-location[terraform.workspace]
  subnet           = module.deploy-kr-subnet-core.kr_subnet_id
  tier             = var.az-storage-tier[terraform.workspace]
  kind             = var.az-storage-kind
  replication      = var.az-storage-replication[terraform.workspace]
  allowip          = var.az-storage-allowrule[terraform.workspace]
  userPrincipal    = module.deploy-kr-host-usr_mang.kr_usr_mang_idn_principal_id
  servicePrincipal = module.deploy-kr-host-app_loc.kr_loc_sp_id

  tags = {
    env      = terraform.workspace,
    owner    = var.owner
    division = var.division
    source   = var.source_system
  }
}

module "deploy-kr-host-k8-adm" {
  source   = "./module/host/core/grpadm"
  group    = module.deploy-kr-rg.kr_rg_name
  location = var.az-location[terraform.workspace]
}

#K8 - core cluster deployment
module "deploy-kr-k8-cluster" {
  source        = "./module/k8cluster/core/create"
  group         = module.deploy-kr-rg.kr_rg_name
  location      = var.az-location[terraform.workspace]
  tenant        = var.AZ_TENNENT_ID
  subnet        = module.deploy-kr-subnet-core.kr_subnet_id
  adm           = module.deploy-kr-host-k8-adm.kr_aks_adm_id
  max_pods      = var.aks_max_pods[terraform.workspace]
  vm-size       = var.aks-vm-size[terraform.workspace]
  userManagedId = module.deploy-kr-host-usr_mang.kr_usr_mang_idn_id
  tags = {
    env      = terraform.workspace,
    owner    = var.owner
    division = var.division
    source   = var.source_system
  }
}




