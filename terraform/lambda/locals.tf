locals {
  lambda_functions = {
    "getPlants" = {
      handler   = "plants.getPlants"
      role      = var.labrole_arn
    }
    "createPlant" = {
      handler   = "plants.createPlant"
      role      = var.labrole_arn
    }
    "getPlantById" = {
      handler   = "plantsById.getPlantById"
      role      = var.labrole_arn
    }
    "deletePlantById" = {
      handler   = "plantsById.deletePlantById"
      role      = var.labrole_arn
    }
    "getPlantsByIdWaterings" = {
      handler   = "plantsByIdWaterings.getPlantWaterings"
      role      = var.labrole_arn
    }
    "createPlantsByIdWaterings" = {
      handler   = "plantsByIdWaterings.createPlantWatering"
      role      = var.labrole_arn
    }
  }
}