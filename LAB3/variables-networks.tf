variable "vnet_cidr" {
  description = "Range of IP of the VNet where to create the subnets for the AKS node pools"
  default     = ["10.0.0.0/16"]
}

variable "subnets_cidr_database" {
  description = "Range of IP of the VNet where to create the subnets for the AKS node pools"
  default     = ["10.0.2.0/16"]
}

variable "subnets_cidr_webapp" {
  description = "Range of IP of the VNet where to create the subnets for the AKS node pools"
  default     = ["10.0.2.0/16"]
}

variable "subnets_cidr" {
  description = "Range of IP of the subnet for the AKS node pools"
  default = [
    {
      ip   = ["10.0.2.0/24"]
      name = "aks"
    },
    {
      ip   = ["10.0.4.0/24"]
      name = "webapp"
    }
  ]
}