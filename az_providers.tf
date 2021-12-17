# Provider block for Azure IMS Terraform Remote State (POC) 

terraform {
  required_providers {
    azurerm = {
      source = "hashicorp/azurerm"
      version = "2.89.0"
    }
  }
}

provider "azurerm" {
  # Configuration options
  features{
    az login -u $username -p $password
  }
} 

