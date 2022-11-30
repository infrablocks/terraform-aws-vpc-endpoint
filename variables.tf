variable "region" {
  description = "The region into which to deploy the VPC endpoint."
}

variable "component" {
  description = "The component for which the VPC endpoint is being created."
}

variable "deployment_identifier" {
  description = "An identifier for this instantiation."
}

variable "vpc_id" {
  description = "The ID of the VPC in which to deploy a VPC endpoint."
}

variable "tags" {
  description = "Map of tags to be applied to VPC endpoint"
  type        = map(string)
  default     = {}
}

variable "subnet_ids" {
  description = "The ID of one or more subnets in which to create a network interface for the endpoint. Applicable for endpoints of type GatewayLoadBalancer and Interface."
  type        = list(string)
  default     = []
  nullable    = false
}
