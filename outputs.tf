output "vpc" {
  value       = local.vpc
  description = "Map of VPC attributes."
}

output "eips" {
  value       = local.eips
  description = "Map of VPC eips attributes."
}

output "endpoints" {
  value       = local.endpoints
  description = "Map of VPC endpoints attributes."
}

output "internet_gateways" {
  value       = local.internet_gateways
  description = "Map of VPC internet_gateways attributes."
}

output "nat_gateways" {
  value       = local.nat_gateways
  description = "Map of VPC nat_gateways attributes."
}

output "peerings" {
  value       = local.peerings
  description = "Map of VPC peerings attributes."
}

output "security_groups" {
  value       = local.security_groups
  description = "Map of VPC security_groups attributes."
}

output "subnets" {
  value       = local.subnets
  description = "Map of VPC subnets attributes."
}
