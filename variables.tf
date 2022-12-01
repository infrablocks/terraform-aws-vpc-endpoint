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

variable "vpc_endpoint_subnet_ids" {
  description = "The ID of one or more subnets in which to create a network interface for the endpoint. Applicable for endpoints of type \"GatewayLoadBalancer\" and \"Interface\"."
  type        = list(string)
  default     = []
  nullable    = false
}
variable "vpc_endpoint_type" {
  description = "The type of the service for which to deploy a VPC endpoint, \"Gateway\", \"GatewayLoadBalancer\" or \"Interface\"."
  default     = "Gateway"
  nullable    = false
}
variable "vpc_endpoint_service_common_name" {
  description = "The common name of an AWS service (e.g., s3). Required unless `vpc_endpoint_service_name` is provided. See https://docs.aws.amazon.com/vpc/latest/privatelink/aws-services-privatelink-support.html for details of available service common names."
  default     = null
}
variable "vpc_endpoint_service_name" {
  description = "The service name of an AWS service, typically of the form \"com.amazonaws.<region>.<service>\". Required unless `vpc_endpoint_service_common_name` is provided. See https://docs.aws.amazon.com/vpc/latest/privatelink/aws-services-privatelink-support.html for details of available service names."
  default = null
}

variable "enable_private_dns" {
  description = "Whether or not to associate a private hosted zone with the specified VPC. Applicable for endpoints of type \"Interface\". Defaults to `false`."
  type = bool
  default = false
  nullable = false
}

variable "tags" {
  description = "Map of tags to be applied to VPC endpoint"
  type        = map(string)
  default     = {}
}
