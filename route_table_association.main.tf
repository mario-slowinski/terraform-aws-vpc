resource "aws_route_table_association" "subnet" {
  for_each = { for route_table_subnet in local.route_table_subnets : route_table_subnet.subnet => route_table_subnet.route_table }

  subnet_id      = one(regexall("^subnet-[0-9a-z]{17}$", each.key)) != null ? each.key : local.subnets[each.key].id
  route_table_id = one(regexall("^rtb-[0-9a-z]{17}$", each.value)) != null ? each.value : local.route_tables[each.value].id

  depends_on = [
    aws_subnet.cidr,
    aws_route_table.name,
  ]
}
