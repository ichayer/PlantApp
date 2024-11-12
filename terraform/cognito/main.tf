resource "aws_cognito_user_pool" "plant_app_pool" {
  name                     = "plant_app"

  admin_create_user_config {
    allow_admin_create_user_only = false
  }

  username_attributes = ["email"]

  verification_message_template {
    default_email_option = "CONFIRM_WITH_CODE"
    email_subject        = "Account Confirmation"
    email_message        = "Your confirmation code is {####}"
  }

  auto_verified_attributes = ["email"]

  lambda_config {
    post_confirmation = var.suscribe_user_email_lambda.invoke_arn
  }
}

# Authorize cognito to call lambda
resource "aws_lambda_permission" "allow_cognito_invoke" {
  statement_id  = "AllowExecutionFromCognito"
  action        = "lambda:InvokeFunction"
  function_name = var.suscribe_user_email_lambda.function_name
  principal     = "cognito-idp.amazonaws.com"
  source_arn    = aws_cognito_user_pool.plant_app_pool.arn
}

resource "aws_cognito_user_pool_domain" "main" {
  domain       = var.user_pool_domain
  user_pool_id = aws_cognito_user_pool.plant_app_pool.id
}

resource "aws_cognito_user_pool_client" "plant_app_client" {
  name                                 = "my-app-client"
  user_pool_id                         = aws_cognito_user_pool.plant_app_pool.id
  prevent_user_existence_errors        = "ENABLED"
  supported_identity_providers         = ["COGNITO"]

    explicit_auth_flows = [
    "ALLOW_REFRESH_TOKEN_AUTH",
    "ALLOW_USER_PASSWORD_AUTH",
    "ALLOW_ADMIN_USER_PASSWORD_AUTH",
    "ALLOW_CUSTOM_AUTH",
    "ALLOW_USER_SRP_AUTH"
  ]

  depends_on = [
    aws_cognito_user_pool.plant_app_pool,
    aws_cognito_user_pool_domain.main
  ]
}