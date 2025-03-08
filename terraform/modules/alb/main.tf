resource "aws_lb" "alb" {
  name               = var.alb_name
  load_balancer_type = "application"
}

variable "alb_name" {
  type = string
}

output "alb_id" {
  value = aws_lb.alb.id
}
