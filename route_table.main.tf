resource "aws_route_table" "many" {
  for_each = {
    for route_table in var.route_tables :
    coalesce(route_table.name, aws_vpc.this.id) => route_table
    if route_table.routes != null
  }
  vpc_id           = aws_vpc.this.id
  propagating_vgws = each.value.propagating_vgws

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
      carrier_gateway_id         = route.value.carrier_gateway_id
      core_network_arn           = route.value.core_network_arn
      egress_only_gateway_id     = route.value.egress_only_gateway_id
      gateway_id                 = route.value.gateway_id
      nat_gateway_id             = route.value.nat_gateway_id
      local_gateway_id           = route.value.local_gateway_id
      network_interface_id       = route.value.network_interface_id
      transit_gateway_id         = route.value.transit_gateway_id
      vpc_endpoint_id            = route.value.vpc_endpoint_id
      vpc_peering_connection_id = try(
        # if regex matches => use given vpc_peering_connection_id
        regex("^pcx-[0-9a-z]{17}$", route.value.vpc_peering_connection_id),
        # if not => try to use the one created in this module pointed by vpc_id
        aws_vpc_peering_connection.many[route.value.vpc_peering_connection_id].id,
        # if not => set to null meaning other attribute should be used
        null
      )
    }
  }

  tags = merge(
    local.tags,
    local.Name,
    var.tags,
    { Name = each.value.name },
    each.value.tags
  )

  depends_on = [
    aws_vpc_peering_connection.many,
  ]
}
