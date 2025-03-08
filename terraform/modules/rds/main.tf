resource "aws_db_instance" "rds" {
  identifier = var.db_name
}

variable "db_name" {
  type = string
}

output "rds_id" {
  value = aws_db_instance.rds.id
}
