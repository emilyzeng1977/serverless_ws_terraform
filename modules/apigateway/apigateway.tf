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
