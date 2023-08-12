output "vpc" {
  value       = local.vpc
  description = "Map of VPC attributes."
}

output "eips" {
  value       = local.eips
  description = "Map of VPC eips."
}

output "internet_gateways" {
  value       = local.internet_gateways
  description = "Map of VPC internet_gateways."
}

output "nat_gateways" {
  value       = local.nat_gateways
  description = "Map of VPC nat_gateways."
}

output "peerings" {
  value       = local.peerings
  description = "Map of VPC peerings."
}

output "security_groups" {
  value       = local.security_groups
  description = "Map of VPC security_groups."
}

output "subnets" {
  value       = local.subnets
  description = "Map of VPC subnets."
}
