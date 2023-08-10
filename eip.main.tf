resource "aws_eip" "name" {
  for_each = { for eip in var.eips : eip.name => eip if eip.name != null }

  address                   = each.value.address
  associate_with_private_ip = each.value.associate_with_private_ip
  customer_owned_ipv4_pool  = each.value.customer_owned_ipv4_pool
  domain                    = each.value.domain
  instance                  = each.value.instance
  network_border_group      = each.value.network_border_group
  network_interface         = each.value.network_interface
  public_ipv4_pool          = each.value.public_ipv4_pool
  tags                      = merge(each.value.tags, { Name = each.key })

  depends_on = [
    aws_vpc.name,
  ]
}
