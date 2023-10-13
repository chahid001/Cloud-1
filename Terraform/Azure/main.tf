terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "=3.0.0"
    }
  }
}

provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "inp" {
  name     = "inception"
  location = "" //still
  tags = {
    enviroment = "deployement"
  }
}

resource "azurerm_virtual_network" "inp_vn" {
  name                = "inception_vnet"
  resource_group_name = azurerm_resource_group.inp.name
  location            = azurerm_resource_group.inp.location
  address_space       = ["192.56.0.0/16"]

  tags = {
    enviroment = "deployement"
  }
}

resource "azurerm_subnet" "inp_s" {
  name                 = "inception_subnet"
  resource_group_name  = azurerm_resource_group.inp.name
  virtual_network_name = azurerm_resource_group.inp_vn.name
  address_prefixes     = ["192.56.1.0/24"]
}

resource "azurerm_network_security_group" "inp_sg" {
  name                = "inception_sg"
  resource_group_name = azurerm_resource_group.inp.name
  location            = azurerm_resource_group.inp.location

  tags = {
    enviroment = "deployement"
  }

  security_rule {
    name                       = "inp_sgr"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "*"
    source_address_prefix      = "*"
    destination_address_prefix = "*"

  }
}

resource "azurerm_subnet_network_security_group_association" "inp_snsga" {
  subnet_id                 = azurerm_subnet.inp_s.id
  network_security_group_id = azurerm_network_security_group.inp_sg.id
}

resource "azurerm_public_ip" "inp_pip" {
  name                = "inception_pip"
  location            = azurerm_resource_group.inp.location
  resource_group_name = azurerm_resource_group.inp.name
  allocation_method   = Dynamic

  tags = {
    enviroment = "deployement"
  }
}

resource "azurerm_network_interface" "inp_ni" {
  name                = "inception_ni"
  location            = azurerm_resource_group.inp.location
  resource_group_name = azurerm_resource_group.inp.name
  ip_configuration {
    name                          = "network_ip"
    subnet_id                     = azurerm_subnet.inp_s.id
    private_ip_address_allocation = Dynamic
    public_ip_address_id          = azurerm_public_ip.inp_pip.id
  }

  tags = {
    enviroment = "deployement"
  }
}

resource "azurerm_linux_virtual_machine" "inception_server" {
  name = "inception_linux_server"
  location = azurerm_resource_group.inp.location
  resource_group_name = azurerm_resource_group.inp.name
  admin_username = "adminuser"
  network_interface_ids = azurerm_network_interface.inp_ni.id
  size = "Standard_F2"
  custom_data = filebase64("customdata.tpl")
  admin_ssh_key {
    username = "adminuser"
    public_key = "" //still
  }

  os_disk { 
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-focal"
    sku       = "20_04-lts"
    version   = "latest"
  }
}

data "azurerm_public_ip" "inp_pub_ip" {
  name = "inception_public_ip"
  resource_group_name = azurerm_resource_group.inp.name
}

output "pub_ip" {
  value = "${azurerm_linux_virtual_machine.inception_server.name}: ${data.azurerm_public_ip.inp_pub_ip.ip_address}"
}
