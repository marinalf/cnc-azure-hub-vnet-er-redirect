
### VNet1 Policies ###

# Application Profile for VNet1 EPG

resource "aci_cloud_applicationcontainer" "vnet1_ap" {
  tenant_dn = data.aci_tenant.tenant1.id
  name      = var.vnet1_ap
}

# VNet1 EPG (Single ASG, Network Centric)

resource "aci_cloud_epg" "vnet1_epg" {
  name                            = var.vnet1_epg
  cloud_applicationcontainer_dn   = aci_cloud_applicationcontainer.vnet1_ap.id
  relation_cloud_rs_cloud_epg_ctx = data.aci_vrf.vnet1.id
  relation_fv_rs_prov             = [aci_contract.internet_access.id, aci_contract.onprem_to_cloud.id]
  relation_fv_rs_cons_if          = [aci_imported_contract.cloud_to_onprem.id]
  depends_on                      = [aci_imported_contract.cloud_to_onprem]
}

resource "aci_cloud_endpoint_selector" "vnet1_epg_selector" {
  cloud_epg_dn     = aci_cloud_epg.vnet1_epg.id
  name             = var.vnet1_epg_selector
  match_expression = var.vnet1_epg_ip_based
}

# ER Contract on Workoad Tenant for On-prem to Cloud connectivity

resource "aci_contract" "onprem_to_cloud" {
  tenant_dn = data.aci_tenant.tenant1.id
  name      = var.er_contract_onprem_to_cloud
  scope     = "global" # This contract will need to be imported and visible in the user/workload tenant
}

resource "aci_contract_subject" "onprem_to_cloud" {
  contract_dn                  = aci_contract.onprem_to_cloud.id
  name                         = "onprem_to_cloud"
  relation_vz_rs_subj_filt_att = [data.aci_filter.default_filter.id]
}

# Cloud External EPG for Internet Access (Optional per VNet)

resource "aci_cloud_external_epg" "vnet1_internet" {
  name                            = var.vnet1_internet
  cloud_applicationcontainer_dn   = aci_cloud_applicationcontainer.vnet1_ap.id
  relation_fv_rs_cons             = [aci_contract.internet_access.id]
  relation_cloud_rs_cloud_epg_ctx = data.aci_vrf.vnet1.id
  route_reachability              = "internet"
}

resource "aci_cloud_endpoint_selectorfor_external_epgs" "vnet1_ext_epg_selector" {
  cloud_external_epg_dn = aci_cloud_external_epg.vnet1_internet.id
  name                  = var.vnet1_selector_name
  subnet                = var.vnet1_selector_subnet
}

# Contract for Internet Access

resource "aci_contract" "internet_access" {
  tenant_dn = data.aci_tenant.tenant1.id
  name      = var.internet_contract
  scope     = "tenant" # This allows this contract to be used by other VNets/EPG in the same tenant
}

resource "aci_contract_subject" "internet_access" {
  contract_dn                  = aci_contract.internet_access.id
  name                         = "internet-access"
  relation_vz_rs_subj_filt_att = [data.aci_filter.default_filter.id]
}

# Import contract from Workload Tenant to Infra Tenant to enable ER access

resource "aci_imported_contract" "onprem_to_cloud" {
  tenant_dn         = data.aci_tenant.infra_tenant.id
  name              = "onprem-to-cloud-imported"
  relation_vz_rs_if = aci_contract.onprem_to_cloud.id
  depends_on        = [aci_contract.onprem_to_cloud]
}

# Import contract from Infra Tenant to Workload Tenant to enable ER access

resource "aci_imported_contract" "cloud_to_onprem" {
  tenant_dn         = data.aci_tenant.tenant1.id
  name              = "cloud-to-onprem-imported"
  relation_vz_rs_if = data.aci_contract.cloud_to_onprem.id
}