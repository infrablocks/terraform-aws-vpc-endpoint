resource "aws_vpc_endpoint" "vpc_endpoint" {
  vpc_id       = var.vpc_id
  service_name = "com.amazonaws.${var.region}.s3"

  subnet_ids = []
}

#resource "aws_vpc_endpoint_subnet_association" "" {
#
#}

// Use correct service name as requested by module consumer
// Add tags -> component, deployment identifier
// Associate with subnets as requested by module consumer
// ?? Do we need a security group?
// ?? Do we need a policy?
