variable "prefix" {
  default = "tfvmex"
}

variable "rg_name" {
  type    = string
  default = "rg-az-monitor-demo"
}

variable "rg_location" {
  type    = string
  default = "eastus"
}

variable "lnx_vm_name" {
  type    = string
  default = "demo-lnx-vm"
}

variable "default_tags" {
  type = map(any)
  default = {
    Environment = "Demo"
    Owner       = "Sachin"
    Project     = "az-monitor-demo"
  }
}

variable "vault_name" {
  type    = string
  default = "demo-az-monitor-vault"
}


variable "vault_secret_name" {
  type    = string
  default = "az-monitor-demo-vault-secret"
}
