resource "aws_internet_gateway" "name" {
  for_each = { for internet_gateway in var.internet_gateways : internet_gateway.name => internet_gateway if internet_gateway.name != null }

  vpc_id = coalesce(each.value.vpc_id, local.vpc.id)
  tags   = merge(var.tags, local.Name, each.value.tags, { Name = each.key })
}
