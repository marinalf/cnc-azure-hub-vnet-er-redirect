
### Notes

This is a sample code to build networking and policies on Azure through Cloud Network Controller. Some of the initial config and services need to be configured via GUI. 

### Pre-requisites / Assumptions

1. First Time Setup configured and ER deployed on gateway subnet of Hub VNet.
2. Disable VNet peering on Hub VNet
3. Deploy secondary VRF and add secondary CIDRs for different services in the Hub VNet **(hub-vnet-networking)**.
4. Enable VNet peering on Hub VNet
5. Deploy 3rd party firewall on Azure within the CIDR/Subnets defined in the Hub VNet.
6. Deploy Hub VNet policies **(hub-vnet-policies)** for ER and firewall mgmt access. 
7. Deploy sample VNet and subnets **(spoke-vnets-networking)**.
8. Deploy sample VNet policies **(spoke-vnets-policies)**.
9. Deploy inter-tenant imported contract on Hub VNet (see notes on **hub-vnet-policies** under aci_cloud_external_epg). 
10. Create a logical device for the firewall and tag interfaces (trust & untrust) on CNC as well on azure. 
11. Create a logical device for a network load balancer and define a two-node service graph for Redirect.
12. Associate the service graph on the ER contract (cloud-to-onprem) and inter-vnet contract (not part of this code yet). 