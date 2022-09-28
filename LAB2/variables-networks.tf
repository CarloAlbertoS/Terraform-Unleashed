variable "vnet_cidr" {
  description = "Range of IP of the VNet where to create the subnets for the AKS node pools"
  default     = ["10.0.0.0/16"]
}

variable "subnets_cidr_database" {
  description = "Range of IP of the VNet where to create the subnets for the AKS node pools"
  default     = ["10.0.2.0/24"]
}

variable "subnets_cidr_webapp" {
  description = "Range of IP of the VNet where to create the subnets for the AKS node pools"
  default     = ["10.0.3.0/24"]
}
