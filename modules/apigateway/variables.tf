# --- API Gateway ---
variable "apigateway_name" {
  description = "API Gateway name"
}

variable "apigateway_description" {
  description = "API Gateway description"
  default = "API Gateway (POC)"
}

variable "apigateway_protocol_type" {
  description = "API Gateway protocol type"
  default = "WEBSOCKET"
}

variable "apigateway_route_selection_expression" {
  description = "API Gateway route selection expression"
  default = "$request.body.action"
}

variable "apigateway_integrations" {
  description = "API Gateway integrations"
  type = any
  default = {}
}

# --- API Gateway IAM ---
variable "lambda_permissions" {
  description = "API Gateway Lambda permisions"
  type = any
  default = {}
}

# --- API Gateway Stage ---
variable "apigateway_stages" {
  description = "API Gateway Lambda permisions"
  type = any
  default = {}
}


