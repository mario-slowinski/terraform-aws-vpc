variable "name" {
  type        = string
  description = "VPC name."
  default     = null
}

variable "cidr_block" {
  type        = string
  description = "The IPv4 CIDR block for the VPC."
  default     = null
}

variable "instance_tenancy" {
  type        = string
  description = "A tenancy option for instances launched into the VPC."
  default     = null
}

variable "ipv4_ipam_pool_id" {
  type        = string
  description = "The ID of an IPv4 IPAM pool you want to use for allocating this VPC's CIDR."
  default     = null
}

variable "ipv4_netmask_length" {
  type        = string
  description = "The netmask length of the IPv4 CIDR you want to allocate to this VPC."
  default     = null
}

variable "ipv6_cidr_block" {
  type        = string
  description = "IPv6 CIDR block to request from an IPAM Pool."
  default     = null
}

variable "ipv6_ipam_pool_id" {
  type        = string
  description = "IPAM Pool ID for a IPv6 pool."
  default     = null
}

variable "ipv6_netmask_length" {
  type        = number
  description = "Netmask length to request from IPAM Pool."
  default     = null
}

variable "ipv6_cidr_block_network_border_group" {
  type        = string
  description = "By default when an IPv6 CIDR is assigned to a VPC a default ipv6_cidr_block_network_border_group will be set to the region of the VPC."
  default     = null
}

variable "enable_dns_support" {
  type        = bool
  description = "A boolean flag to enable/disable DNS support in the VPC."
  default     = null
}

variable "enable_network_address_usage_metrics" {
  type        = bool
  description = "Indicates whether Network Address Usage metrics are enabled for your VPC."
  default     = null
}

variable "enable_dns_hostnames" {
  type        = bool
  description = "A boolean flag to enable/disable DNS hostnames in the VPC."
  default     = null
}

variable "assign_generated_ipv6_cidr_block" {
  type        = bool
  description = "Requests an Amazon-provided IPv6 CIDR block with a /56 prefix length for the VPC."
  default     = null
}

variable "tags" {
  type        = map(string)
  description = "Map of tags to be used instead of the ones composed automatically."
  default     = {}
}
