locals {
  Name              = { "Name" : var.name }
  vpc               = coalesce(one([for name, vpc in aws_vpc.name : vpc]), { id = null })
  eips              = { for name, eip in aws_eip.name : name => eip }
  internet_gateways = { for name, internet_gateway in aws_internet_gateway.name : name => internet_gateway }
  nat_gateways      = { for name, nat_gateway in aws_nat_gateway.name : name => nat_gateway }
  peerings          = { for vpc, peering in aws_vpc_peering_connection.vpc : vpc => peering }
  security_groups   = { for name, security_group in aws_security_group.name : name => security_group }
  subnets           = { for name, subnet in aws_subnet.name : name => subnet }
}
