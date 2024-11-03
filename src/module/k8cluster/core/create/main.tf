locals {
  cluster = "${join("_",["kr","core",tostring(terraform.workspace),"vertical","cluster"])}"
  np = "${join("0",["krc",tostring(terraform.workspace)])}"
  spotpool = "${join("0",["kr",tostring(terraform.workspace),"sp"])}"
}

resource azurerm_kubernetes_cluster kr-k8-cluster {
  count               = var.create_cluster ? 1 : 0
  name                = local.cluster
  location            = var.location
  resource_group_name = var.group
  dns_prefix          = var.dnsprefix
  kubernetes_version  = data.azurerm_kubernetes_service_versions.aks.latest_version
  

  default_node_pool {
    name                 = local.np 
    orchestrator_version = data.azurerm_kubernetes_service_versions.aks.latest_version
    node_count           = 1
    vm_size              = var.vm-size
    vnet_subnet_id       = var.subnet
     node_labels = {
      "type"          = "system"
      "env"           = tostring(terraform.workspace)
      "os"            = "linux"
      "vertical"      = "core-ai"
    }
    tags = var.tags
  }

  identity {
    type = "UserAssigned"
    identity_ids = [var.userManagedId]
  }

  azure_active_directory_role_based_access_control {
    tenant_id              = var.tenant
    managed                = true
    admin_group_object_ids = [var.adm] 
    azure_rbac_enabled     = true 
  }

  network_profile {
    load_balancer_sku = var.lb-sku
    network_plugin = var.plugin
    service_cidr   = var.service-cidr
    pod_cidrs = [var.pod-cidr]
    dns_service_ip = var.dns-svc-ip
  }

  tags = var.tags
}

resource "azurerm_kubernetes_cluster_node_pool" "spot_pool" {
  count               = var.create_cluster ? 1 : 0
  name                = local.spotpool
  kubernetes_cluster_id = azurerm_kubernetes_cluster.kr-k8-cluster[0].id
  vm_size             = var.vm-size
  node_count          = var.node-count
  priority            = "Spot"
  eviction_policy     = "Delete"
  spot_max_price      = -1
  max_pods            = var.max_pods
  enable_auto_scaling = true
  min_count           = 1
  max_count           = 3
  vnet_subnet_id      = var.subnet

  tags = var.tags
}

