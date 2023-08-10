resource "aws_subnet" "name" {
  for_each = { for subnet in var.subnets : subnet.name => subnet if subnet.name != null }

  assign_ipv6_address_on_creation                = each.value.assign_ipv6_address_on_creation
  availability_zone                              = each.value.availability_zone
  availability_zone_id                           = each.value.availability_zone_id
  cidr_block                                     = each.value.cidr_block
  customer_owned_ipv4_pool                       = each.value.customer_owned_ipv4_pool
  enable_dns64                                   = each.value.enable_dns64
  enable_lni_at_device_index                     = each.value.enable_lni_at_device_index
  enable_resource_name_dns_aaaa_record_on_launch = each.value.enable_resource_name_dns_aaaa_record_on_launch
  enable_resource_name_dns_a_record_on_launch    = each.value.enable_resource_name_dns_a_record_on_launch
  ipv6_cidr_block                                = each.value.ipv6_cidr_block
  ipv6_native                                    = each.value.ipv6_native
  map_customer_owned_ip_on_launch                = each.value.map_customer_owned_ip_on_launch
  map_public_ip_on_launch                        = each.value.map_public_ip_on_launch
  outpost_arn                                    = each.value.outpost_arn
  private_dns_hostname_type_on_launch            = each.value.private_dns_hostname_type_on_launch
  vpc_id                                         = coalesce(each.value.vpc_id, local.vpc.id)
  tags                                           = merge(each.value.tags, { Name = each.key })
}
