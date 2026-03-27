#AK2-forsøk2,  main.tf - modul_nettverk-SG

# https://oneuptime.com/blog/post/2026-02-16-how-to-use-terraform-dynamic-blocks-for-azure-network-security-group-rules/view

resource "azurerm_network_security_group" "NetSecGroup" {
    name                = var.vnet1_SG
    location            = var.lokasjon
    resource_group_name = var.RG_namn

    security_rule {
        name                        = "Allow-HTTP"
        priority                    = "110"
        direction                   = "Inbound"
        access                      = "Allow"
        protocol                    = "Tcp"
        source_port_range           = "*"
        destination_port_range      = "80"
        source_address_prefix       = "*"
        destination_address_prefix  = "*"
    }

        security_rule {
        name                        = "Allow-SSH"
        priority                    = "100"
        direction                   = "Inbound"
        access                      = "Allow"
        protocol                    = "Tcp"
        source_port_range           = "*"
        destination_port_range      = "22"
        source_address_prefix       = var.ansible_IP #IP til ansible host?
        destination_address_prefix  = "*"
    }

        security_rule {
        name                       = "Allow-HTTPS"
        priority                   = 120
        direction                  = "Inbound"
        access                     = "Allow"
        protocol                   = "Tcp"
        source_port_range          = "*"
        destination_port_range     = "443"
        source_address_prefix      = "*"
        destination_address_prefix = "*"
    }
}

resource "azurerm_subnet_network_security_group_association" "SG_to_subnet" {
    subnet_id                   = var.subnet_ids["AK2_SNet1"]
    network_security_group_id   = azurerm_network_security_group.NetSecGroup.id
}








