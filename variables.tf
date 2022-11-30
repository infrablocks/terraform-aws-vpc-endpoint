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