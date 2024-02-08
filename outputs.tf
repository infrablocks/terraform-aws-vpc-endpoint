output "vpc_endpoint_id" {
  value = aws_vpc_endpoint.vpc_endpoint.id
}

output "security_group_id" {
  value = aws_security_group.vpc_endpoint.id
}