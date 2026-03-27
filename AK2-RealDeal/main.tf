#AK2 forsøk 2 -  main.tf - root


# Ressursgruppe
module "ressurs_gruppe" {
    source      = "./modular/ressursgruppe"
    RG_namn     = var.RG_namn
    lokasjon    = var.lokasjon
}
# Det funka!

# Nettverk
module "nettverk" {
    source          = "./modular/nettverk"
    RG_namn         = var.RG_namn
    lokasjon        = var.lokasjon
    vnet_namn       = var.vnet_namn
    ip_range        = var.ip_range
    subnet_namn     = var.subnet_namn
    subnet_ranges   = var.subnet_ranges
    pubip_namn      = var.pubip_namn
    
    existing_vnet_name  = var.existing_vnet_name
    existing_RG_name    = var.existing_RG_name

    depends_on      = [module.ressurs_gruppe]
}

# funka så langt... skal prøve å legge til NICs
module "NetSecurityGroup" {
    source = "./modular/nettverk-SG"
    RG_namn         = var.RG_namn
    lokasjon        = var.lokasjon
    subnet_ids      = module.nettverk.subnet_ids # henta subnet id frå lista i nettverksmodulen
    vnet1_SG        = var.vnet1_SG
    ansible_IP      = var.ansible_IP

    depends_on  = [module.nettverk]
}

module "loadbalancer" {
    source              = "./modular/loadbalancer"
    RG_namn             = var.RG_namn
    lokasjon            = var.lokasjon
    pubip_id            = module.nettverk.pubip_id
    LB_namn             = var.LB_namn
    frontend_ip_conf    = var.frontend_ip_conf
    bepool_namn         = var.bepool_namn
    LB_probe_namn       = var.LB_probe_namn
    LBrule_namn         = var.LBrule_namn
    
    existing_vnet_name  = var.existing_vnet_name
    existing_RG_name    = var.existing_RG_name

    
    depends_on  = [module.nettverk]
}

module "vm" {
    source          = "./modular/linux-vmar"
    RG_namn         = var.RG_namn
    lokasjon        = var.lokasjon
    subnet_ids      = module.nettverk.subnet_ids # henta subnet id frå lista i nettverksmodulen
    VMnic_namn      = var.VMnic_namn
    VM_namn         = var.VM_namn
    adm_user        = var.adm_user
    adm_passwd      = var.adm_passwd
    IPconf_namn     = var.IPconf_namn
    bepool_ids      = module.loadbalancer.bepool_ids


    depends_on  = [module.nettverk, module.loadbalancer]

}

