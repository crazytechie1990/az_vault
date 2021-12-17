resource "random_password" "vm-admin-password" {
  length           = 16
  special          = true
  override_special = "_%@"
  upper            = true
}

resource "azurerm_key_vault_secret" "vm-admin-password" {
  name         = "vm-admin-password"
  value        = random_password.vm-admin-password.result
  key_vault_id = azurerm_key_vault.vault.id
  depends_on   = [azurerm_key_vault.vault]
}

resource "azurerm_linux_virtual_machine" "main" {
  name                            = var.lnx_vm_name
  resource_group_name             = azurerm_resource_group.main.name
  location                        = azurerm_resource_group.main.location
  computer_name                   = var.lnx_vm_name
  size                            = "Standard_F2"
  admin_username                  = "adminuser"
  admin_password                  = sensitive(random_password.vm-admin-password.result)
  disable_password_authentication = false

  network_interface_ids = [
    azurerm_network_interface.main_nix.id
  ]

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "16.04-LTS"
    version   = "latest"
  }
  depends_on = [
    azurerm_resource_group.main, azurerm_network_interface.main_nix
  ]
  tags = var.default_tags
}


data "azurerm_key_vault_secret" "vm_admin_pass" {
  name         = azurerm_key_vault_secret.vm-admin-password.name
  key_vault_id = azurerm_key_vault.vault.id
}