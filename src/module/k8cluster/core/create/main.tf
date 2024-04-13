locals {
  cluster = "${join("_",["kr","core",tostring(terraform.workspace),"vertical","cluster"])}"
  np = "${join("0",["krc",tostring(terraform.workspace)])}"
}

resource azurerm_kubernetes_cluster kr-k8-cluster {
  name                = local.cluster
  location            = var.location
  resource_group_name = var.group
  dns_prefix          = var.dnsprefix
  kubernetes_version  = data.azurerm_kubernetes_service_versions.aks.latest_version
  

  default_node_pool {
    name                 = local.np 
    orchestrator_version = data.azurerm_kubernetes_service_versions.aks.latest_version
    node_count           = var.node-count
    vm_size              = var.vm-size
    vnet_subnet_id       = var.subnet  
    //os_disk_size_gb      = 10
    //type                 = "VirtualMachineScaleSets"
     node_labels = {
      "type"          = "system"
      "env"           = tostring(terraform.workspace)
      "os"            = "linux"
      "vertical"      = "core-api"
    }
    tags = {
      "type"          = "system"
      "env"           = tostring(terraform.workspace)
      "os"            = "linux"
      "vertical"      = "core-api"
    } 
  }

  identity {
    type = "SystemAssigned"
  }

  azure_active_directory_role_based_access_control {
    tenant_id              = var.tenant
    managed                = true
    admin_group_object_ids = [var.adm]  
  }

  network_profile {
    load_balancer_sku = var.lb-sku
    network_plugin = var.plugin
    service_cidr   = var.service-cidr
    //pod_cidrs = [var.service-cidr]
    dns_service_ip = var.dns-svc-ip
  }

  tags = var.tags
}

