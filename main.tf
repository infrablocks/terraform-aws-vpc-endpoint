data "aws_vpc_endpoint_service" "s3" {
  service      = var.service
  service_type = var.service_type
}

resource "aws_vpc_endpoint" "vpc_endpoint" {
  vpc_id       = var.vpc_id
  service_name = data.aws_vpc_endpoint_service.s3.service_name

  subnet_ids = []

  tags = local.tags
}

resource "aws_vpc_endpoint_subnet_association" "vpc_endpoint_subnet_association" {
  for_each = toset(var.subnet_ids)

  vpc_endpoint_id = aws_vpc_endpoint.vpc_endpoint.vpc_id
  subnet_id = each.key
}

// ?? Do we need a security group?
// ?? Do we need a policy?
