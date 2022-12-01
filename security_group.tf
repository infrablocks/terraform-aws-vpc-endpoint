resource "aws_security_group" "vpc_endpoint" {
  name        = "${var.component}-${var.deployment_identifier}-vpc-endpoint"
  description = "VPC endpoint security group for: ${var.component}, deployment: ${var.deployment_identifier}"
  vpc_id      = var.vpc_id

  tags = local.tags
}

data "aws_vpc" "vpc" {
  id = var.vpc_id
}

resource "aws_security_group_rule" "cluster_default_ingress" {
  type = "ingress"

  security_group_id = aws_security_group.vpc_endpoint.id

  protocol  = "-1"
  from_port = 0
  to_port   = 0

  cidr_blocks = [data.aws_vpc.vpc.cidr_block]
}

resource "aws_security_group_rule" "cluster_default_egress" {
  type = "egress"

  security_group_id = aws_security_group.vpc_endpoint.id

  protocol  = "-1"
  from_port = 0
  to_port   = 0

  cidr_blocks = ["0.0.0.0/0"]
}
