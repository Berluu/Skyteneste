# outputs.tf - loadbalancer


#output "bepool_ids" {
#    value = {
#        for pool in azurerm_lb_backend_address_pool.bepool :
#        pool.name => pool.id
#    }
#}

output "bepool_ids" {
    description = "Nettverks ID"
    value = azurerm_lb_backend_address_pool.bepool.id

}

