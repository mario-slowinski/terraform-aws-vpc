variable "route_tables" {
  type = list(object({
    Name             = string                        # Route table name
    default          = optional(bool)                # Whether to manage default route table
    id               = optional(string)              # Route table id
    propagating_vgws = optional(list(string))        # A list of virtual gateways for propagation.
    subnets          = optional(list(string))        # A list of subnet ids/names to associate route table with.
    routes = list(object({                           # List of VPC routing table routes.
      destination_cidr_block      = optional(string) # The destination CIDR block.
      destination_ipv6_cidr_block = optional(string) # The destination IPv6 CIDR block.
      destination_prefix_list_id  = optional(string) # The ID of a managed prefix list destination.

      carrier_gateway_id        = optional(string) # Identifier of a carrier gateway.
      core_network_arn          = optional(string) # The Amazon Resource Name (ARN) of a core network.
      egress_only_gateway_id    = optional(string) # Identifier of a VPC Egress Only Internet Gateway.
      gateway_id                = optional(string) # Identifier of a VPC internet gateway or a virtual private gateway.
      nat_gateway_id            = optional(string) # Identifier of a VPC NAT gateway.
      local_gateway_id          = optional(string) # Identifier of a Outpost local gateway.
      network_interface_id      = optional(string) # Identifier of an EC2 network interface.
      transit_gateway_id        = optional(string) # Identifier of an EC2 Transit Gateway.
      vpc_endpoint_id           = optional(string) # Identifier of a VPC Endpoint.
      vpc_peering_connection_id = optional(string) # Identifier of a VPC peering connection.
    }))
    tags = optional(map(string)) # A map of tags to assign to the resource.
  }))
  description = "List of VPC routing tables."
  default     = [{ Name = null, routes = null }]
}
