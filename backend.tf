terraform {   
    backend "azurerm" {     
      subscription_id       = "1d8c7e6d-f154-408e-ba47-898c464fff0e" 
      resource_group_name   = "rg-sita-vm-creation-demo-remotes1"
      storage_account_name  = "sgsitavmcreationdemo1"
      container_name        = "sgsitavmcreationcontainer1" 
      key                   = "terraform_state/demo/azure_monitor_updated/terraform.tfstate" 
    } 
}
