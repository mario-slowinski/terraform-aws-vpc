resource "aws_route" "destination" {
  for_each = {
    for route in local.routes :
    "${coalesce(route.route_table, route.id)}_${
      coalesce(
        route.destination_cidr_block,
        route.destination_ipv6_cidr_block,
        route.destination_prefix_list_id
    )}" => route
  }

  route_table_id = each.value.default ? (
    local.vpc.default_route_table_id
    ) : (
    coalesce(each.value.id, each.value.route_table != null ? local.route_tables[each.value.route_table].id : null)
  )
  destination_cidr_block      = each.value.destination_cidr_block
  destination_ipv6_cidr_block = each.value.destination_ipv6_cidr_block
  destination_prefix_list_id  = each.value.destination_prefix_list_id
  carrier_gateway_id          = each.value.carrier_gateway_id
  core_network_arn            = each.value.core_network_arn
  egress_only_gateway_id      = each.value.egress_only_gateway_id
  gateway_id = try(
    # if regex matches => use given gateway_id
    regex("^igw-[0-9a-z]{17}$", each.value.gateway_id),
    # if not => try to use the one created in this module
    aws_internet_gateway.name[each.value.gateway_id].id,
    # if not => set to null meaning other attribute should be used
    null
  )
  nat_gateway_id = try(
    # if regex matches => use given nat_gateway_id
    regex("^nat-[0-9a-z]{17}$", each.value.nat_gateway_id),
    # if not => try to use the one created in this module
    aws_nat_gateway.name[each.value.nat_gateway_id].id,
    # if not => set to null meaning other attribute should be used
    null
  )
  local_gateway_id     = each.value.local_gateway_id
  network_interface_id = each.value.network_interface_id
  transit_gateway_id   = each.value.transit_gateway_id
  vpc_endpoint_id      = each.value.vpc_endpoint_id
  vpc_peering_connection_id = try(
    # if regex matches => use given vpc_peering_connection_id
    regex("^pcx-[0-9a-z]{17}$", each.value.vpc_peering_connection_id),
    # if not => try to use the one created in this module pointed by vpc_id
    aws_vpc_peering_connection.vpc[each.value.vpc_peering_connection_id].id,
    # if not => set to null meaning other attribute should be used
    null
  )

  depends_on = [
    aws_vpc_peering_connection.vpc,
    aws_subnet.cidr,
    aws_internet_gateway.name,
    aws_nat_gateway.name,
  ]
}
