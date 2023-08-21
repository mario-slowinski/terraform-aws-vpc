resource "aws_nat_gateway" "name" {
  for_each = { for nat_gateway in var.nat_gateways : nat_gateway.name => nat_gateway if nat_gateway.name != null }

  allocation_id = coalesce(try(
    # if regex matches => use given allocation_id
    regex("^eipalloc-[0-9a-z]{17}$", each.value.allocation_id), null),
    # if not => try to use the one created in this module
    local.eips[each.value.allocation_id].id
  )
  connectivity_type = each.value.connectivity_type
  private_ip        = each.value.private_ip
  # if regex matches => use given subnet_id, if not => try to use the one created in this module
  subnet_id                          = one(regexall("^subnet-[0-9a-z]{17}$", each.value.subnet_id)) != null ? each.value.subnet_id : local.subnets[each.value.subnet_id].id
  secondary_allocation_ids           = each.value.secondary_allocation_ids
  secondary_private_ip_address_count = each.value.secondary_private_ip_address_count
  secondary_private_ip_addresses     = each.value.secondary_private_ip_addresses
  tags                               = merge(var.tags, local.Name, each.value.tags, { Name = each.key })

  depends_on = [
    aws_eip.name,
    aws_subnet.cidr,
  ]
}
