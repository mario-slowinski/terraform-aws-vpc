locals {
  Name    = { "Name" : var.name }
  vpc_id  = one([for name, vpc in aws_vpc.name : vpc.id])
  subnets = { for name, subnet in aws_subnet.name : name => subnet.id }
  eips    = { for name, eip in aws_eip.name : name => eip.id }
}
