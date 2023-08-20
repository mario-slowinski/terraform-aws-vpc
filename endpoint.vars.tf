variable "endpoints" {
  type = list(object({
    service_name        = string           # The service name. For AWS services the service name is usually in the form com.amazonaws.<region>.<service>.
    vpc_id              = optional(string) # The ID of the VPC in which the endpoint will be used. Use the one from module if not given.
    auto_accept         = optional(bool)   # Accept the VPC endpoint (the VPC endpoint and service need to be in the same AWS account).
    policy              = optional(string) # A policy to attach to the endpoint that controls access to the service. This is a JSON formatted string. Defaults to full access.
    private_dns_enabled = optional(bool)   # Whether or not to associate a private hosted zone with the specified VPC.
    dns_options = optional(object({
      dns_record_ip_type                             = optional(string) # The DNS records created for the endpoint. Valid values are ipv4, dualstack, service-defined, and ipv6.
      private_dns_only_for_inbound_resolver_endpoint = optional(bool)   # Indicates whether to enable private DNS only for inbound endpoints.
    }))
    ip_address_type    = optional(string)       # The IP address type for the endpoint. Valid values are ipv4, dualstack, and ipv6.
    route_table_ids    = optional(list(string)) # One or more route table IDs. Applicable for endpoints of type Gateway.
    subnet_ids         = optional(list(string)) # The ID of one or more subnets in which to create a network interface for the endpoint. Applicable for endpoints of type GatewayLoadBalancer and Interface.
    security_group_ids = optional(list(string)) # The ID of one or more security groups to associate with the network interface. Applicable for endpoints of type Interface.
    tags               = optional(map(string))  # A map of tags to assign to the resource.
    vpc_endpoint_type  = string                 # The VPC endpoint type, Gateway, GatewayLoadBalancer, or Interface.
  }))
  description = "VPC Endpoint"
  default = [{
    service_name      = null
    vpc_endpoint_type = null
  }]
}
