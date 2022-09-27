variable "client_secret" {
}

provider "azurerm" {
  features {
    resource_group {
      prevent_deletion_if_contains_resources = false
    }
  }
  subscription_id = "fce6ec9b-1a97-4250-8ca9-6ea5cf77fe6c"
  client_id       = "c2e6638d-61d7-4f66-9ae4-ecb579a3789e"
  client_secret   = var.client_secret
  tenant_id       = "a84c2bdc-6bba-49a2-a40f-8e993440da8e"
}

resource "azurerm_resource_group" "poste-tf" {
  name     = "poste-tf-resources"
  location = "North Europe"
}

resource "azurerm_virtual_network" "poste-tf" {
  name                = "poste-tf-network"
  address_space       = ["10.0.0.0/16"]
  location            = azurerm_resource_group.poste-tf.location
  resource_group_name = azurerm_resource_group.poste-tf.name
}

resource "azurerm_subnet" "database" {
  name                 = "database"
  resource_group_name  = azurerm_resource_group.poste-tf.name
  virtual_network_name = azurerm_virtual_network.poste-tf.name
  address_prefixes     = ["10.0.2.0/24"]
}


resource "azurerm_network_interface" "main" {
  name                = "poste-tf-nic"
  location            = azurerm_resource_group.poste-tf.location
  resource_group_name = azurerm_resource_group.poste-tf.name

  ip_configuration {
    name                          = "testconfiguration1"
    subnet_id                     = azurerm_subnet.database.id
    private_ip_address_allocation = "Dynamic"
  }
}

resource "azurerm_virtual_machine" "database" {
  name                  = "poste-tf-vm"
  location              = azurerm_resource_group.poste-tf.location
  resource_group_name   = azurerm_resource_group.poste-tf.name
  network_interface_ids = [azurerm_network_interface.main.id]
  vm_size               = "Standard_B1s"

  # Uncomment this line to delete the OS disk automatically when deleting the VM
  # delete_os_disk_on_termination = true

  # Uncomment this line to delete the data disks automatically when deleting the VM
  # delete_data_disks_on_termination = true

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
  tags = {
    environment = "staging"
  }
}