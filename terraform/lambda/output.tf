output "plants_function_name" {
  value = aws_lambda_function.plants.function_name
}

output "plantsById_function_name" {
  value = aws_lambda_function.plantsById.function_name
}

output "plantsByIdWaterings_function_name" {
  value = aws_lambda_function.plantsByIdWaterings.function_name
}

output "plants_invoke_arn" {
  value = aws_lambda_function.plants.invoke_arn
}

output "plantsById_invoke_arn" {
  value = aws_lambda_function.plantsById.invoke_arn
}

output "plantsByIdWaterings_invoke_arn" {
  value = aws_lambda_function.plantsByIdWaterings.invoke_arn
}
