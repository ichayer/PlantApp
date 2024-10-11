resource "aws_lambda_function" "getPlants" {
  function_name = "getPlants"
  role          = var.labrole_arn
  handler       = "plants.getPlants"
  runtime       = "nodejs18.x"

  environment {
        variables = {
            DB_NAME     = "postgres"
            DB_USER     = var.db_username
            DB_PASSWORD = var.db_password
            DB_HOST     = var.proxy_host
            DB_PORT     = var.db_port
        }
    }

  filename = "${path.root}/../backend/lambdas.zip"

  
  vpc_config {
    security_group_ids = [var.security_group_id]
    subnet_ids         = var.lambda_subnet_ids
  }
}

resource "aws_lambda_function" "createPlant" {
  function_name = "createPlant"
  role          = var.labrole_arn
  handler       = "plants.createPlant"
  runtime       = "nodejs18.x"

  environment {
        variables = {
            DB_NAME     = "postgres"
            DB_USER     = var.db_username
            DB_PASSWORD = var.db_password
            DB_HOST     = var.proxy_host
            DB_PORT     = var.db_port
        }
    }

  filename = "${path.root}/../backend/lambdas.zip"

  
  vpc_config {
    security_group_ids = [var.security_group_id]
    subnet_ids         = var.lambda_subnet_ids
  }
}

resource "aws_lambda_function" "getPlantById" {
  function_name = "getPlantById"
  role          = var.labrole_arn
  handler       = "plantsById.getPlantById"
  runtime       = "nodejs18.x"

  environment {
        variables = {
            DB_NAME     = "postgres"
            DB_USER     = var.db_username
            DB_PASSWORD = var.db_password
            DB_HOST     = var.proxy_host
            DB_PORT     = var.db_port
        }
    }

  filename = "${path.root}/../backend/lambdas.zip"

  vpc_config {
    security_group_ids = [var.security_group_id]
    subnet_ids         = var.lambda_subnet_ids
  }
}

resource "aws_lambda_function" "deletePlantById" {
  function_name = "deletePlantById"
  role          = var.labrole_arn
  handler       = "plantsById.deletePlantById"
  runtime       = "nodejs18.x"

  environment {
        variables = {
            DB_NAME     = "postgres"
            DB_USER     = var.db_username
            DB_PASSWORD = var.db_password
            DB_HOST     = var.proxy_host
            DB_PORT     = var.db_port
        }
    }

  filename = "${path.root}/../backend/lambdas.zip"

  vpc_config {
    security_group_ids = [var.security_group_id]
    subnet_ids         = var.lambda_subnet_ids
  }
}

resource "aws_lambda_function" "getPlantsByIdWaterings" {
  function_name = "getPlantsByIdWaterings"
  role          = var.labrole_arn
  handler       = "plantsByIdWaterings.getPlantWaterings"
  runtime       = "nodejs18.x"

  environment {
        variables = {
            DB_NAME     = "postgres"
            DB_USER     = var.db_username
            DB_PASSWORD = var.db_password
            DB_HOST     = var.proxy_host
            DB_PORT     = var.db_port
        }
    }

  filename = "${path.root}/../backend/lambdas.zip"

  vpc_config {
    security_group_ids = [var.security_group_id]
    subnet_ids         = var.lambda_subnet_ids
  }
}

resource "aws_lambda_function" "createPlantsByIdWaterings" {
  function_name = "createPlantsByIdWaterings"
  role          = var.labrole_arn
  handler       = "plantsByIdWaterings.createPlantWatering"
  runtime       = "nodejs18.x"

  environment {
        variables = {
            DB_NAME     = "postgres"
            DB_USER     = var.db_username
            DB_PASSWORD = var.db_password
            DB_HOST     = var.proxy_host
            DB_PORT     = var.db_port
        }
    }

  filename = "${path.root}/../backend/lambdas.zip"

  vpc_config {
    security_group_ids = [var.security_group_id]
    subnet_ids         = var.lambda_subnet_ids
  }
}
