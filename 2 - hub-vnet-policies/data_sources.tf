
data "aci_tenant" "infra_tenant" {
  name = "infra"
}

data "aci_cloud_account" "aci_cloud_account_infra" {
  tenant_dn  = "uni/tn-infra"
  account_id = var.subscription_id
  vendor     = "azure"
}

data "aci_vrf" "shared_vrf" {
  tenant_dn = data.aci_tenant.infra_tenant.id # Secondary VRF to host new CIDRs
  name      = "shared-resources"
}

# Data Sources used for ER

data "aci_filter" "default_filter" {
  tenant_dn = "uni/tn-common"
  name      = "default" # Existing default filter allowing any traffic
}

# Data Sources used for FW mgmt access

data "aci_filter" "ssh_https" {
  tenant_dn = "uni/tn-infra"
  name      = "ssh-https" # Existing SSH & HTTPs filter allowing mgmt access to CNC/CCRs public IP
}

/*
# To be used only after a contract is imported from workload tenant

data "aci_imported_contract" "onprem_to_cloud" {
  tenant_dn = data.aci_tenant.infra_tenant.id
  name      = "onprem-to-cloud-imported"
}
*/