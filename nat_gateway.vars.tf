variable "nat_gateways" {
  type = list(object({
    allocation_id                      = optional(string)       # The Allocation ID of the Elastic IP address for the NAT Gateway.
    connectivity_type                  = optional(string)       # Connectivity type for the NAT Gateway. Valid values are private and public.
    private_ip                         = optional(string)       # The private IPv4 address to assign to the NAT Gateway.
    subnet_id                          = string                 # The Subnet ID of the subnet in which to place the NAT Gateway.
    secondary_allocation_ids           = optional(list(string)) # A list of secondary allocation EIP IDs for this NAT Gateway.
    secondary_private_ip_address_count = optional(number)       # [Private NAT Gateway only] The number of secondary private IPv4 addresses you want to assign to the NAT Gateway.
    secondary_private_ip_addresses     = optional(list(string)) # A list of secondary private IPv4 addresses to assign to the NAT Gateway.
    tags                               = optional(map(string))  # A map of tags to assign to the resource.
  }))
  description = "resource to create a VPC NAT Gateway."
  default     = [{ subnet_id = null }]
}
