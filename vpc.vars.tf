variable "name" {
  type        = string
  description = "Resource's name."
  default     = ""
}

variable "cidr_block" {
  type        = string
  description = "The IPv4 CIDR block for the VPC."
  default     = null
}

variable "address_space" {
  type        = list(string)
  description = "The list of address spaces used by the virtual network."
  default     = []
}

variable "location" {
  type        = string
  description = "Region to create resource."
  default     = ""
}

variable "ddos_protection_plan" {
  type = object({
    id     = string
    enable = bool
  })
  description = "Optional block."
  default = {
    id     = ""
    enable = false
  }
}

variable "dns_servers" {
  type        = list(string)
  description = "List of IP addresses of DNS servers."
  default     = null
}

variable "edge_zone" {
  type        = string
  description = "Specifies the Edge Zone within the Azure Region where this Virtual Network should exist."
  default     = null
}

variable "flow_timeout_in_minutes" {
  type        = number
  description = "The flow timeout in minutes for the Virtual Network, which is used to enable connection tracking for intra-VM flows."
  default     = null
}
