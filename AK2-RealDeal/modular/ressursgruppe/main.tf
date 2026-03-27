# main.tf - modul_ressursgruppe

#Opprette ressursgruppe
resource "azurerm_resource_group" "res_group" {
    name        = var.RG_namn
    location    = var.lokasjon
}

