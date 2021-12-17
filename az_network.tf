resource "azurerm_resource_group" "main" {
  name     = var.rg_name
  location = var.rg_location
  tags     = var.default_tags
}

resource "azurerm_virtual_network" "main" {
  name                = "demo-network"
  address_space       = ["10.0.0.0/16"]
  location            = azurerm_resource_group.main.location
  resource_group_name = azurerm_resource_group.main.name
  tags                = var.default_tags
}

resource "azurerm_subnet" "main" {
  name                 = "internal"
  resource_group_name  = azurerm_resource_group.main.name
  virtual_network_name = azurerm_virtual_network.main.name
  address_prefixes     = ["10.0.2.0/24"]
}

resource "azurerm_public_ip" "nix-vm-publicIP" {
  name                = "mywinvmpubIP"
  location            = azurerm_resource_group.main.location
  resource_group_name = azurerm_resource_group.main.name
  allocation_method   = "Dynamic"

  tags = var.default_tags
}

resource "azurerm_network_interface" "main_nix" {
  name                = "demo-lnxvm-nic"
  location            = azurerm_resource_group.main.location
  resource_group_name = azurerm_resource_group.main.name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.main.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.nix-vm-publicIP.id
  }
  tags = var.default_tags
}


resource "azurerm_network_security_group" "main_nix" {
  name                = "myNixNetworkSecurityGroup"
  location            = azurerm_resource_group.main.location
  resource_group_name = azurerm_resource_group.main.name

  security_rule {
    name                       = "SSH"
    priority                   = 1001
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "22"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }
  tags = var.default_tags
}

resource "azurerm_network_interface_security_group_association" "main_nix" {
  network_interface_id      = azurerm_network_interface.main_nix.id
  network_security_group_id = azurerm_network_security_group.main_nix.id
}



