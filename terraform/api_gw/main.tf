resource "aws_apigatewayv2_api" "planty_http_api" {
  name          = "planty-http-api"
  protocol_type = "HTTP"

  cors_configuration {
    allow_headers = ["*"]
    allow_methods = ["*"]
    allow_origins = ["*"]
    max_age       = 86400
  }
}

resource "aws_apigatewayv2_stage" "default" {
  api_id      = aws_apigatewayv2_api.planty_http_api.id
  name        = "$default"
  auto_deploy = true
}

resource "aws_apigatewayv2_route" "plants_route" {
  api_id    = aws_apigatewayv2_api.planty_http_api.id
  route_key = "ANY /plants"
  target    = "integrations/${aws_apigatewayv2_integration.plants_integration.id}"
}

resource "aws_apigatewayv2_route" "plant_by_id_route" {
  api_id    = aws_apigatewayv2_api.planty_http_api.id
  route_key = "ANY /plants/{plantId}"
  target    = "integrations/${aws_apigatewayv2_integration.plant_by_id_integration.id}"
}

resource "aws_apigatewayv2_route" "plant_waterings_route" {
  api_id    = aws_apigatewayv2_api.planty_http_api.id
  route_key = "ANY /plants/{plantId}/waterings"
  target    = "integrations/${aws_apigatewayv2_integration.plant_waterings_integration.id}"
}

resource "aws_apigatewayv2_integration" "plants_integration" {
  api_id                  = aws_apigatewayv2_api.planty_http_api.id
  integration_type         = "AWS_PROXY"
  integration_uri          = var.plants_invoke_arn
  integration_method       = "POST"
  payload_format_version   = "2.0"
}

resource "aws_apigatewayv2_integration" "plant_by_id_integration" {
  api_id                  = aws_apigatewayv2_api.planty_http_api.id
  integration_type         = "AWS_PROXY"
  integration_uri          = var.plantsById_invoke_arn
  integration_method       = "POST"
  payload_format_version   = "2.0"
}

resource "aws_apigatewayv2_integration" "plant_waterings_integration" {
  api_id                  = aws_apigatewayv2_api.planty_http_api.id
  integration_type         = "AWS_PROXY"
  integration_uri          = var.plantsByIdWaterings_invoke_arn
  integration_method       = "POST"
  payload_format_version   = "2.0"
}