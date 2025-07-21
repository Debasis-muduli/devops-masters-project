resource "aws_s3_bucket" "artifacts" {
  bucket = "${var.project_name}-artifacts"
  force_destroy = true
}
module "iam" {
  source = "./modules/iam"
}
module "s3" {
  source        = "./modules/s3"
  project_name  = var.project_name
}

module "codebuild" {
  source              = "./modules/codebuild"
  project_name        = var.project_name
  codebuild_role_arn  = module.iam.codebuild_role_arn
  buildspec_content   = <<EOF
version: 0.2

phases:
  install:
    commands:
      - echo Installing...
  build:
    commands:
      - echo Building...
artifacts:
  files:
    - '/*'
EOF
}


module "codepipeline" {
  source                  = "./modules/codepipeline"
  project_name            = var.project_name
  artifact_bucket         = module.s3.artifact_bucket
  codepipeline_role_arn   = module.iam.codepipeline_role_arn
  codebuild_project_name  = module.codebuild.codebuild_project_name
  codedeploy_app_name     = module.codedeploy.codedeploy_app_name
  codedeploy_group_name   = module.codedeploy.deployment_group_name
  github_owner            = "your-github-username"
  github_repo             = "your-repo-name"
  github_branch           = "main"
  github_token            = var.github_token
}