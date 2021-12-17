
# When running this for the *first* time, these values for the backend do not exist.
# Comment out the below terraform scope, create the prerequisite resources and uncomment.
# Init to use the newly created backend. 
terraform {   
    backend "azurerm" {     
      subscription_id       = "1d8c7e6d-f154-408e-ba47-898c464fff0e" 
      resource_group_name   = "rg-sita-vm-creation-demo-remotes1"
      storage_account_name  = "sgsitavmcreationdemo1"
      container_name        = "sgsitavmcreationcontainer1" 
      key                   = "terraform_state/demo/azure_monitor_updated/terraform.tfstate" 
    } 
}

# Create a Resource Group for grouping all Stor Accounts for TFState Files
# resource "azurerm_resource_group" "rg-tfstate-core" {
#     name     = local.resource_group_name
#     location = local.location
#     tags     = local.default_tags
# }

# # Create a Storage Account for the Terraform State File
# resource "azurerm_storage_account" "sa-tfstate-core" {
#   depends_on                = [azurerm_resource_group.rg-tfstate-core]
#   name                      = local.storage_account_name
#   resource_group_name       = azurerm_resource_group.rg-tfstate-core.name
#   location                  = local.location
#   account_kind              = "StorageV2"
#   account_tier              = "Standard"
#   access_tier               = "Hot"
#   account_replication_type  = "LRS" # Move to GZRS for production-deployment
#   enable_https_traffic_only = true
#   tags                      = local.default_tags
# }

# # Create a Storage Container for the Core Infra State File
# resource "azurerm_storage_container" "sc-tfstate-core" {
#   depends_on            = [azurerm_storage_account.sa-tfstate-core]
#   storage_account_name  = azurerm_storage_account.sa-tfstate-core.name
#   name                  = local.container_name
# }