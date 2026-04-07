# outputs.tf - loadbalancer

output "bepool_ids" {
    description = "Nettverks ID"
    value = azurerm_lb_backend_address_pool.bepool.id

}

