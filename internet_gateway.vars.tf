variable "internet_gateways" {
  type = list(object({
    name   = string                # Internet gateway name
    vpc_id = optional(string)      # VPC id
    tags   = optional(map(string)) # A map of tags to assign to the resource.
  }))
  description = "List of Internet Gateways."
  default     = [{ name = null }]
}
