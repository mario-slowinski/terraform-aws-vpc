variable "peering_connections" {
  type = list(object({
    auto_accept   = optional(bool)   # Accept the peering (both VPCs need to be in the same AWS account and region)."
    peer_owner_id = optional(string) # The AWS account ID of the owner of the peer VPC."
    peer_region   = optional(string) # The region of the accepter VPC of the VPC Peering Connection."
    peer_vpc_id   = string           # The ID of the VPC with which you are creating the VPC Peering Connection."
    accepter = optional(object({
      allow_remote_vpc_dns_resolution = optional(bool)
    }))
    requester = optional(object({
      allow_remote_vpc_dns_resolution = optional(bool)
    }))
    tags = optional(map(string))
  }))
  description = "List of VPC peering connections."
  default     = [{ peer_vpc_id = null }]
}
