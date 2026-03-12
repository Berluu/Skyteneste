# AK1

terraform {
  required_providers {
    azurerm = {
      source = "hashicorp/azurerm"
      version = "4.62.1"
    }
  }
}

provider "azurerm" {
  features {}
  subscription_id = "340ce909-e132-4535-abbd-21f5b5f772da"
}

# Opprette resourcegroup
resource "azurerm_resource_group" "res_group_AK1" {
  name     = "AK1_ressursgruppe"
  location = "Norway East"
}

# Lage virtuelt nettverk
resource "azurerm_virtual_network" "vnet_AK1" {
  name                = "AK1_net"
  location            = azurerm_resource_group.res_group_AK1.location
  resource_group_name = azurerm_resource_group.res_group_AK1.name
  address_space       = ["172.16.0.0/16"]

}

# Lage subnetta
resource "azurerm_subnet" "subnet1_AK1" {
  name                  = "subnet1"
  resource_group_name   = azurerm_resource_group.res_group_AK1.name
  virtual_network_name  = azurerm_virtual_network.vnet_AK1.name
  address_prefixes      = ["172.16.1.0/24"]
}

resource "azurerm_subnet" "subnet2_AK1" {
  name                  = "subnet2"
  resource_group_name   = azurerm_resource_group.res_group_AK1.name
  virtual_network_name  = azurerm_virtual_network.vnet_AK1.name
  address_prefixes      = ["172.16.2.0/24"]

 
}

# Lage public IP-adresser
resource "azurerm_public_ip" "pub_ip1_AK1" {
  name                  = "pubIP1"
  location              = azurerm_resource_group.res_group_AK1.location
  resource_group_name   = azurerm_resource_group.res_group_AK1.name
  allocation_method     = "Static"
}


# Lage nics til VMane
resource "azurerm_network_interface" "nic1_AK1" {
  name                  = "VM1_nic1"
  location              = azurerm_resource_group.res_group_AK1.location
  resource_group_name   = azurerm_resource_group.res_group_AK1.name

  ip_configuration {
    name                            = "VM1_nic1_conf"
    subnet_id                       = azurerm_subnet.subnet1_AK1.id
    private_ip_address_allocation   = "Static"
    private_ip_address              = "172.16.1.4"
    public_ip_address_id            = azurerm_public_ip.pub_ip1_AK1.id
  }
}

resource "azurerm_network_interface" "nic2_AK1" {
  name                  = "VM2_nic2"
  location              = azurerm_resource_group.res_group_AK1.location
  resource_group_name   = azurerm_resource_group.res_group_AK1.name

  ip_configuration {
    name                            = "VM2_nic2_conf"
    subnet_id                       = azurerm_subnet.subnet2_AK1.id
    private_ip_address_allocation   = "Static"
    private_ip_address              = "172.16.2.4"
  }
}

# Security Groups
resource "azurerm_network_security_group" "net_sg1_AK1" {
  name                = "netSG_VM1"
  location            = azurerm_resource_group.res_group_AK1.location
  resource_group_name = azurerm_resource_group.res_group_AK1.name

  security_rule {
    name                        = "AllowSSH"
    priority                    = 100
    direction                   = "Inbound"
    access                      = "Allow"
    protocol                    = "Tcp"
    source_port_range           = "*"
    destination_port_range      = "22"
    source_address_prefix       = "*"
    destination_address_prefix  = "*"
  }
}

resource "azurerm_network_security_group" "net_sg2_AK1" {
  name                = "netSG_VM2"
  location            = azurerm_resource_group.res_group_AK1.location
  resource_group_name = azurerm_resource_group.res_group_AK1.name

  security_rule {
    name                        = "AllowSSH"
    priority                    = 100
    direction                   = "Inbound"
    access                      = "Allow"
    protocol                    = "Tcp"
    source_port_range           = "*"
    destination_port_range      = "22"
    source_address_prefix       = "172.16.1.4"
    destination_address_prefix  = "*"
  }
}

# Kople SG til nics
resource "azurerm_subnet_network_security_group_association" "sg1_to_subnet1" {
  subnet_id                   = azurerm_subnet.subnet1_AK1.id
  network_security_group_id   = azurerm_network_security_group.net_sg1_AK1.id
}

# Kople SG til nics
resource "azurerm_subnet_network_security_group_association" "sg2_to_subnet2" {
  subnet_id                   = azurerm_subnet.subnet2_AK1.id
  network_security_group_id   = azurerm_network_security_group.net_sg2_AK1.id
}


# VM1:
resource "azurerm_linux_virtual_machine" "lnx_vm1_AK1" {
  name                  = "LNX-VM1"
  resource_group_name   = azurerm_resource_group.res_group_AK1.name
  location              = azurerm_resource_group.res_group_AK1.location
  size                  = "Standard_B2ats_v2"
  admin_username        = "adminuser"
  admin_password                  = "Admin123"
  disable_password_authentication = "false"
  network_interface_ids = [
    azurerm_network_interface.nic1_AK1.id,
  ]

  admin_ssh_key {
    username    = "adminuser"
    public_key  = file("C:\\Users\\Bergljot\\OneDrive - Innlandet fylkeskommune\\Skule\\FS-2\\Skytenester\\Terraform\\AK1\\Key-VM1.pub")
  }

  os_disk {
    caching               = "ReadWrite"
    storage_account_type  = "Standard_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "ubuntu-24_04-lts"
    sku       = "server"
    version   = "latest"

  }
}

# VM2
resource "azurerm_linux_virtual_machine" "lnx_vm2_AK1" {
  name                            = "LNX-VM2"
  resource_group_name             = azurerm_resource_group.res_group_AK1.name
  location                        = azurerm_resource_group.res_group_AK1.location
  size                            = "Standard_B2ats_v2"
  admin_username                  = "adminuser"
  admin_password                  = "Admin123"
  disable_password_authentication = "false"
  network_interface_ids = [
    azurerm_network_interface.nic2_AK1.id,
  ]

  os_disk {
    caching               = "ReadWrite"
    storage_account_type  = "Standard_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "ubuntu-24_04-lts"
    sku       = "server"
    version   = "latest"

  }

}











