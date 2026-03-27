# variables.tf - modul_ressursgruppe

variable "RG_namn" {
    description = "Namn på ressursgruppe"
    type        = string
}

variable "lokasjon" {
    description = "Azure regionen ressursane skal opprettast"
    type        = string
}