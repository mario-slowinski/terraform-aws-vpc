resource "aws_internet_gateway" "this" {
  count = var.internet_gateway != null ? 1 : 0

  vpc_id = local.vpc_id.id
  tags   = merge(var.tags, var.internet_gateway)
}
