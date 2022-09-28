variable "vnet_cidr" {
  description = "Range of IP of the VNet where to create the subnets for the AKS node pools"
}

variable "subnets_cidr" {
  description = "A map of range of IP of the subnet for the AKS node pools"
}

variable "resource_group_name" {
  description = "The name of the existing Resource Group"
}
