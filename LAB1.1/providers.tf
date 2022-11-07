provider "azurerm" {
  features {
    # USE THIS TO FORCE DISTRUCTION OF NON EMPTY RG
    #resource_group {
    #  prevent_deletion_if_contains_resources = false
    #}
  }
  subscription_id = "fce6ec9b-1a97-4250-8ca9-6ea5cf77fe6c"
  client_id       = "63b9461d-51b3-4554-9ffe-95038f4e592c"
  client_secret   = var.client_secret
  tenant_id       = "a84c2bdc-6bba-49a2-a40f-8e993440da8e"
}