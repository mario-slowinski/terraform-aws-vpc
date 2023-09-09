locals {
  Name              = { "Name" : var.name }
  vpc               = merge({ id = var.vpc_id }, one([for name, vpc in aws_vpc.name : vpc]))
  eips              = { for name, eip in aws_eip.name : name => eip }
  endpoints         = { for service, endpoint in aws_vpc_endpoint.service : service => endpoint }
  internet_gateways = { for name, internet_gateway in aws_internet_gateway.name : name => internet_gateway }
  nat_gateways      = { for name, nat_gateway in aws_nat_gateway.name : name => nat_gateway }
  peerings          = { for vpc, peering in aws_vpc_peering_connection.vpc : vpc => peering }
  security_groups   = { for name, security_group in merge({ "default" = data.aws_security_group.default }, aws_security_group.name) : name => security_group }
  subnets           = { for cidr, subnet in aws_subnet.cidr : cidr => subnet }
  route_tables      = { for name, route_table in aws_route_table.name : name => route_table }
  routes = distinct(flatten([
    for route_table in var.route_tables : [
      for route in route_table.routes : [
        merge(route, {
          route_table = route_table.Name,
          default     = coalesce(route_table.default, false)
          id          = route_table.id
        })
      ]
    ]
    if route_table.routes != null
  ]))
  security_group_ingress_rules = distinct(flatten([
    for security_group in var.security_groups : [
      for ingress_rule in security_group.ingress_rules : [
        merge(ingress_rule, { security_group_name = security_group.name })
      ]
    ]
    if security_group.ingress_rules != null && security_group.name != null
  ]))
  security_group_egress_rules = distinct(flatten([
    for security_group in var.security_groups : [
      for egress_rule in security_group.egress_rules : [
        merge(egress_rule, { security_group_name = security_group.name })
      ]
    ]
    if security_group.egress_rules != null && security_group.name != null
  ]))
  route_table_subnets = distinct(flatten([
    for route_table in var.route_tables : [
      for cidr in route_table.subnets : {
        subnet      = cidr
        route_table = coalesce(route_table.id, route_table.Name)
      }
    ]
    if route_table.subnets != null
  ]))
}
