#AK2  main.tf - modul_nettverk

#nettverket Ansible host er på
data "azurerm_virtual_network" "Ansible_net" {
    name                = var.existing_vnet_name
    resource_group_name = var.existing_RG_name
}


# Opprette eit virtuelt nettverk
resource "azurerm_virtual_network" "vnet_1" {
    name                = var.vnet_namn
    resource_group_name = var.RG_namn
    location            = var.lokasjon
    address_space       = var.ip_range
}

# Opprette subnet
resource "azurerm_subnet" "vnet1_subnet" {
    count                   = length(var.subnet_ranges)    # Kor mange subnet
    name                    = var.subnet_namn[count.index] # Henta namn på subnets
    address_prefixes        = [var.subnet_ranges[count.index]] # Henta subnet ranges
    virtual_network_name    = azurerm_virtual_network.vnet_1.name
    resource_group_name     = var.RG_namn
}


# Kople det nye virtuelle nettverket til det som allereie eksistera (der ansible host er i dette tilfelle)
resource "azurerm_virtual_network_peering" "new_to_existing" {
    name                            = "Peer-nettverka"
    resource_group_name             = var.RG_namn
    virtual_network_name            = var.vnet_namn
    remote_virtual_network_id       = data.azurerm_virtual_network.Ansible_net.id
    allow_virtual_network_access    = true
}

# Kople det eksisterande virtuelle nettverket til det nye
    # Trengte begge desse for at det skulle fungere ordentleg, når eg berre hadde eine gjekk det berre ein veg isj
resource "azurerm_virtual_network_peering" "existing_to_new" {
    name = "PlisFunger"
    resource_group_name = var.existing_RG_name
    virtual_network_name = var.existing_vnet_name
    remote_virtual_network_id = azurerm_virtual_network.vnet_1.id
    allow_virtual_network_access    = true
}

# lage public IP til LB
resource "azurerm_public_ip" "public_ip" {
    name                = var.pubip_namn
    location            = var.lokasjon
    resource_group_name = var.RG_namn
    allocation_method   = "Static"
    sku                 = "Standard"
}

