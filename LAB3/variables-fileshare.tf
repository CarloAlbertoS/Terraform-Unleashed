variable "azurerm-fileshare-azureshares" {
  type        = map(any)
  description = "The map of share name and share quota to be created"
  default     = { "userdata" : "5", "logs" : "5" }
}


