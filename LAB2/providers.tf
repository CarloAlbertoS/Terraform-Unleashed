terraform {
  required_providers {
    azurerm = {
      version = "3.4.0"
    }
    azuread = {
      version = "2.18.0"
    }
  }
}

provider "azurerm" {
  features {
    # USE THIS TO FORCE DISTRUCTION OF NON EMPTY RG
    #resource_group {
    #  prevent_deletion_if_contains_resources = false
    #}
  }
  subscription_id = var.azsubscriptionid
  client_id       = var.azclientid
  client_secret   = var.azclientsecret
  tenant_id       = var.aztenantid
}


provider "azuread" {
  client_id     = var.azclientid
  client_secret = var.azclientsecret
  tenant_id     = var.aztenantid

}

provider "random" {
}