resource "aws_vpc_peering_connection" "vpc" {
  for_each = {
    for peering_connection in var.peering_connections :
    peering_connection.peer_vpc_id => peering_connection
    if peering_connection.peer_vpc_id != null
  }

  auto_accept   = each.value.auto_accept
  peer_owner_id = each.value.peer_owner_id
  peer_region   = each.value.peer_region
  peer_vpc_id   = each.value.peer_vpc_id
  vpc_id        = local.vpc.id

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

  tags = merge(var.tags, each.value.tags, { Name = each.value.name })

  depends_on = [
    aws_vpc.name,
  ]
}

resource "aws_vpc_peering_connection_accepter" "vpc" {
  for_each = {
    for peering_connection in var.peering_connections :
    local.vpc.id => peering_connection
    if !peering_connection.auto_accept
  }

  provider = aws.remote

  vpc_peering_connection_id = aws_vpc_peering_connection.vpc[each.value.peer_vpc_id].id
  auto_accept               = true
  tags                      = merge(var.tags, each.value.tags, { Name = each.value.name })
}
