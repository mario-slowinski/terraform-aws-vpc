locals {
  Name     = { "Name" : var.name }
  vpc      = one([for name, vpc in aws_vpc.name : vpc])
  subnets  = { for name, subnet in aws_subnet.name : name => subnet }
  eips     = { for name, eip in aws_eip.name : name => eip }
  peerings = { for vpc, peering in aws_vpc_peering_connection.vpc : vpc => peering }
}
