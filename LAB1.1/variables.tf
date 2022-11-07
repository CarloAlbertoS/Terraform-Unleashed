client_secret                 = "E1t8Q~wNq3aMGM1xZx1iTdbqSOg5TsfrlVaV_bl_"
prefix                        = "Lab99"
training_resource_group_location = "North Europe"
environment                   = "training"

tag_training2 = { "environment" : "staging", "user" : "lab00" }

variable "client_secret" {
  description = "value of the Azure SP client secret"

}

variable "prefix" {
  description = "Unique identifier for installation"

}

variable "training_resource_group_location" {
  description = "Location for primary resource group"
  default = "North Europe"

}

variable "environment" {
  default = "North Europe"

}
