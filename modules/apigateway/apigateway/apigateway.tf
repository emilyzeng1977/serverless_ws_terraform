module "apigateway" {
  source = "terraform-aws-modules/apigateway-v2/aws"
  version = "1.5.1"

  name = var.apigateway_name
  description = var.apigateway_description
  protocol_type = var.apigateway_protocol_type
  route_selection_expression = var.apigateway_route_selection_expression

  create_api_domain_name = false
  create_default_stage = false

  integrations  = var.apigateway_integrations
}

# Allow the API Gateway to invoke Lambda function
resource "aws_lambda_permission" "this" {
  for_each = var.lambda_permissions

  statement_id  = "AllowExecutionFromAPIGateway"
  action        = "lambda:InvokeFunction"
  function_name = lookup(each.value, "function_name", null)
  principal     = "apigateway.amazonaws.com"
  source_arn    = "${module.apigateway.apigatewayv2_api_execution_arn}/*/*"

  depends_on = [module.apigateway]
}
