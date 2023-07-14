
# CNC Credentials & Azure Subscription

variable "username" {}
variable "password" {}
variable "url" {}
variable "subscription_id" {}

# Spoke VNet variables

variable "tenant_name" {
  default = "dc1"
}

variable "cloud_vendor" {
  default = "azure"
}

# VNet 1 variables

variable "vnet1_name" {
  default = "application"
}

variable "cxt_vnet1" {
  default = "ctx-vnet1"
}

variable "vnet1_cidr" {
  default = "20.100.0.0/21"
}

variable "vnet1_region1" {
  default = "japaneast"
}

variable "vnet1_subnets" {
  type = map(object({
    name = string
    ip   = string
  }))
  default = {
    subnet1 = {
      name = "subnet1"
      ip   = "20.100.1.0/24"
    },
    subnet2 = {
      name = "subnet2"
      ip   = "20.100.2.0/24"
    }
  }
}

# VNet 2 variables

variable "vnet2_name" {
  default = "database"
}

variable "cxt_vnet2" {
  default = "ctx-vnet2"
}

variable "vnet2_cidr" {
  default = "30.100.0.0/21"
}

variable "vnet2_region1" {
  default = "japaneast"
}

variable "vnet2_subnets" {
  type = map(object({
    name = string
    ip   = string
  }))
  default = {
    subnet3 = {
      name = "subnet3"
      ip   = "30.100.3.0/24"
    }
  }
}