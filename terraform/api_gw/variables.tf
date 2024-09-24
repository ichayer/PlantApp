variable "lambda_plants_function_name" {
  type        = string
  description = "Name of the Lambda function for /plants"
}

variable "lambda_plantsById_function_name" {
  type        = string
  description = "Name of the Lambda function for /plants/{plantId}"
}

variable "lambda_plantsByIdWaterings_function_name" {
  type        = string
  description = "Name of the Lambda function for /plants/{plantId}/waterings"
}

variable "plants_invoke_arn" {
  type        = string
  description = "Invoke ARN of the Lambda function for /plants"
}

variable "plantsById_invoke_arn" {
  type        = string
  description = "Invoke ARN of the Lambda function for /plants/{plantId}"
}

variable "plantsByIdWaterings_invoke_arn" {
  type        = string
  description = "Invoke ARN of the Lambda function for /plants/{plantId}/waterings"
}
