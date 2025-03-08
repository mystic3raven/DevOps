resource "aws_eks_cluster" "cluster" {
  name = var.cluster_name
}

variable "cluster_name" {
  type = string
}

output "eks_id" {
  value = aws_eks_cluster.cluster.id
}
