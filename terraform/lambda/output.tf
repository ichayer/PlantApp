output "plants" {
  value = {
    get = {
      function_name = aws_lambda_function.getPlants.function_name
      invoke_arn    = aws_lambda_function.getPlants.invoke_arn
    }
    create = {
      function_name = aws_lambda_function.createPlant.function_name
      invoke_arn    = aws_lambda_function.createPlant.invoke_arn
    }
  }
}

output "plantsById" {
  value = {
    get = {
      function_name = aws_lambda_function.getPlantById.function_name
      invoke_arn    = aws_lambda_function.getPlantById.invoke_arn
    }
    delete = {
      function_name = aws_lambda_function.deletePlantById.function_name
      invoke_arn    = aws_lambda_function.deletePlantById.invoke_arn
    }
  }
}

output "plantsByIdWaterings" {
  value = {
    get = {
      function_name = aws_lambda_function.getPlantsByIdWaterings.function_name
      invoke_arn    = aws_lambda_function.getPlantsByIdWaterings.invoke_arn
    }
    create = {
      function_name = aws_lambda_function.createPlantsByIdWaterings.function_name
      invoke_arn    = aws_lambda_function.createPlantsByIdWaterings.invoke_arn
    }
  }
}
