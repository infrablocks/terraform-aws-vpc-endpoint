// noinspection ConflictingProperties
data "aws_vpc_endpoint_service" "vpc_endpoint_service" {
  count = var.vpc_endpoint_service_name == null ? 1 : 0

  service      = var.vpc_endpoint_service_common_name
  service_type = var.vpc_endpoint_type
}

resource "aws_vpc_endpoint" "vpc_endpoint" {
  vpc_id       = var.vpc_id
  vpc_endpoint_type = var.vpc_endpoint_type

  service_name = var.vpc_endpoint_service_name == null ? data.aws_vpc_endpoint_service.vpc_endpoint_service[0].service_name : var.vpc_endpoint_service_name

  private_dns_enabled = var.enable_private_dns

  tags = merge(local.tags, {
    Name: "vpce-${var.component}-${var.deployment_identifier}"
  })
}
