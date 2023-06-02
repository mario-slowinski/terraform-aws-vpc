resource "aws_vpc_peering_connection" "this" {
  for_each = {
    for peering_connection in var.peering_connections :
    peering_connection.peer_vpc_id => peering_connection
    if peering_connection.peer_vpc_id != null
  }

  auto_accept   = each.value.auto_accept
  peer_owner_id = each.value.peer_owner_id
  peer_region   = each.value.peer_region
  peer_vpc_id   = each.value.peer_vpc_id
  vpc_id        = aws_vpc.this.id

  dynamic "accepter" {
    for_each = each.value.accepter != null ? toset([each.value.accepter]) : toset([])
    content {
      allow_remote_vpc_dns_resolution = accepter.value.allow_remote_vpc_dns_resolution
    }
  }

  dynamic "requester" {
    for_each = each.value.requester != null ? toset([each.value.requester]) : toset([])
    content {
      allow_remote_vpc_dns_resolution = requester.value.allow_remote_vpc_dns_resolution
    }
  }

  tags = merge(local.tags, local.Name, var.tags, each.value.tags)
}
