

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



