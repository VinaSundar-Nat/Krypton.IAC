resource null_resource existing_registration {
  provisioner "local-exec" {
    command = <<EOT
      chmod a+x ${path.module}/script/resource-check.sh
      echo "null_resource executed."
      echo "client ${var.clientId} tennent ${var.tennentId}." >> /${path.module}/script/sensitive.log     
      ${path.module}/script/resource-check.sh "${var.clientId}" "${var.tennentId}" "${path.module}/script/krinfra.pem" "${var.app_name}" "${path.module}/response.txt" ${path.module}/log.txt 
    EOT
  }

  triggers = {
    always_run = "${timestamp()}"
  }  
}


