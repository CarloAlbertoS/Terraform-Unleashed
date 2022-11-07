locals {
  alumni_id = "${var.course}-${var.prefix}"
  tag_training = {
    "environment" = "${var.environment}"
    "user"        = "${var.prefix}"
  }
}


resource "azurerm_resource_group" "training-tf" {
  name     = "${local.alumni_id}-resources"
  location = var.training_resource_group_location
  tags     = var.tag_training
}

resource "azurerm_virtual_network" "training-tf" {
  name                = "${local.alumni_id}-network"
  address_space       = ["10.0.0.0/16"]
  location            = azurerm_resource_group.training-tf.location
  resource_group_name = azurerm_resource_group.training-tf.name
  tags                = var.tag_training
}

resource "azurerm_subnet" "database" {
  name                 = "${local.alumni_id}-database"
  resource_group_name  = azurerm_resource_group.training-tf.name
  virtual_network_name = azurerm_virtual_network.training-tf.name
  address_prefixes     = ["10.0.2.0/24"]

}

resource "azurerm_subnet" "webapp" {
  name                 = "${local.alumni_id}-webapp"
  resource_group_name  = azurerm_resource_group.training-tf.name
  virtual_network_name = azurerm_virtual_network.training-tf.name
  address_prefixes     = ["10.0.4.0/24"]
}


resource "azurerm_network_interface" "main" {
  name                = "${local.alumni_id}-nic"
  location            = azurerm_resource_group.training-tf.location
  resource_group_name = azurerm_resource_group.training-tf.name

  ip_configuration {
    name                          = "testconfiguration1"
    subnet_id                     = azurerm_subnet.database.id
    private_ip_address_allocation = "Dynamic"
  }
  tags = var.tag_training
}



resource "azurerm_virtual_machine" "database" {
  name                  = "${local.alumni_id}-vm"
  location              = azurerm_resource_group.training-tf.location
  resource_group_name   = azurerm_resource_group.training-tf.name
  network_interface_ids = [azurerm_network_interface.main.id]
  vm_size               = "Standard_B1s"

  # Uncomment this line to delete the OS disk automatically when deleting the VM
  delete_os_disk_on_termination = true

  # Uncomment this line to delete the data disks automatically when deleting the VM
  delete_data_disks_on_termination = true

  storage_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "18.04-LTS"
    version   = "latest"
  }
  storage_os_disk {
    name              = "myosdisk1"
    caching           = "ReadWrite"
    create_option     = "FromImage"
    managed_disk_type = "Standard_LRS"

  }
  os_profile {
    computer_name  = "hostname"
    admin_username = "testadmin"
    admin_password = "Password1234!"
  }
  os_profile_linux_config {
    disable_password_authentication = false
  }
  tags = var.tag_training
}