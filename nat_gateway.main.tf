resource "aws_nat_gateway" "subnet" {
  for_each = { for nat_gateway in var.nat_gateways : nat_gateway.subnet_id => nat_gateway if nat_gateway.subnet_id != null }

  allocation_id                      = each.value.allocation_id
  connectivity_type                  = each.value.connectivity_type
  private_ip                         = each.value.private_ip
  subnet_id                          = each.value.subnet_id
  secondary_allocation_ids           = each.value.secondary_allocation_ids
  secondary_private_ip_address_count = each.value.secondary_private_ip_address_count
  secondary_private_ip_addresses     = each.value.secondary_private_ip_addresses
  tags                               = merge(local.Name, var.tags, each.value.tags)
}
