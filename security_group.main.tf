resource "aws_security_group" "name" {
  for_each = {
    for security_group in var.security_groups :
    coalesce(security_group.name, security_group.name_prefix) => security_group
    if security_group.name != null || security_group.name_prefix != null
  }

  description            = each.value.description
  name_prefix            = each.value.name_prefix
  name                   = each.value.name
  revoke_rules_on_delete = each.value.revoke_rules_on_delete
  vpc_id                 = each.value.vpc_id

  tags = merge(var.tags, local.Name, each.value.tags, { Name = each.key })
}
