resource "aws_default_route_table" "vpc" {
  for_each = {
    for route_table in var.route_tables :
    coalesce(var.name, local.vpc.id) => route_table
    if coalesce(route_table.default, false)
  }
  default_route_table_id = local.vpc.default_route_table_id
  propagating_vgws       = each.value.propagating_vgws

  tags = merge(var.tags, local.Name, each.value.tags, { Name = each.value.Name })
}
