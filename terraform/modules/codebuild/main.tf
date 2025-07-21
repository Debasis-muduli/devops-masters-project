resource "aws_codebuild_project" "build" {
  name          = "${var.project_name}-build"
  description   = "CodeBuild project for ${var.project_name}"
  service_role  = var.codebuild_role_arn

  artifacts {
    type = "CODEPIPELINE"
  }

  environment {
    compute_type                = "BUILD_GENERAL1_SMALL"
    image                       = "aws/codebuild/standard:5.0"
    type                        = "LINUX_CONTAINER"
    privileged_mode             = true
  }

  source {
    type = "CODEPIPELINE"
    buildspec = var.buildspec_content
  }

  cache {
    type = "NO_CACHE"
  }
}