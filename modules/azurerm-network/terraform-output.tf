
output "vnet_name" {
  value = azurerm_virtual_network.main-vnet.name
}

output "database_subnet_id" {
  value = azurerm_subnet.subnets.0.id
}

output "webapp_subnet_id" {
  value = azurerm_subnet.subnets.1.id
}