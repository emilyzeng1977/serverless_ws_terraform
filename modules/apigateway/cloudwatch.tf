resource "aws_cloudwatch_log_group" "api_gw" {
  name              = "/aws/apigateway/${var.apigateway_name}"
  retention_in_days = 7
}

