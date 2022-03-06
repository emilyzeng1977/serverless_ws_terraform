resource "aws_apigatewayv2_stage" "this" {
  api_id          = "${var.api_id}"
  name            = "${var.stage_name}"
  stage_variables = "${var.stage_variables}"

  auto_deploy = true
}
