resource "aws_codedeploy_app" "app" {
  name = "${var.project_name}-app"
  compute_platform = "Server"  # Use "ECS" or "Lambda" if needed
}

resource "aws_codedeploy_deployment_group" "group" {
  app_name               = aws_codedeploy_app.app.name
  deployment_group_name  = "${var.project_name}-dg"
  service_role_arn       = var.codedeploy_role_arn

  deployment_style {
    deployment_type = "IN_PLACE"
    deployment_option = "WITHOUT_TRAFFIC_CONTROL"
  }

  ec2_tag_filter {
    key = "Name"
    type = "KEY_AND_VALUE"
    value = var.ec2_tag_value
  }

  auto_rollback_configuration {
    enabled = true
    events  = ["DEPLOYMENT_FAILURE"]
  }
}