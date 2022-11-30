module "vpc_endpoint" {
  source = "../../"

  region = var.region

  component = var.component
  deployment_identifier = var.deployment_identifier

  vpc_id = module.base_network.vpc_id
}
