# K8s cluster
resource "azurerm_kubernetes_cluster" "aks" {
  name                            = "aks-${var.prefix}-${var.env}-${var.locationcode}"
  location                        = var.location
  resource_group_name             = azurerm_resource_group.k8s.name
  dns_prefix                      = "aks-${var.prefix}-${var.env}-${var.locationcode}"
  api_server_authorized_ip_ranges = var.api_server_authorized_ip_ranges
  kubernetes_version              = var.orchestrator_version
  node_resource_group             = "rg-aks-${var.prefix}-${var.env}-${var.locationcode}-nodes"

  default_node_pool {
    name                  = var.default_node_pool_name
    type                  = "VirtualMachineScaleSets"
    node_count            = var.node_count
    min_count             = var.node_min_count
    max_count             = var.node_max_count
    vm_size               = var.vm_size
    os_disk_size_gb       = var.disk_size
    max_pods              = var.max_pods
    availability_zones    = var.availability_zones
    enable_auto_scaling   = var.enable_auto_scaling
    enable_node_public_ip = var.enable_node_public_ip
    orchestrator_version  = var.orchestrator_version
    vnet_subnet_id        = var.subnet_id
  }
  service_principal {
    client_id     = var.aks_sp_application_id
    client_secret = var.aks_sp_pwd_secret
  }

  role_based_access_control {
    enabled = true
    azure_active_directory {
      managed = true
      #admin_group_object_ids = ["015e8b99-fc9d-47e4-9284-4ed29bf290e0"]
      #admin_group_object_ids = var.admin_group_objects_ids
    }
  }
  network_profile {
    network_plugin = var.network_plugin
    #pod_cidr = var.pod_cidr
    service_cidr       = var.service_cidr
    docker_bridge_cidr = var.docker_bridge_cidr
    dns_service_ip     = var.dns_service_ip
  }
  auto_scaler_profile {
    balance_similar_node_groups      = var.balance_similar_node_groups
    max_graceful_termination_sec     = var.max_graceful_termination_sec
    scale_down_delay_after_add       = var.scale_down_delay_after_add
    scale_down_unneeded              = var.scale_down_unneeded
    scan_interval                    = var.scan_interval
    scale_down_utilization_threshold = var.scale_down_utilization_threshold
  }
  tags = {
    project = var.prefix
    env     = var.env
  }

}


