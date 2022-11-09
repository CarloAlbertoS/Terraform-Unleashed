resource "azurerm_managed_disk" "azure-disk" {
  name                 = var.diskname
  location             = var.location
  resource_group_name  = "rg-aks-${var.prefix}-${var.env}-${var.locationcode}-nodes"
  storage_account_type = "Premium_LRS"
  create_option        = "Empty"
  disk_size_gb         = var.storagequota

  tags = {
    project = var.prefix
    env     = var.env
  }
}