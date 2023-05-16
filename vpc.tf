resource "aws_vpc" "this" {
  cidr_block = var.cidr_block

  tags = merge(local.tags, var.tags, local.Name)
}
