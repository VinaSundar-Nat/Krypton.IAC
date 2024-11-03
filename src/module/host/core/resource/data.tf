data "azuread_client_config" "current" {}

data local_file existing_app_dets {
  depends_on = [ null_resource.existing_registration]
  filename =  "${path.module}/response.txt"
}