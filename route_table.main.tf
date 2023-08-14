resource "aws_route_table" "name" {
  for_each = {
    for route_table in var.route_tables :
    coalesce(route_table.name, local.vpc.id) => route_table
    if route_table.routes != null && route_table.default_route_table_id == null
  }
  vpc_id           = local.vpc.id
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
      gateway_id = try(
        # if regex matches => use given gateway_id
        regex("^igw-[0-9a-z]{17}$", route.value.gateway_id),
        # if not => try to use the one created in this module
        aws_internet_gateway.name[route.value.gateway_id].id,
        # if not => set to null meaning other attribute should be used
        null
      )
      nat_gateway_id = try(
        # if regex matches => use given nat_gateway_id
        regex("^nat-[0-9a-z]{17}$", route.value.nat_gateway_id),
        # if not => try to use the one created in this module
        aws_nat_gateway.name[route.value.nat_gateway_id].id,
        # if not => set to null meaning other attribute should be used
        null
      )
      local_gateway_id     = route.value.local_gateway_id
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
    aws_subnet.name,
    aws_internet_gateway.name,
    aws_nat_gateway.name,
  ]
}
