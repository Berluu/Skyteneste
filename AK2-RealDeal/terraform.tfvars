# AK2 - terraform.tfvars

#
RG_namn = "RG_AK2"
lokasjon = "Norway East"

#nettverk
vnet_namn = "AK2_Net"
ip_range = ["192.168.1.0/24"]
subnet_namn = ["AK2_SNet1", "AK2_SNet2"]
subnet_ranges = ["192.168.1.0/25", "192.168.1.128/25"]
pubip_namn = "LB_publicIP"

# VMane
VMnic_namn = ["VM_nic1", "VM_nic2"]
VM_namn = ["VM1", "VM2"]
adm_user = "berelv"
adm_passwd = "Admin123"

IPconf_namn = "IPconf"

#LB ting
LB_namn = "AK2_LB"
frontend_ip_conf = "FrontendIP"

bepool_namn = "BE_pool"
LB_probe_namn = "http_probe"
LBrule_namn = "LB_rule"



#Net SG
vnet1_SG = "AK2_SG"

#ANSIBLE TING
ansible_IP = "10.200.200.0/24"
existing_vnet_name = "Net_Ansible"
existing_RG_name = "RG_Ansible"

