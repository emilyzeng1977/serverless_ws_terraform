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

  dynamic access_log_settings {
    for_each = var.enable_access_log ? [true] : []
    content {
      destination_arn = aws_cloudwatch_log_group.api_gw.arn
      format = jsonencode({
        requestId = "$context.requestId"
        sourceIp = "$context.identity.sourceIp"
        requestTime = "$context.requestTime"
        protocol = "$context.protocol"
        httpMethod = "$context.httpMethod"
        resourcePath = "$context.resourcePath"
        routeKey = "$context.routeKey"
        status = "$context.status"
        responseLength = "$context.responseLength"
        integrationErrorMessage = "$context.integrationErrorMessage"
      })
    }
  }

  dynamic default_route_settings {
    for_each = var.enable_trace_log ? [true] : []
    content {
      data_trace_enabled = true
      logging_level = var.trace_log_level
      detailed_metrics_enabled = true
      throttling_burst_limit = 1000
      throttling_rate_limit = 1000
    }
  }
}
