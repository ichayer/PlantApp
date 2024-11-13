output "plants" {
  value = {
    get    = {
      function_name = aws_lambda_function.plant_functions["getPlants"].function_name
      invoke_arn    = aws_lambda_function.plant_functions["getPlants"].invoke_arn
    }
    create = {
      function_name = aws_lambda_function.plant_functions["createPlant"].function_name
      invoke_arn    = aws_lambda_function.plant_functions["createPlant"].invoke_arn
    }
  }
}

output "plantsById" {
  value = {
    get = {
      function_name = aws_lambda_function.plant_functions["getPlantById"].function_name
      invoke_arn    = aws_lambda_function.plant_functions["getPlantById"].invoke_arn
    }
    delete = {
      function_name = aws_lambda_function.plant_functions["deletePlantById"].function_name
      invoke_arn    = aws_lambda_function.plant_functions["deletePlantById"].invoke_arn
    }
  }
}

output "plantsByIdWaterings" {
  value = {
    get = {
      function_name = aws_lambda_function.plant_functions["getPlantsByIdWaterings"].function_name
      invoke_arn    = aws_lambda_function.plant_functions["getPlantsByIdWaterings"].invoke_arn
    }
    create = {
      function_name = aws_lambda_function.plant_functions["createPlantsByIdWaterings"].function_name
      invoke_arn    = aws_lambda_function.plant_functions["createPlantsByIdWaterings"].invoke_arn
    }
  }
}

output "getPresignedURL" {
  value = {
    get = {
      function_name = aws_lambda_function.plant_functions["getPresignedURL"].function_name
      invoke_arn    = aws_lambda_function.plant_functions["getPresignedURL"].invoke_arn
    }
  }
}

output "suscribeUserEmail" {
  value = {
    create = {
      function_name = aws_lambda_function.plant_functions["suscribeUserEmail"].function_name
      invoke_arn    = aws_lambda_function.plant_functions["suscribeUserEmail"].arn
    }
  }
}

output "processWateringNotification" {
  value = {
    create = {
      function_name = aws_lambda_function.plant_functions["processWateringNotification"].function_name
      invoke_arn    = aws_lambda_function.plant_functions["processWateringNotification"].arn
    }
  }
}