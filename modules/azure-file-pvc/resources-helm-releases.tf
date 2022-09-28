resource "helm_release" "azure-file-pvc" {
  name  = "azure-file-pvc-${var.sharename}"
  chart = "azure-file-pvc"
  repository = "../modules/azure-file-pvc"
  timeout = 600

  set {
    name  = "global.namespace"
    value = var.namespace
  }
  set {
    name  = "azurefile.storage.sharename"
    value = var.sharename
  }
  set {
    name  = "azurefile.storage.key"
    value = var.storagekey
  }
  set {
    name  = "azurefile.storage.accountname"
    value = var.storageaccountname
  }
  set {
    name  = "azurefile.storage.quota"
    value = var.storagequota
  }
}
