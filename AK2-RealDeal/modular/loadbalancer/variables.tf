#AK2 variables.tf - modul_loadbalancer


variable "RG_namn" {
    description = "Namn på ressursgruppe"
    type        = string
}

variable "lokasjon" {
    description = "Azure regionen ressursane skal opprettast"
    type        = string
}

variable "LB_namn" {
    description = "Namn til lastbalanseren"
    type        = string
}

variable "frontend_ip_conf" {
    description = "Namn til frontend IP config"
    type        = string
}

variable "pubip_id" {
    description = "AAAAAAAAAAAAAAAAAAA"
    type        = string
}

#variable "vnet_id" {
#    description = "ID virtuelt nettverk"
#    type        = string
#}

variable "bepool_namn" {
    description = "Navn til backend pool"
    type        = string
}

variable "LB_probe_namn" {
    description = "Namn til health probe som blir brukt av last balanseren"
    type        = string
}

variable "LBrule_namn" {
    description = "Namn til regel for last balanser"
    type        = string
}

variable "existing_vnet_name" {
    description = "Eksisterande virtuelt nettverk til ansible"
    type        = string
}

variable "existing_RG_name" {
    description = "Eksisterande resource group til ansible"
    type        = string
}