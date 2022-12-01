variable "region" {}

variable "component" {}
variable "deployment_identifier" {}

variable "tags" {
  type = map(string)
  default = null
}

variable "vpc_endpoint_subnet_ids" {
  type = list(string)
  default = null
}

variable "vpc_endpoint_service_common_name" {
  default = null
}
variable "vpc_endpoint_service_name" {
  default = null
}
variable "vpc_endpoint_type" {
  default = null
}

variable "enable_private_dns" {
  type = bool
  default = null
}