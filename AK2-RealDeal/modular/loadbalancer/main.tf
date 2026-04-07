#AK2  main.tf - modul_loadbalancer

#https://dev.to/smallsun2025/deploy-azure-load-balancer-and-virtual-machines-using-terraform-4gpk
#https://kndoni.medium.com/create-a-standard-load-balancer-in-azure-with-terraform-ee1da012b55e

#Load balancer
resource "azurerm_lb" "LB" {
    name                = var.LB_namn
    location            = var.lokasjon
    resource_group_name = var.RG_namn
    sku                 = "Standard"

    frontend_ip_configuration {
        name                    = var.frontend_ip_conf
        public_ip_address_id    = var.pubip_id
    }
}

# Backend pool
resource "azurerm_lb_backend_address_pool" "bepool" {
    name                = var.bepool_namn
    loadbalancer_id     = azurerm_lb.LB.id
}


# Health probe
resource "azurerm_lb_probe" "probe" {
    name                = var.LB_probe_namn
    loadbalancer_id     = azurerm_lb.LB.id
    protocol            = "Tcp"         # Prøvde med http her og men det gjekk ikkje ??? 
    port                = 80
    #request_path        = "/health"    # Måtte kommentere vekk for at nettsida skulle vise i nettlesar, idk why
                                        # Prøvde og med berre "/"
}

# LB rule
resource "azurerm_lb_rule" "LBrule" {
    name                            = var.LBrule_namn
    loadbalancer_id                 = azurerm_lb.LB.id
    protocol                        = "Tcp"
    frontend_port                   = 80
    backend_port                    = 80
    frontend_ip_configuration_name  = var.frontend_ip_conf
    backend_address_pool_ids        = [azurerm_lb_backend_address_pool.bepool.id]
    probe_id                        = azurerm_lb_probe.probe.id
}

resource "azurerm_lb_nat_pool" "ssh_nat_pool" {
    resource_group_name            = var.RG_namn
    name                           = "ssh_natpool"
    loadbalancer_id                = azurerm_lb.LB.id
    protocol                       = "Tcp"
    frontend_port_start            = 50000
    frontend_port_end              = 50119
    backend_port                   = 22
    frontend_ip_configuration_name = var.frontend_ip_conf
}