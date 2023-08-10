locals {
  Name   = { "Name" : var.name }
  vpc_id = one([for name, vpc in aws_vpc.name : vpc.id])
}
