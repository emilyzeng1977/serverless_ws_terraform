# --- API Gateway Stage ---
variable "api_id" {
  description = "API Gateway ID"
}

variable "stage_name" {
  description = "Stage name"
}

variable "stage_variables" {
  description = "Stage variables"
  type = map(string)
}
