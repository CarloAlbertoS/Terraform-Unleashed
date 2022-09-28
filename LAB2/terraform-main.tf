
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



resource "azurerm_resource_group" "main-rg" {
  name     = "${local.alumni_id}-resources"
  location = var.location
  tags     = local.tags
}


resource "azurerm_virtual_network" "main-vnet" {
  name                = "${local.alumni_id}-network"
  address_space       = var.vnet_cidr
  location            = azurerm_resource_group.main-rg.location
  resource_group_name = azurerm_resource_group.main-rg.name
  tags                = local.tags
}

resource "azurerm_subnet" "database" {
  name                 = "${local.alumni_id}-database"
  resource_group_name  = azurerm_resource_group.main-rg.name
  virtual_network_name = azurerm_virtual_network.main-vnet.name
  address_prefixes     = var.subnets_cidr_database

}

resource "azurerm_subnet" "webapp" {
  name                 = "${local.alumni_id}-webapp"
  resource_group_name  = azurerm_resource_group.main-rg.name
  virtual_network_name = azurerm_virtual_network.main-vnet.name
  address_prefixes     = var.subnets_cidr_webapp
}


resource "azurerm_network_interface" "eth0" {
  name                = "${local.alumni_id}-nic"
  location            = azurerm_resource_group.main-rg.location
  resource_group_name = azurerm_resource_group.main-rg.name

  ip_configuration {
    name                          = "${local.alumni_id}-internalip"
    subnet_id                     = azurerm_subnet.database.id
    private_ip_address_allocation = "Dynamic"
  }
  tags = local.tags
}

resource "random_password" "vm-admin" {
  length           = 10
  special          = true
  override_special = var.override_special
}

resource "azurerm_linux_virtual_machine" "database" {
  name                  = "${local.alumni_id}-db"
  location              = azurerm_resource_group.main-rg.location
  resource_group_name   = azurerm_resource_group.main-rg.name
  network_interface_ids = [azurerm_network_interface.eth0.id]
  size                  = var.vm_size
  admin_username        = "${local.alumni_id}-admin"
  admin_password        = random_password.vm-admin.result
  disable_password_authentication = false

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = var.vm_os_sku
    version   = "latest"
  }
  tags = local.tags
}


