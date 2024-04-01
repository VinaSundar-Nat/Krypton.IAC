output "kr_rg_name" {
  value = module.deploy-kr-rg.kr_rg_name
}

output "kr-vnet-core-details" {
  value = format("name : %s id %s", module.deploy-kr-vnet-core.kr_vnet_name, module.deploy-kr-vnet-core.kr_vnet_id)
}