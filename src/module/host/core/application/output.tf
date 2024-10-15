output "kr_loc_app_id" {
  value = azuread_application.kr-loc-dev-app[0].id
}

output "kr_loc_sp_id" {
  value = azuread_service_principal.kr_loc_sp[0].id
}