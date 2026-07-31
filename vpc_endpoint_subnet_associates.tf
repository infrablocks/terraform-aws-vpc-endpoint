resource "aws_vpc_endpoint_subnet_association" "vpc_endpoint_subnet_association" {
  count = length(var.vpc_endpoint_subnet_ids)

  vpc_endpoint_id = aws_vpc_endpoint.vpc_endpoint.id
  subnet_id = var.vpc_endpoint_subnet_ids[count.index]
}
