variable "azure_file_pvc_namespace" {
  description = "The name of the namespace used to host the pvc"
  default     = "default"
}

variable "azure_file_pvc_sharename" {
  description = "Name of the azure file share used for the pvc"
  default     = "mainstorage"
}

variable "azure_file_pvc_storagequota" {
  description = "Size of the quota for the share space"
  default     = "5Gi"
}