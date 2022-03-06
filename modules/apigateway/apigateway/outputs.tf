output "apigatewayv2_api_id" {
  description = "apigatewayv2_api_id"
  value       = module.apigateway.apigatewayv2_api_id
}

output "apigatewayv2_api_api_endpoint" {
  description = "The URI of the API"
  value       = module.apigateway.apigatewayv2_api_api_endpoint
}

output "apigatewayv2_api_arn" {
  description = "The ARN of the API"
  value       = module.apigateway.apigatewayv2_api_arn
}

//output "apigatewayv2_execution_arn" {
//  description = "The ARN of the API"
//  value       = module.apigateway.apigatewayv2_execution_arn
//}


