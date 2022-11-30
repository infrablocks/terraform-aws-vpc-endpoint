resource "aws_vpc_endpoint" "vpc_endpoint" {
  vpc_id       = var.vpc_id
  service_name = "com.amazonaws.${var.region}.s3"
}
