#secure - user managed identity

module "deploy-kr-usr-mang-idn" {
  source   = "./module/secure/core"
  group    = module.deploy-kr-rg.kr_rg_name
  location = var.az-location[terraform.workspace]
}