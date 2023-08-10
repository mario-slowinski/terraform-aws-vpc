output "vpc" {
  value       = local.vpc
  description = "Map of VPC attributes."
}

output "subnets" {
  value       = local.subnets
  description = "Map of VPC subnets."
}

output "eips" {
  value       = local.eips
  description = "Map of VPC eips."
}

output "peerings" {
  value       = local.peerings
  description = "Map of VPC peerings."
}
