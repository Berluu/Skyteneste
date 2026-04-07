# variables.tf - root

#Subscription ID
variable "sub_id" {
    description = "Subscription ID"
    type        = string
    default     = "340ce909-e132-4535-abbd-21f5b5f772da"

}
 
variable "RG_namn" {
    description = "Namn på ressursgruppe"
    type        = string
}

variable "lokasjon" {
    description = "Azure regionen ressursane skal opprettast"
    type        = string
    #default     = "Norway East"
}

variable "vnet_namn" {
    description = "Namn til virtuelt nettverk"
    type        = string
    #default     = "Net1"
}

variable "ip_range" {
    description = "IP range for virtuelt nettverk"
    type        = list(string) #liste for å kunne lage fleire på ein gong
    #default     = ["172.16.1.0/24"]
}

variable "subnet_namn" {
    description = "namn til subnet for net1"
    type        = list(string)
    #default     = ["Net1_1", "Net1_2"] #2 subnet
}
variable "subnet_ranges" {
    description = "Subnet til Net1"
    type        = list(string)
    #default     = ["172.16.1.0/25", "172.16.1.128/25"] #2 subnet
}

variable "pubip_namn" {
    description = "Public IP addresse til last balanseren"
    type        = string
}



# namn til nic
variable "VMnic_namn" {
    description = "Namn til NICs til VMane"
    type        = list(string)
    #default     = ["VM_nic1", "VM_nic2"] 
}

variable "VM_namn" {
    description = "Namn på VMane"
    type        = list(string)
    #default     = ["VM1", "VM2"]
}

variable "adm_user" {
    description = "VM admin brukarnamn"
    type        = string
    #default     = "berelv"
}

variable "adm_passwd" {
    description = "VM admin passord"
    type        = string
    #default     = "Admin123"
}



variable "LB_namn" {
    description = "Namn til lastbalanseren"
    type        = string
    #default     = "AK2_LB"
}

variable "frontend_ip_conf" {
    description = "Namn til frontend IP config"
    type        = string
    #default     = "FrontendIP"
}

variable "bepool_namn" {
    description = "Navn til backend pool"
    type        = string
    #default     = "BE_pool"
}

variable "LB_probe_namn" {
    description = "Namn til health probe som blir brukt av last balanseren"
    type        = string
    #default     = "http_probe"
}

variable "LBrule_namn" {
    description = "Namn til regel for last balanser"
    type        = string
    #default     = "LB_rule"
}

variable "IPconf_namn" {
    description = "namn til NIC Ip config"
    type        = string
    #default     = "IPconf"
}

variable "vnet1_SG" {
    description = "nettverksreglar for vnet1"
    type        = string
    #default     = "AK2_SG"
}

variable "ansible_IP" {
    description = "Statisk IP til ansible"
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