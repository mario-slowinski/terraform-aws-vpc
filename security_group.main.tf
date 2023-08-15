resource "aws_default_security_group" "vpc" {
  for_each = {
    for security_group in var.security_groups :
    local.vpc.id => security_group
    if(security_group.name != null || security_group.name_prefix != null) && security_group.default
  }

  vpc_id = local.vpc.id
  ingress {
    description = "Self rule"
    protocol    = -1
    self        = true
    from_port   = 0
    to_port     = 0
  }
  egress {
    description = "Self rule"
    protocol    = -1
    from_port   = 0
    to_port     = 0
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = merge(var.tags, local.Name, each.value.tags, { Name = each.value.name })
}

resource "aws_security_group" "name" {
  for_each = {
    for security_group in var.security_groups :
    coalesce(security_group.name, security_group.name_prefix) => security_group
    if(security_group.name != null || security_group.name_prefix != null) && !security_group.default
  }

  description            = each.value.description
  name_prefix            = each.value.name_prefix
  name                   = each.value.name
  revoke_rules_on_delete = each.value.revoke_rules_on_delete
  vpc_id                 = coalesce(each.value.vpc_id, local.vpc.id)

  tags = merge(var.tags, local.Name, each.value.tags, { Name = each.value.name })
}

resource "aws_vpc_security_group_ingress_rule" "port" {
  for_each = {
    for ingress_rule in local.security_group_ingress_rules :
    "${ingress_rule.security_group_name}:${coalesce(ingress_rule.from_port, "ALL")}" => ingress_rule
    if ingress_rule != null
  }

  security_group_id = coalesce(
    each.value.security_group_id,
    try(aws_default_security_group.vpc[local.vpc.id].id, null),
    try(aws_security_group.name[each.value.security_group_name].id, null),
  )
  cidr_ipv4                    = each.value.cidr_ipv4
  cidr_ipv6                    = each.value.cidr_ipv6
  description                  = each.value.description
  from_port                    = each.value.from_port
  ip_protocol                  = each.value.ip_protocol
  prefix_list_id               = each.value.prefix_list_id
  referenced_security_group_id = each.value.referenced_security_group_id
  to_port                      = try(coalesce(each.value.to_port, each.value.from_port), null)

  tags = merge(var.tags, local.Name, each.value.tags, { Name = each.value.name })

  depends_on = [
    aws_default_security_group.vpc,
    aws_security_group.name,
  ]
}

resource "aws_vpc_security_group_egress_rule" "port" {
  for_each = {
    for egress_rule in local.security_group_egress_rules :
    "${egress_rule.security_group_name}:${coalesce(egress_rule.from_port, "ALL")}" => egress_rule
    if egress_rule != null
  }

  security_group_id = coalesce(
    each.value.security_group_id,
    try(aws_default_security_group.vpc[local.vpc.id].id, null),
    try(aws_security_group.name[each.value.security_group_name].id, null),
  )
  cidr_ipv4                    = each.value.cidr_ipv4
  cidr_ipv6                    = each.value.cidr_ipv6
  description                  = each.value.description
  from_port                    = each.value.from_port
  ip_protocol                  = each.value.ip_protocol
  prefix_list_id               = each.value.prefix_list_id
  referenced_security_group_id = each.value.referenced_security_group_id
  to_port                      = try(coalesce(each.value.to_port, each.value.from_port), null)

  tags = merge(var.tags, local.Name, each.value.tags, { Name = each.value.name })

  depends_on = [
    aws_default_security_group.vpc,
    aws_security_group.name,
  ]
}

