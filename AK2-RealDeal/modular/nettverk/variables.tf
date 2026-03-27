# AK2-forsøk2, variables.tf - modul_nettverk

variable "RG_namn" {
    description = "Namn på ressursgruppe"
    type        = string
}

variable "lokasjon" {
    description = "Azure regionen ressursane skal opprettast"
    type        = string
}

variable "vnet_namn" {
    description = "Namn til virtuelt nettverk"
    type        = string
}

variable "ip_range" {
    description = "IP range for virtuelt nettverk"
    type        = list(string) #liste for å kunne lage fleire på ein gong
}

variable "subnet_namn" {
    description = "namn til subnet for net1"
    type        = list(string) #liste for å kunne lage fleire på ein gong
}

variable "subnet_ranges" {
    description = "Subnet til Net1"
    type        = list(string) #liste for å kunne lage fleire på ein gong
}


variable "pubip_namn" {
    description = "Public IP addresse til last balanseren"
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

