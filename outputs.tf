output "id" {
  value       = local.vpc_id
  description = "VPC id."
}

output "subnets" {
  value       = local.subnets
  description = "Map of VPC subnets."
}
