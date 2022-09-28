variable "azurem-disk-azuredisk" {
  type        = map(any)
  description = "The map of disk name and disk quota to be created"
  default     = { "db-data" : "5", "appdata" : "5" }
}

variable "azure_disk_pvc_namespace" {
  description = "The name of the namespace used to host the pvc"
  default     = "default"
}


