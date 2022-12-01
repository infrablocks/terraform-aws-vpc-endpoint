module "vpc_endpoint" {
  source = "../../"

  region = var.region

  component = var.component
  deployment_identifier = var.deployment_identifier

  vpc_id = module.base_network.vpc_id

  vpc_endpoint_service_common_name = 'execute-api'
  vpc_endpoint_type = 'Interface'
  vpc_endpoint_subnet_ids = module.base_network.private_subnet_ids
}
