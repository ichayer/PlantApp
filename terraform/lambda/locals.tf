locals {
  lambda_functions = {
    "getPlants" = {
      file    = "getPlants.js"
      handler = "getPlants.getPlants"
      role    = var.labrole_arn
    }
    "createPlant" = {
      file    = "createPlant.js"
      handler = "createPlant.createPlant"
      role    = var.labrole_arn
    }
    "getPlantById" = {
      file    = "getPlantById.js"
      handler = "getPlantById.getPlantById"
      role    = var.labrole_arn
    }
    "deletePlantById" = {
      file    = "deletePlantById.js"
      handler = "deletePlantById.deletePlantById"
      role    = var.labrole_arn
    }
    "getPlantsByIdWaterings" = {
      file    = "getPlantsByIdWaterings.js"
      handler = "getPlantsByIdWaterings.getPlantWaterings"
      role    = var.labrole_arn
    }
    "createPlantsByIdWaterings" = {
      file    = "createPlantsByIdWaterings.js"
      handler = "createPlantsByIdWaterings.createPlantWatering"
      role    = var.labrole_arn
    }
  }
}
