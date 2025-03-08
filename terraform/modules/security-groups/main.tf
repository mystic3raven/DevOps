resource "aws_security_group" "sg" {
  vpc_id = var.vpc_id
}

variable "vpc_id" {
  type = string
}

output "sg_id" {
  value = aws_security_group.sg.id
}
