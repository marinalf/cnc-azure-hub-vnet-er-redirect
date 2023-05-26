
## Adding secondary CIDRs/Subnets into the Hub VNet ##

resource "aci_vrf" "shared_vrf" {
  tenant_dn = data.aci_tenant.infra_tenant.id # Secondary VRF to host new CIDRs within Hub VNet.
  name = var.shared_vrf
}

/*

## Issue: https://github.com/CiscoDevNet/terraform-provider-aci/issues/1049

# Disable VNet Peering (Hub Networking)

Location in GUI: Application Management » Cloud Context Profiles » ct_ctxprofile_japaneast

resource "aci_rest_managed" "disable_hub_networking" {
  dn       = "uni/tn-infra/infranetwork-default/intnetwork-default/provider-azure-region-japaneast/regiondetail"
  class_name = "cloudtemplateRegionDetail"
  content = {
    "hubNetworkingEnabled" = "no"
  }
}

## Issue: https://github.com/CiscoDevNet/terraform-provider-aci/issues/1050

# Firewall CIDR/Subnets

resource "aci_cloud_cidr_pool" "fw_cidr" {
  cloud_context_profile_dn = data.aci_cloud_context_profile.hub_vnet.id
  addr                     = var.fw_cidr
  primary                  = "no"
}

resource "aci_cloud_subnet" "fw_subnets" {
  for_each           = var.fw_subnets
  cloud_cidr_pool_dn = aci_cloud_cidr_pool.fw_cidr.id
  name               = each.value.name
  ip                 = each.value.ip
}

*/
