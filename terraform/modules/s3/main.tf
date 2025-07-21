resource "aws_s3_bucket" "artifacts" {
  bucket = "${var.project_name}-artifact-bucket"
  force_destroy = true
}

resource "aws_s3_bucket_versioning" "versioning" {
  bucket = aws_s3_bucket.artifacts.id
  versioning_configuration {
    status = "Enabled"
  }
}