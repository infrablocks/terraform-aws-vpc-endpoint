resource "aws_vpc_endpoint" "vpc_endpoint" {
  vpc_id       = var.vpc_id
  service_name = "com.amazonaws.${var.region}.s3"

  subnet_ids = []

  tags = local.tags
}

resource "aws_vpc_endpoint_subnet_association" "vpc_endpoint_subnet_association" {
  for_each = toset(var.subnet_ids)

  vpc_endpoint_id = aws_vpc_endpoint.vpc_endpoint.vpc_id
  subnet_id = each.key
}

// Use correct service name as requested by module consumer
// ?? Do we need a security group?
// ?? Do we need a policy?
