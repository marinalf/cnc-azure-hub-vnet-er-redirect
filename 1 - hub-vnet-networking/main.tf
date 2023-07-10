
## Adding secondary CIDRs/Subnets into the Hub VNet ##

resource "aci_vrf" "services_vrf" {
  tenant_dn = data.aci_tenant.infra_tenant.id # Secondary VRF to host new CIDRs within Hub VNet.
  name      = var.services_vrf
}

/*
## Issue: https://github.com/CiscoDevNet/terraform-provider-aci/issues/1049

resource "aci_rest_managed" "disable_enable_hub_networking" {
  dn       = "uni/tn-infra/infranetwork-default/intnetwork-default/provider-azure-region-japaneast/regiondetail"
  class_name = "cloudtemplateRegionDetail"
  content = {
    "hubNetworkingEnabled" = "yes" # Disable/Enable VNet Peering (Hub Networking)
  }
}

*/

# Firewall CIDR/Subnets (inclusive of Load Balancer subnet)

resource "aci_cloud_cidr_pool" "fw_cidr" {
  cloud_context_profile_dn = data.aci_cloud_context_profile.hub_vnet.id
  addr                     = var.fw_cidr
  primary                  = "no"
}

resource "aci_cloud_subnet" "fw_subnets" {
  for_each                        = var.fw_subnets
  cloud_cidr_pool_dn              = aci_cloud_cidr_pool.fw_cidr.id
  name                            = each.value.name
  ip                              = each.value.ip
  relation_cloud_rs_subnet_to_ctx = aci_vrf.services_vrf.id
  zone                            = "uni/clouddomp/provp-azure/region-${var.hub_region}/zone-default" 
}
