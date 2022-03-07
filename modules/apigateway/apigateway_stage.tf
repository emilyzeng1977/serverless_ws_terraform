resource "aws_apigatewayv2_stage" "this" {
  for_each = var.apigateway_stages

  api_id          = module.apigateway.apigatewayv2_api_id
  name            = each.key

  stage_variables = lookup(each.value, "has_default_varibles", false) ? merge(lookup(each.value, "stage_variables", {}), {
    WEBSOCKETUI_APIG_STAGE = each.key
    WEBSOCKETUI_APIG_ENDPOINT = replace(module.apigateway.apigatewayv2_api_api_endpoint, "wss://", "")
  }) : lookup(each.value, "stage_variables", {})

  auto_deploy = true

  depends_on = [module.apigateway]
}
