variable "namespace" {
  description = "The name of the namespace used to host the pvc"
}

variable "sharename" {
  description = "Name of the azure file share used for the pvc"
}

variable "storagekey" {
  description = "Value of the azure file share storage key"
}

variable "storageaccountname" {
  description = "Name of the the azure file share storage account"
}

variable "storagequota" {
  description = "Size of the quota for the share space"
}