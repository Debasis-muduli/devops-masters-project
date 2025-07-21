terraform {
  backend "s3" {
    bucket = "terraform-task1-bucket-1"
    key    = "codepipeline/terraform.tfstate"
    region = "us-east-1"
  }
}
