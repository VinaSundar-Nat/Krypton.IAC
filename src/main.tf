# We strongly recommend using the required_providers block to set the
# Azure Provider source and version being used
terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "=3.0.0"
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

#Storage
module "deploy-kr-storage-core" {
  source      = "./module/storage/core/cluster/blob"
  group       = module.deploy-kr-rg.kr_rg_name
  location    = var.az-location[terraform.workspace]
  subnet      = module.deploy-kr-subnet-core.kr_subnet_id
  tier        = var.az-storage-tier[terraform.workspace]
  kind        = var.az-storage-kind
  replication = var.az-storage-replication[terraform.workspace]
  tags = {
    env      = terraform.workspace,
    owner    = var.owner
    division = var.division
    source   = var.source_system
  }
}



