resource "aws_default_route_table" "default" {
  for_each = {
    for route_table in var.route_tables :
    coalesce(route_table.name, try(local.vpc.id, null)) => route_table
    if route_table.routes != null && route_table.default_route_table_id != null
  }
  default_route_table_id = coalesce(each.value.default_route_table_id, try(local.vpc.default_route_table_id, null))
  propagating_vgws       = each.value.propagating_vgws

  dynamic "route" {
    for_each = {
      for route in each.value.routes :
      coalesce(
        route.destination_cidr_block,
        route.destination_ipv6_cidr_block,
        route.destination_prefix_list_id
      ) => route
    }
    content {
      cidr_block                 = route.value.destination_cidr_block
      ipv6_cidr_block            = route.value.destination_ipv6_cidr_block
      destination_prefix_list_id = route.value.destination_prefix_list_id
      core_network_arn           = route.value.core_network_arn
      egress_only_gateway_id     = route.value.egress_only_gateway_id
      gateway_id = try(
        # if regex matches => use given gateway_id
        regex("^igw-[0-9a-z]{17}$", route.value.gateway_id),
        # if not => try to use the one created in this module
        aws_internet_gateway.this[route.value.gateway_id].id,
        # if not => set to null meaning other attribute should be used
        null
      )
      nat_gateway_id       = route.value.nat_gateway_id
      network_interface_id = route.value.network_interface_id
      transit_gateway_id   = route.value.transit_gateway_id
      vpc_endpoint_id      = route.value.vpc_endpoint_id
      vpc_peering_connection_id = try(
        # if regex matches => use given vpc_peering_connection_id
        regex("^pcx-[0-9a-z]{17}$", route.value.vpc_peering_connection_id),
        # if not => try to use the one created in this module pointed by vpc_id
        aws_vpc_peering_connection.vpc[route.value.vpc_peering_connection_id].id,
        # if not => set to null meaning other attribute should be used
        null
      )
    }
  }

  tags = merge(var.tags, local.Name, each.value.tags, { Name = each.value.name })

  depends_on = [
    aws_vpc_peering_connection.vpc,
  ]
}
