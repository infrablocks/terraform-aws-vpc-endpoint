// ?? Do we need a security group?
// ?? Do we need a policy?

// noinspection ConflictingProperties
data "aws_vpc_endpoint_service" "vpc_endpoint_service" {
  count = var.vpc_endpoint_service_name == null ? 1 : 0

  service      = var.vpc_endpoint_service_common_name
  service_type = var.vpc_endpoint_type
}

resource "aws_vpc_endpoint" "vpc_endpoint" {
  vpc_id       = var.vpc_id
  service_name = var.vpc_endpoint_service_name == null ? data.aws_vpc_endpoint_service.vpc_endpoint_service[0].service_name : var.vpc_endpoint_service_name
  vpc_endpoint_type = var.vpc_endpoint_type

  tags = local.tags
}

resource "aws_vpc_endpoint_subnet_association" "vpc_endpoint_subnet_association" {
  for_each = toset(var.vpc_endpoint_subnet_ids)

  vpc_endpoint_id = aws_vpc_endpoint.vpc_endpoint.vpc_id
  subnet_id = each.key
}
