variable "user_pool_domain" {
  description = "Cognito user pool domain"
  type        =  string
}

variable "suscribe_user_email_lambda" {
  type = object({
    function_name = string
    invoke_arn    = string
  })
  description = "The function name and invocation ARN of the suscribe user email in SNS lambda"
}