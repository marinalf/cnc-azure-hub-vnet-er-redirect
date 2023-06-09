
# CNC Credentials & Azure Subscription

variable "username" {}
variable "password" {}
variable "url" {}
variable "subscription_id" {}

# Hub VNet variables for Express Route

variable "services_ap" {
  default = "services-ap"
}

variable "er_epg" {
  default = "er-gateway-epg"
}

variable "er_subnet1_name" {
  default = "on-prem-subnets1"
}

variable "er_subnet2_name" {
  default = "on-prem-subnets2"
}

variable "er_subnet1" {
  default = "172.50.0.0/24"
}

variable "er_subnet2" {
  default = "172.51.0.0/24"
}

variable "er_contract_cloud_to_onprem" {
  default = "cloud-to-onprem"
}

# Hub VNet variables for L4-L7 (Firewall)

variable "fw_mgmt_epg" {
  default = "fw-mgmt-epg"
}

variable "fw_mgmt_contract" {
  default = "fw-mgmt-access"
}

variable "fw_mgmt_subnet_name" {
  default = "fw-mgmt-subnet"
}

variable "fw_mgmt_subnet" {
  default = "IP=='12.1.0.0/24'"
}