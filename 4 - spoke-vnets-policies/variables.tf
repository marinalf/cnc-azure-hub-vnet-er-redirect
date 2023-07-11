
# CNC Credentials & Azure Subscription

variable "username" {}
variable "password" {}
variable "url" {}
variable "subscription_id" {}


variable "tenant_name" {
  default = "dc1"
}

variable "vnet1_name" {
  default = "application"
}

variable "vnet2_name" {
  default = "database"
}

# VNet1 EPG (Single ASG, Network Centric)

variable "vnet1_ap" {
  default = "vnet1-ap"
}

variable "vnet1_epg" {
  default = "vnet1-epg"
}

variable "vnet1_epg_selector" {
  default = "vnet1-epg-selector"
}

variable "vnet1_epg_ip_based" {
  default = "IP=='20.100.0.0/21'"
}

# Internet External EPG + Contract

variable "vnet1_internet" {
  default = "vnet1-internet"
}

variable "vnet1_selector_name" {
  default = "Internet"
}

variable "vnet1_selector_subnet" {
  default = "0.0.0.0/0"
}

variable "internet_contract" {
  default = "internet-access" # Used by both VNets
}

# ER contract to allow on-prem/cloud and cloud/on-prem connectivity

variable "er_contract_onprem_to_cloud" {
  default = "onprem-to-cloud"
}

variable "er_contract_cloud_to_onprem" {
  default = "cloud-to-onprem"
}

# VNet2 EPG (Single ASG, Network Centric)

variable "vnet2_ap" {
  default = "vnet2-ap"
}

variable "vnet2_epg" {
  default = "vnet2-epg"
}

variable "vnet2_epg_selector" {
  default = "vnet2-epg-selector"
}

variable "vnet2_epg_ip_based" {
  default = "IP=='30.100.0.0/21'"
}

# Internet External EPG + Contract

variable "vnet2_internet" {
  default = "vnet2-internet"
}

variable "vnet2_selector_name" {
  default = "Internet"
}

variable "vnet2_selector_subnet" {
  default = "0.0.0.0/0"
}

variable "inter_vnet_contract" {
  default = "inter-vnet-contract"
}