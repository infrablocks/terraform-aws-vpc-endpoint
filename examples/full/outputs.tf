output "vpc_endpoint_id" {
  value = module.vpc_endpoint.vpc_endpoint_id
}

output "vpc_id" {
  value = module.base_network.vpc_id
}

output "vpc_cidr" {
  value = module.base_network.vpc_cidr
}

output "public_subnet_ids" {
  value = module.base_network.public_subnet_ids
}

output "private_subnet_ids" {
  value = module.base_network.private_subnet_ids
}

output "security_group_id" {
  value = module.vpc_endpoint.security_group_id
}
