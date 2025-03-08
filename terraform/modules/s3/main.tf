resource "aws_s3_bucket" "bucket" {
  bucket = var.bucket_name
}

variable "bucket_name" {
  type = string
}

output "bucket_id" {
  value = aws_s3_bucket.bucket.id
}
