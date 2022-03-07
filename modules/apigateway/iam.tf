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
