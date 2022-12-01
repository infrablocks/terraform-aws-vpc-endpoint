data "terraform_remote_state" "prerequisites" {
  backend = "local"

  config = {
    path = "${path.module}/../../../../state/prerequisites.tfstate"
  }
}

module "vpc_endpoint" {
  source = "../../../.."

  region = var.region

  component = var.component
  deployment_identifier = var.deployment_identifier

  vpc_id = data.terraform_remote_state.prerequisites.outputs.vpc_id

  vpc_endpoint_type = var.vpc_endpoint_type
  vpc_endpoint_subnet_ids = var.vpc_endpoint_subnet_ids
  vpc_endpoint_service_common_name = var.vpc_endpoint_service_common_name
  vpc_endpoint_service_name = var.vpc_endpoint_service_name

  enable_private_dns = var.enable_private_dns

  tags = var.tags
}
