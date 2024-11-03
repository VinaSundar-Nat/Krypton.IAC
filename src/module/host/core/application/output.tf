output "kr_loc_app_id" {
  value = length(azuread_application.kr-loc-dev-app) > 0 ? azuread_application.kr-loc-dev-app[0].id  : var.ex_app_id
}


output "kr_loc_sp_id" {
  value = length(azuread_service_principal.kr_loc_sp) > 0 ? azuread_service_principal.kr_loc_sp[0].id : var.ex_sp_id
}