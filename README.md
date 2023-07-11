
### Description

This is a sample terraform code to build networking and policies on Azure through Cloud Network Controller. Some of the initial config and services are configured via GUI. 

### Pre-requisites / Assumptions

Part 1 - Initial Config
1. Configure First Time Setup on CNC
2. Deploy ER Gateway on gateway subnet of Hub VNet (overlay-1) in Azure
3. Disable VNet peering of Hub VNet on CNC

Part 2 - Deploy Hub VNet networking 
1. Deploy secondary VRF and add secondary CIDRs for L4-L7 services in the Hub VNet **(1 - hub-vnet-networking)**.
2. Enable VNet peering of Hub VNet on CNC

Part 3 - Deploy L4-L7 Services on Hub VNet
1. Deploy Hub VNet policies **(2 - hub-vnet-policies)** for ER and firewall mgmt access.
2. Deploy 3rd party firewall on Azure within the secondary CIDR/Subnets defined in the Hub VNet.
3. Tag trust and untrust firewall interfaces on Azure 
4. Create a logical device for the firewall with the trust & untrust tags on CNC
5. Create a network load balancer and define a two-node service graph with firewall for Redirect.

Part 4 - Deploy Spoke VNets
1. Deploy sample VNets and subnets **(3 - spoke-vnets-networking)**.
2. Deploy sample VNets policies **(4 - spoke-vnets-policies)**.

Part 5 - Deploy Inter-Tenant Policies
1. Deploy imported contract on Hub VNet (see comments on **(2 - hub-vnet-policies)** under aci_cloud_external_epg). 

Part 6 - Apply Service Graph
1. Associate the service graph on the ER contract (onprem-to-cloud) and inter-vnet contract.