locals {
  base_tags = {
    Component            = var.component
    DeploymentIdentifier = var.deployment_identifier
  }

  tags = merge(local.base_tags)
}
