resource "azurerm_resource_group" "main-rg" {
  count    = length(var.resource_groups)
  name     = "${var.prefix}-${var.env}-${lookup(element(var.resource_groups, count.index), "name")}"
  location = var.location
  tags     = var.tags
}