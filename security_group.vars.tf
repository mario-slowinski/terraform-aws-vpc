variable "security_groups" {
  type = list(object({
    description            = optional(string)      # Security group description.
    name_prefix            = optional(string)      # Creates a unique name beginning with the specified prefix.
    name                   = optional(string)      # Name of the security group.
    revoke_rules_on_delete = optional(bool)        # Instruct Terraform to revoke all of the Security Groups attached ingress and egress rules before deleting the rule itself.
    vpc_id                 = optional(string)      # VPC ID. Defaults to the region's default VPC.
    tags                   = optional(map(string)) # Map of tags to assign to the resource.
  }))
  description = "List of security groups."
  default     = [{ name = null, name_prefix = null }]
}

