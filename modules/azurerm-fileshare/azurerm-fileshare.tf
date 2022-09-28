resource "azurerm_storage_share" "azurefile" {
  for_each             = var.azureshares
  name                 = each.key
  storage_account_name = var.storage_account_name
  quota                = each.value

}