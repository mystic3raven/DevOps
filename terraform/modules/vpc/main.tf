resource "aws_vpc" "main" {
  cidr_block = var.cidr
}

variable "cidr" {
  type    = string
  default = "10.0.0.0/16"
}

output "vpc_id" {
  value = aws_vpc.main.id
}
