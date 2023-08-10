variable "subnets" {
  type = list(object({
    name                                           = string                # Subnet name
    assign_ipv6_address_on_creation                = optional(bool)        # Specify true to indicate that network interfaces created in the specified subnet should be assigned an IPv6 address.
    availability_zone                              = optional(string)      # AZ for the subnet.
    availability_zone_id                           = optional(string)      # AZ ID of the subnet.
    cidr_block                                     = optional(string)      # The IPv4 CIDR block for the subnet.
    customer_owned_ipv4_pool                       = optional(string)      # The customer owned IPv4 address pool.
    enable_dns64                                   = optional(bool)        # Indicates whether DNS queries made to the Amazon-provided DNS Resolver in this subnet should return synthetic IPv6 addresses for IPv4-only destinations.
    enable_lni_at_device_index                     = optional(number)      # Indicates the device position for local network interfaces in this subnet.
    enable_resource_name_dns_aaaa_record_on_launch = optional(bool)        # Indicates whether to respond to DNS queries for instance hostnames with DNS AAAA records.
    enable_resource_name_dns_a_record_on_launch    = optional(bool)        # Indicates whether to respond to DNS queries for instance hostnames with DNS A records.
    ipv6_cidr_block                                = optional(string)      # The IPv6 network range for the subnet, in CIDR notation.
    ipv6_native                                    = optional(bool)        # Indicates whether to create an IPv6-only subnet.
    map_customer_owned_ip_on_launch                = optional(bool)        # Specify true to indicate that network interfaces created in the subnet should be assigned a customer owned IP address.
    map_public_ip_on_launch                        = optional(bool)        # Specify true to indicate that instances launched into the subnet should be assigned a public IP address.
    outpost_arn                                    = optional(string)      # The Amazon Resource Name (ARN) of the Outpost.
    private_dns_hostname_type_on_launch            = optional(string)      # The type of hostnames to assign to instances in the subnet at launch.
    vpc_id                                         = optional(string)      # VPC id, use the one created in this module if not set
    tags                                           = optional(map(string)) # A map of tags to assign to the resource.
  }))
  description = "List of VPC subnet resources."
  default     = [{ name = null }]
}
