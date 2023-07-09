## Config for ER and L4-L7 Services on Hub VNet ##

# Shared Resources AP

resource "aci_cloud_applicationcontainer" "services_ap" {
  tenant_dn = data.aci_tenant.infra_tenant.id
  name      = var.services_ap
}

# ER EPG + Allowed On-Prem Prefixes/Subnets

resource "aci_cloud_external_epg" "er_epg" {
  name                            = var.er_epg
  cloud_applicationcontainer_dn   = aci_cloud_applicationcontainer.services_ap.id
  relation_cloud_rs_cloud_epg_ctx = data.aci_vrf.services_vrf.id
  route_reachability              = "site-ext"
  relation_fv_rs_prov             = [aci_contract.cloud_to_onprem.id]
/*
# To be enabled only after the contract is imported from workload tenant.

  relation_fv_rs_cons_if          = [data.aci_imported_contract.onprem_to_cloud.id] 
*/
}

resource "aci_cloud_endpoint_selectorfor_external_epgs" "ext_subnet1" {
  cloud_external_epg_dn = aci_cloud_external_epg.er_epg.id
  name                  = var.er_subnet1_name
  subnet                = var.er_subnet1
}

resource "aci_cloud_endpoint_selectorfor_external_epgs" "ext_subnet2" {
  cloud_external_epg_dn = aci_cloud_external_epg.er_epg.id
  name                  = var.er_subnet2_name
  subnet                = var.er_subnet2
}

# ER Contract on Infra Tenant for Cloud to On-prem connectivity

resource "aci_contract" "cloud_to_onprem" {
  tenant_dn = data.aci_tenant.infra_tenant.id
  name      = var.er_contract_cloud_to_onprem
  scope     = "global" # This contract will need to be imported and visible in the user/workload tenant
}

resource "aci_contract_subject" "cloud_to_onprem" {
  contract_dn                  = aci_contract.cloud_to_onprem.id
  name                         = "cloud_to_onprem"
  relation_vz_rs_subj_filt_att = [data.aci_filter.default_filter.id]
}

# FW Mgmt EPG + Contract to allow SSH/HTTPs acccess

resource "aci_cloud_epg" "fw_mgmt_epg" {
  name                            = var.fw_mgmt_epg
  cloud_applicationcontainer_dn   = aci_cloud_applicationcontainer.services_ap.id
  relation_fv_rs_prov             = [aci_contract.fw_mgmt_access.id]
  relation_cloud_rs_cloud_epg_ctx = data.aci_vrf.services_vrf.id
}

resource "aci_cloud_endpoint_selector" "fw_mgmt" {
  cloud_epg_dn     = aci_cloud_epg.fw_mgmt_epg.id
  name             = var.fw_mgmt_subnet_name
  match_expression = var.fw_mgmt_subnet # This requires the Hub VNet to be configured already with an additional CIDR
}

resource "aci_contract" "fw_mgmt_access" {
  tenant_dn = data.aci_tenant.infra_tenant.id
  name      = var.fw_mgmt_contract
  scope     = "tenant" 
}

resource "aci_contract_subject" "fw_mgmt_access" {
  contract_dn                  = aci_contract.fw_mgmt_access.id
  name                         = "fw_subject"
  relation_vz_rs_subj_filt_att = [data.aci_filter.ssh_https.id]
}

# Associate fw_mgmt_access contract as consumer on existing ext_networks EPG

resource "aci_epg_to_contract" "ext_networks" {
  application_epg_dn = data.aci_cloud_external_epg.ext_networks.id
  contract_dn        = aci_contract.fw_mgmt_access.id
  contract_type      = "consumer"
}