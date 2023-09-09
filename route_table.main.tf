resource "aws_route_table" "name" {
  for_each = {
    for route_table in var.route_tables :
    route_table.Name => route_table
    if route_table.Name != null && !coalesce(route_table.default, false)
  }
  vpc_id           = local.vpc.id
  propagating_vgws = each.value.propagating_vgws

  tags = merge(var.tags, local.Name, each.value.tags, { Name = each.value.Name })
}
