variable "security_groups" {
  type = list(object({
    default                = bool                          # Whether it is default security group
    description            = optional(string)              # Security group description.
    name_prefix            = optional(string)              # Creates a unique name beginning with the specified prefix.
    name                   = optional(string)              # Name of the security group.
    revoke_rules_on_delete = optional(bool)                # Instruct Terraform to revoke all of the Security Groups attached ingress and egress rules before deleting the rule itself.
    vpc_id                 = optional(string)              # VPC ID. Defaults to the region's default VPC.
    tags                   = optional(map(string))         # Map of tags to assign to the resource.
    ingress_rules = optional(list(object({                 #  Manages an inbound (ingress) rule for a security group.
      name                         = optional(string)      # The rule name
      cidr_ipv4                    = optional(string)      # The destination IPv4 CIDR range.
      cidr_ipv6                    = optional(string)      # The destination IPv6 CIDR range.
      description                  = optional(string)      # The security group rule description.
      from_port                    = optional(number)      # The start of port range for the TCP and UDP protocols, or an ICMP/ICMPv6 type.
      ip_protocol                  = string                # The IP protocol name or number. Use -1 to specify all protocols.
      prefix_list_id               = optional(string)      # The ID of the destination prefix list
      referenced_security_group_id = optional(string)      # The destination security group that is referenced in the rule.
      to_port                      = optional(number)      # The end of port range for the TCP and UDP protocols, or an ICMP/ICMPv6 code. Equals to from_port if not given.
      security_group_id            = optional(string)      # Security Group id, in case just adding rules to the existing one
      tags                         = optional(map(string)) # A map of tags to assign to the resource.
    })))
    egress_rules = optional(list(object({                  #  Manages an inbound (ingress) rule for a security group.
      name                         = optional(string)      # The rule name
      cidr_ipv4                    = optional(string)      # The destination IPv4 CIDR range.
      cidr_ipv6                    = optional(string)      # The destination IPv6 CIDR range.
      description                  = optional(string)      # The security group rule description.
      from_port                    = optional(number)      # The start of port range for the TCP and UDP protocols, or an ICMP/ICMPv6 type.
      ip_protocol                  = string                # The IP protocol name or number. Use -1 to specify all protocols.
      prefix_list_id               = optional(string)      # The ID of the destination prefix list
      referenced_security_group_id = optional(string)      # The destination security group that is referenced in the rule.
      to_port                      = optional(number)      # The end of port range for the TCP and UDP protocols, or an ICMP/ICMPv6 code. Equals to from_port if not given.
      security_group_id            = optional(string)      # Security Group id, in case just adding rules to the existing one
      tags                         = optional(map(string)) # A map of tags to assign to the resource.
    })))
  }))
  description = "List of security groups."
  default = [
    {
      default       = false,
      name          = null,
      name_prefix   = null,
      ingress_rules = [{ ip_protocol = null }],
      egress_rules  = [{ ip_protocol = null }],
    },
  ]
}

