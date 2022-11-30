variable "region" {}

variable "component" {}
variable "deployment_identifier" {}

variable "tags" {
  type = map(string)
  default = null
}

variable "subnet_ids" {
  type = list(string)
  default = null
}

variable "service" {
  default = "s3"
}
variable "service_type" {
  default = "Gateway"
}
