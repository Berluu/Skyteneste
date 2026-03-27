# variables.tf - modul_linux-vm

variable "RG_namn" {
    description = "Namn på ressursgruppe"
    type        = string
}

variable "lokasjon" {
    description = "Azure regionen ressursane skal opprettast"
    type        = string
}


variable "VMnic_namn" {
    description = "Namn til NICs til VMane"
    type        = list(string)
}


variable "subnet_ids" {
    description = "subnet id"
    type        = map(string)
}

variable "VM_namn" {
    description = "Namn på VMane"
    type        = list(string)
}

variable "adm_user" {
    description = "VM admin brukarnamn"
    type        = string
}

variable "adm_passwd" {
    description = "VM admin passord"
    type        = string
}

variable "IPconf_namn" {
    description = "namn til NIC IP conf"
    type        = string
}

variable "bepool_ids" {
    description = "AAAAAA"
    type        = string
}