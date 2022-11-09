resource "helm_release" "azure-disk-pvc" {
  name       = "azure-disk-pvc-${var.diskname}"
  chart      = "azure-disk-pvc"
  repository = "../modules/azure-disk-pvc"
  timeout    = 600

  set {
    name  = "global.namespace"
    value = var.namespace
  }
  set {
    name  = "azuredisk.storage.diskname"
    value = var.diskname
  }
  set {
    name  = "azuredisk.storage.quota"
    value = var.storagequota
  }
  set {
    name  = "azuredisk.storage.diskuri"
    value = azurerm_managed_disk.azure-disk.id
  }
}
