resource "aws_iam_role" "role" {
  name = var.role_name
}

variable "role_name" {
  type = string
}

output "role_id" {
  value = aws_iam_role.role.id
}
