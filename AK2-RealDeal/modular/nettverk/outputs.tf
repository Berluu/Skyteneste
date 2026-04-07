# AK2  outputs.tf - modul_nettverk


output "vnet_id" {
    description = "Nettverks ID"
    value = azurerm_virtual_network.vnet_1.id

}

output "subnet_ids" {
    value = {
        for subnet in azurerm_subnet.vnet1_subnet :
        subnet.name => subnet.id
    }
}

output "pubip_id" {
    description = "ID public IP til lastbalanseren"
    value       = azurerm_public_ip.public_ip.id
}

