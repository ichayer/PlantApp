resource "aws_api_gateway_rest_api" "planty_api" {
  name        = "planty-API"
  description = "API Gateway"
}

resource "aws_api_gateway_resource" "plants" {
  rest_api_id = aws_api_gateway_rest_api.planty_api.id
  parent_id   = aws_api_gateway_rest_api.planty_api.root_resource_id
  path_part   = "plants"
}

resource "aws_api_gateway_method" "plants_method" {
  rest_api_id   = aws_api_gateway_rest_api.planty_api.id
  resource_id   = aws_api_gateway_resource.plants.id
  http_method   = "ANY"
  authorization = "NONE"
}

resource "aws_api_gateway_integration" "plants_integration" {
  rest_api_id = aws_api_gateway_rest_api.planty_api.id
  resource_id = aws_api_gateway_resource.plants.id
  http_method = aws_api_gateway_method.plants_method.http_method
  integration_http_method = "ANY"
  type                    = "AWS_PROXY"
  uri                     = var.plants_invoke_arn
}

resource "aws_api_gateway_resource" "plant_by_id" {
  rest_api_id = aws_api_gateway_rest_api.planty_api.id
  parent_id   = aws_api_gateway_resource.plants.id
  path_part   = "{plantId}"
}

resource "aws_api_gateway_method" "plant_by_id_method" {
  rest_api_id   = aws_api_gateway_rest_api.planty_api.id
  resource_id   = aws_api_gateway_resource.plant_by_id.id
  http_method   = "ANY"
  authorization = "NONE"
}

resource "aws_api_gateway_integration" "plant_by_id_integration" {
  rest_api_id = aws_api_gateway_rest_api.planty_api.id
  resource_id = aws_api_gateway_resource.plant_by_id.id
  http_method = aws_api_gateway_method.plant_by_id_method.http_method
  integration_http_method = "ANY"
  type                    = "AWS_PROXY"
  uri                     = var.plantsById_invoke_arn
}

resource "aws_api_gateway_resource" "plant_waterings" {
  rest_api_id = aws_api_gateway_rest_api.planty_api.id
  parent_id   = aws_api_gateway_resource.plant_by_id.id
  path_part   = "waterings"
}

resource "aws_api_gateway_method" "plant_waterings_method" {
  rest_api_id   = aws_api_gateway_rest_api.planty_api.id
  resource_id   = aws_api_gateway_resource.plant_waterings.id
  http_method   = "ANY"
  authorization = "NONE"
}

resource "aws_api_gateway_integration" "plant_waterings_integration" {
  rest_api_id = aws_api_gateway_rest_api.planty_api.id
  resource_id = aws_api_gateway_resource.plant_waterings.id
  http_method = aws_api_gateway_method.plant_waterings_method.http_method
  integration_http_method = "ANY"
  type                    = "AWS_PROXY"
  uri                     = var.plantsByIdWaterings_invoke_arn
}
