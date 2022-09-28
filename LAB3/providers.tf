terraform {
  required_providers {
    azurerm = {
      version = "2.97.0"
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

provider "kubernetes" {
  version = "2.8.0"
     host                   = module.kubernetes.host
  username               = module.kubernetes.aksusername
  password               = module.kubernetes.akspassword
  client_certificate     = base64decode(module.kubernetes.client_certificate)
  client_key             = base64decode(module.kubernetes.client_key)
  cluster_ca_certificate = base64decode(module.kubernetes.cluster_ca_certificate)


  /* in case of problems replace with this:
  config_path    = "~/.kube/config"
  config_context = "aks-ji-demo-we-admin"*/
}

provider "helm" {
    kubernetes {
     host                   = module.kubernetes.host
    username               = module.kubernetes.aksusername
    password               = module.kubernetes.akspassword
    client_certificate     = base64decode(module.kubernetes.client_certificate)
    client_key             = base64decode(module.kubernetes.client_key)
    cluster_ca_certificate = base64decode(module.kubernetes.cluster_ca_certificate)
}

  /* in case of problems replace with this:
  kubernetes {
    config_path    = "~/.kube/config"
    config_context = "aks-ji-demo-we-admin"
  }*/
}
