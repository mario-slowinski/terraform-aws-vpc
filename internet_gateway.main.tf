resource "aws_internet_gateway" "this" {
  count = var.internet_gateway != null ? 1 : 0

  vpc_id = aws_vpc.this.id
  tags   = merge(var.tags, var.internet_gateway)
}
