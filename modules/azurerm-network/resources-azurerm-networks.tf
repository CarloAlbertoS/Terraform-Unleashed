# Network used to host the AKS nodes
resource "azurerm_virtual_network" "main-vnet" {
  name                = "${var.prefix}-${var.env}-network"
  address_space       = var.vnet_cidr
  location            = var.location
  resource_group_name = var.resource_group_name
    tags = var.tags
}

resource "azurerm_subnet" "subnets" {
  count                = "${length(var.subnets_cidr)}"
  name                 = "${var.prefix}-${var.env}-${lookup(element(var.subnets_cidr , count.index), "name")}"
  resource_group_name  = var.resource_group_name
  virtual_network_name = azurerm_virtual_network.main-vnet.name
  address_prefixes     = "${lookup(element(var.subnets_cidr, count.index), "ip")}"
}