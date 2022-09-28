
variable "user" {
  description = "name of the User for poste terraform course"
}


variable "environment" {
  description = "name of the User for poste terraform course"
}

variable "prefix" {
  description = "name of the User for poste terraform course"
}

variable "location" {
  description = "The Azure Region in which all resources in this example should be provisioned (used to identify actual Azure region for resource provisioning)"
  default     = "North Europe"
}

variable "locationcode" {
  description = "The Azure Region in which all resources in this example should be provisioned (two letters version used on names)"
  default     = "ne"
}



variable "override_special" {
  description = "Supply your own list of special characters to use for string generation"
  default     = "_.!"
}
