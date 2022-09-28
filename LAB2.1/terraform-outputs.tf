

output "database-vm-host" {
  value = azurerm_linux_virtual_machine.database.name
}

output "database-vm-privateIP" {
  value = azurerm_linux_virtual_machine.database.private_ip_address
}

output "database-vm-publicIP" {
  value = azurerm_linux_virtual_machine.database.public_ip_address
}

output "database-vm-admin_username" {
  value = azurerm_linux_virtual_machine.database.admin_username
}

output "database-vm-admin_password" {
  value     = azurerm_linux_virtual_machine.database.admin_password
  sensitive = true
}

