variable "namespace" {
  description = "The name of the namespace used to host the pvc"
}

variable "diskname" {
  description = "Name of the azure disk used for the pvc"
}
variable "storagequota" {
  description = "Size of the quota for the share space"
}