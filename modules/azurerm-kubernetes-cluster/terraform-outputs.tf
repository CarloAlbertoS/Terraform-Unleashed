output "id" {
  value = azurerm_kubernetes_cluster.aks.id
}

output "kube_config" {
  value     = azurerm_kubernetes_cluster.aks.kube_config_raw
  sensitive = true
}

output "client_key" {
  value     = azurerm_kubernetes_cluster.aks.kube_admin_config.0.client_key
  sensitive = true
}

output "client_certificate" {
  value     = azurerm_kubernetes_cluster.aks.kube_admin_config.0.client_certificate
  sensitive = true
}

output "cluster_ca_certificate" {
  value     = azurerm_kubernetes_cluster.aks.kube_admin_config.0.cluster_ca_certificate
  sensitive = true
}

output "host" {
  value = azurerm_kubernetes_cluster.aks.kube_admin_config.0.host
}

output "aksusername" {
  value     = azurerm_kubernetes_cluster.aks.kube_admin_config.0.username
  sensitive = true
}

output "akspassword" {
  value     = azurerm_kubernetes_cluster.aks.kube_admin_config.0.password
  sensitive = true
}

output "aksname" {
  value = azurerm_kubernetes_cluster.aks.name
}

output "aksreourcegroup" {
  value = azurerm_kubernetes_cluster.aks.resource_group_name
}

output "node_resource_group" {
  value = azurerm_kubernetes_cluster.aks.node_resource_group
}

output "storage_account_name" {
  value = azurerm_storage_account.servicestorage.name
}

output "storage_account_key" {
  value     = azurerm_storage_account.servicestorage.primary_access_key
  sensitive = true
}