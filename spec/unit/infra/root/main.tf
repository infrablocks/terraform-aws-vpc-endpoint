data "terraform_remote_state" "prerequisites" {
  backend = "local"

  config = {
    path = "${path.module}/../../../../state/prerequisites.tfstate"
  }
}

module "api_gateway" {
  source = "../../../.."

  region = var.region

  component = var.component
  deployment_identifier = var.deployment_identifier

  tags = var.tags

  vpc_id = data.terraform_remote_state.prerequisites.outputs.vpc_id
}
