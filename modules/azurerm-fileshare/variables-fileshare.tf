variable "azureshares" {
  type        = map(any)
  description = "The map of share name and share quota to be created"
}

variable "storage_account_name" {
  description = "The name of the storage account to be used for the creation of azure file share"
}

