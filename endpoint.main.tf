resource "aws_vpc_endpoint" "service" {
  for_each = {
    for endpoint in var.endpoints :
    "${endpoint.service_name}:${endpoint.vpc_endpoint_type}" => endpoint
    if endpoint.service_name != null && endpoint.vpc_endpoint_type != null
  }

  service_name        = each.value.service_name
  vpc_endpoint_type   = each.value.vpc_endpoint_type
  vpc_id              = coalesce(each.value.vpc_id, local.vpc.id)
  auto_accept         = each.value.auto_accept
  policy              = each.value.policy
  private_dns_enabled = each.value.private_dns_enabled
  ip_address_type     = each.value.ip_address_type
  route_table_ids = [
    for route_table in coalesce(each.value.route_table_ids, []) :
    one(regexall("^rtb-[0-9a-z]{17}$", route_table)) != null ? route_table : local.route_tables[route_table].id
  ]
  subnet_ids = [
    for subnet in coalesce(each.value.subnet_ids, []) :
    one(regexall("^subnet-[0-9a-z]{17}$", subnet)) != null ? subnet : local.subnets[subnet].id
  ]
  security_group_ids = [
    for security_group in coalesce(each.value.security_group_ids, []) :
    one(regexall("^sg-[0-9a-z]{17}$", security_group)) != null ? security_group : local.security_groups[security_group].id
  ]
  tags = merge(
    {
      Name = join(".", [
        replace(each.value.service_name, "/.+\\./", ""),
        each.value.vpc_endpoint_type,
      ])
    },
    each.value.tags
  )

  depends_on = [
    aws_vpc.name,
    aws_subnet.cidr,
    aws_route_table.name,
    aws_security_group.name,
  ]
}
