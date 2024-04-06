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



