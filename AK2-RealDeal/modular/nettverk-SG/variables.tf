# AK2-forsøk2, variables.tf - modul_nettverk-SG

variable "RG_namn" {
    description = "Namn på ressursgruppe"
    type        = string
}

variable "lokasjon" {
    description = "Azure regionen ressursane skal opprettast"
    type        = string
}

variable "vnet1_SG" {
    description = "nettverksreglar for vnet1"
    type        = string
}


variable "subnet_ids" {
    description = "subnet id"
    type        = map(string)
}

variable "ansible_IP" {
    description = "Statisk IP til ansible"
    type        = string
}