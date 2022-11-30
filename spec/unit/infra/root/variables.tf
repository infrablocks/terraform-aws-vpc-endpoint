variable "region" {}

variable "component" {}
variable "deployment_identifier" {}

variable "tags" {
  type = map(string)
  default = null
}
