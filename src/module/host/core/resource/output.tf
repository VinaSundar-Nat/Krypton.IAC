output "kr_loc_app_id" {
  value = jsondecode(trimspace(data.local_file.existing_app_dets.content))["appId"]
}


output "kr_loc_sp_id" {
  value = jsondecode(trimspace(data.local_file.existing_app_dets.content))["spId"]
}