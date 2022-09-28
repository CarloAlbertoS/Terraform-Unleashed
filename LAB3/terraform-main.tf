
#################### AZUREAD BLOCK ####################

data "azuread_user" "lab-user" {
  user_principal_name = var.user
}

data "azuread_group" "azure-group" {
  display_name     = "GlobalContributors"
  security_enabled = true
}

resource "azuread_group_member" "lab-assignment" {
  group_object_id  = data.azuread_group.azure-group.id
  member_object_id = data.azuread_user.lab-user.id
}
#################### END OF AZUREAD BLOCK ####################





module "resource-groups" {
  # Module reference via path
  source = "../modules/azurerm-resource-group"
  # values for module variables
  resource_groups = var.resource_groups
  prefix          = var.prefix
  env             = var.environment
  location        = var.location
  tags            = local.tags
}

module "network" {
  # Module reference via path
  source = "../modules/azurerm-network"
  # values for module variables
  prefix              = var.prefix
  env                 = var.environment
  resource_group_name = module.resource-groups.resources_resource_group_name
  location            = var.location
  vnet_cidr           = var.vnet_cidr
  subnets_cidr        = var.subnets_cidr
  tags                = local.tags
}



module "kubernetes" {
  # Module reference via path
  source = "../modules/azurerm-kubernetes-cluster"
  # values for module variables
  prefix                = var.prefix
  env                   = var.environment
  locationcode          = var.locationcode
  location              = var.location
  azsubscriptionid      = var.azsubscriptionid
  tenantdomain          = var.tenantdomain
  node_count            = var.node_count
  node_min_count        = var.node_min_count
  node_max_count        = var.node_max_count
  vm_size               = var.vm_size
  disk_size             = var.disk_size
  max_pods              = var.max_pods
  enable_auto_scaling   = var.enable_auto_scaling
  enable_node_public_ip = var.enable_node_public_ip
  orchestrator_version  = var.orchestrator_version
  network_plugin        = var.network_plugin
  #pod_cidr                = var.pod_cidr
  service_cidr                     = var.service_cidr
  docker_bridge_cidr               = var.docker_bridge_cidr
  dns_service_ip                   = var.dns_service_ip
  subnet_id                        = module.network.aks_subnet_id
  availability_zones               = var.aks_availability_zones
  admin_group_objects_ids          = var.admin_group_objects_ids
  api_server_authorized_ip_ranges  = var.api_server_authorized_ip_ranges
  balance_similar_node_groups      = var.balance_similar_node_groups
  max_graceful_termination_sec     = var.max_graceful_termination_sec
  scale_down_delay_after_add       = var.scale_down_delay_after_add
  scale_down_unneeded              = var.scale_down_unneeded
  scan_interval                    = var.scan_interval
  scale_down_utilization_threshold = var.scale_down_utilization_threshold
  default_node_pool_name           = var.default_node_pool_name
  aks_sp_application_id            = var.aks_sp_application_id
  aks_sp_pwd_secret                = var.aks_sp_pwd_secret

  depends_on = [
    module.network
  ]

}

module "ingress" {
  # Module reference via path
  source = "../modules/ingress-controller"
  # values for module variables
  prefix                 = var.prefix
  env                    = var.environment
  locationcode           = var.locationcode
  location               = var.location
  aksnoderg              = module.kubernetes.node_resource_group
  controllerReplicaCount = var.controllerReplicaCount

  depends_on = [
    module.kubernetes
  ]

}

# module "cert-manager" {
#   # Module reference via path
#   source          = "../modules/cert-manager"
#   namespace       = var.certmanager-namespace
#   emailproduction = var.certmanager-emailproduction
#   emailstaging    = var.certmanager-emailstaging

#   depends_on = [
#     module.ingress
#   ]

# }

module "azure_file_share" {
  # Module reference via path
  source               = "../modules/azurerm-fileshare"
  azureshares          = var.azurerm-fileshare-azureshares
  storage_account_name = "postetf"
  location                        = module.resource-groups.resources_resource_group_location
  prefix              = var.prefix
  env                 = var.environment

  depends_on = [
    module.kubernetes
  ]

}

module "azure-file-pvc" {
  # Module reference via path
  for_each           = var.azurerm-fileshare-azureshares
  source             = "../modules/azure-file-pvc"
  namespace          = var.azure_file_pvc_namespace
  sharename          = each.key
  storagekey         = module.kubernetes.storage_account_key
  storagequota       = each.value
  storageaccountname = module.kubernetes.storage_account_name

  depends_on = [
    module.kubernetes,
    module.azure_file_share
  ]
}

module "azure-disk-pvc" {
  # Module reference via path
  for_each     = var.azurem-disk-azuredisk
  source       = "../modules/azure-disk-pvc"
  namespace    = var.azure_disk_pvc_namespace
  diskname     = each.key
  storagequota = each.value
  prefix       = var.prefix
  env          = var.environment
  locationcode = var.locationcode
  location     = var.location

  depends_on = [
    module.kubernetes,
    module.azure_file_share
  ]
}

