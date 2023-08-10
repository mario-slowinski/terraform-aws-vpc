variable "eips" {
  type = list(object({
    name                      = string                # Elastic IP name
    address                   = optional(string)      # IP address from an EC2 BYOIP pool. This option is only available for VPC EIPs.
    associate_with_private_ip = optional(string)      # User-specified primary or secondary private IP address to associate with the Elastic IP address. If no private IP address is specified, the Elastic IP address is associated with the primary private IP address.
    customer_owned_ipv4_pool  = optional(string)      # ID of a customer-owned address pool. For more on customer owned IP addressed check out Customer-owned IP addresses guide.
    domain                    = optional(string)      # Indicates if this EIP is for use in VPC (vpc).
    instance                  = optional(string)      # EC2 instance ID.
    network_border_group      = optional(string)      # Location from which the IP address is advertised. Use this parameter to limit the address to this location.
    network_interface         = optional(string)      # Network interface ID to associate with.
    public_ipv4_pool          = optional(string)      # EC2 IPv4 address pool identifier or amazon. This option is only available for VPC EIPs.
    tags                      = optional(map(string)) # Map of tags to assign to the resource. Tags can only be applied to EIPs in a VPC.
  }))
  description = "List of Elastic IPs."
  default     = [{ name = null }]
}
