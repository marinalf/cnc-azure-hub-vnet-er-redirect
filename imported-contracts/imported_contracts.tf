
# Variables

variable "username" {}
variable "password" {}
variable "url" {}
variable "subscription_id" {}

variable "tenant_name" {
  default = "dc1"
}

variable "er_contract_onprem_to_cloud" {
  default = "onprem-to-cloud"
}

variable "er_contract_cloud_to_onprem" {
  default = "cloud-to-onprem"
}

# Data Sources

data "aci_tenant" "infra_tenant" {
  name = "infra"
}

data "aci_tenant" "tenant1" {
  name        = var.tenant_name
}

# Import contract from Workload Tenant to Infra Tenant to enable ER access

data "aci_contract" "onprem_to_cloud" {
  tenant_dn = data.aci_tenant.tenant1.id
  name      = var.er_contract_onprem_to_cloud
}

resource "aci_imported_contract" "onprem_to_cloud" {
  tenant_dn   = data.aci_tenant.infra_tenant.id
  name        = "onprem-to-cloud-imported"
  relation_vz_rs_if = data.aci_contract.onprem_to_cloud.id
}

# Import contract from Infra Tenant to Workload Tenant to enable ER access

data "aci_contract" "cloud_to_onprem" {
  tenant_dn = data.aci_tenant.infra_tenant.id
  name      = var.er_contract_cloud_to_onprem
}

resource "aci_imported_contract" "cloud_to_onprem" {
  tenant_dn   = data.aci_tenant.tenant1.id
  name        = "cloud-to-onprem-imported"
  relation_vz_rs_if = data.aci_contract.cloud_to_onprem.id
}
