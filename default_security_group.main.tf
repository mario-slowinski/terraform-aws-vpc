resource "aws_default_security_group" "name" {
  for_each = {
    for security_group in var.security_groups :
    "default" => security_group
    if security_group.name == "default"
  }

  vpc_id = coalesce(each.value.vpc_id, local.vpc.id)
  tags   = merge(each.value.tags, { Name = each.value.Name })

  ingress {
    protocol  = -1
    self      = true
    from_port = 0
    to_port   = 0
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
