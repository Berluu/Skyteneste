# main.tf - modul_linux-vm

#VM AAAAAAAAAAAA


# Opprette NICs til VMane
resource "azurerm_network_interface" "VM_nic" {
    count               = length(var.VMnic_namn)    # Kor mange nics
    name                = var.VMnic_namn[count.index]   # Henta namna på nics
    location            = var.lokasjon
    resource_group_name = var.RG_namn

    ip_configuration {
        name                            = var.IPconf_namn
        subnet_id                       = var.subnet_ids["AK2_SNet1"]   # henta subnet id frå lista i nettverksmodulen
        private_ip_address_allocation   = "Dynamic"
    }
} 

resource "azurerm_network_interface_backend_address_pool_association" "NIC_association" {
    count                   = length(var.VMnic_namn)
    network_interface_id    = azurerm_network_interface.VM_nic[count.index].id
    ip_configuration_name   = var.IPconf_namn
    backend_address_pool_id = var.bepool_ids
}


resource "azurerm_linux_virtual_machine" "VM" {
    count                           = length(var.VM_namn)   #Kanskje endre dette til eigen variabel seinare?
    name                            = var.VM_namn[count.index]
    location                        = var.lokasjon
    resource_group_name             = var.RG_namn
    size                            = "Standard_B2ats_v2"
    admin_username                  = var.adm_user
    admin_password                  = var.adm_passwd
    disable_password_authentication = "false"
    network_interface_ids           = [azurerm_network_interface.VM_nic[count.index].id]

        os_disk {
        caching                 = "ReadWrite"
        storage_account_type    = "Standard_LRS"
    }
    source_image_reference {
        publisher = "Canonical"
        offer     = "ubuntu-24_04-lts"
        sku       = "server"
        version   = "latest"
    }
}

