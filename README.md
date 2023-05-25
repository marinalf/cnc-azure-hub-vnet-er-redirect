
### Notes

This is a sample code to build networking and policies on Azure through Cloud Network Controller. Some of the initial config and services need to be configured via GUI. 

### Pre-requisites / Assumptions


1. First Time Setup configured and ER deployed on gateway subnet of Hub VNet.
2. Deploy secondary VRF **(hub-vnet-networking)**, disable VNet peering, and add secondary CIDRs for different services in the Hub VNet. 
3. Deploy 3rd party firewall on Azure within the CIDR/Subnets defined in the Hub VNet.
4. Deploy Hub VNet policies **(hub-vnet-policies)** for ER and firewall mgmt access. 
5. Deploy sample VNet and subnets **(spoke-vnets-networking)**.
6. Deploy sample VNet policies **(spoke-vnets-policies)**.
7. Deploy inter-tenant contracts **(imported-contracts)**. 
8. Create a logical device to represent L4-L7 firewall and tag firewall interfaces on CNC as well on azure. Define service graph for firewal redirect.
9. Associate service graph on ER contracts (on-prem to cloud and cloud to on-prem) and inter-vnet contracts (not part of this code yet).