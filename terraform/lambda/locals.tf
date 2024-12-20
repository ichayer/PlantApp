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
      file    = "getPlantWaterings.js"
      handler = "getPlantWaterings.getPlantWaterings"
      role    = var.labrole_arn
    }
    "createPlantsByIdWaterings" = {
      file    = "createPlantWatering.js"
      handler = "createPlantWatering.createPlantWatering"
      role    = var.labrole_arn
    }
    "processWateringNotification" = {
      file    = "processWateringNotification.js"
      handler = "processWateringNotification.processWateringNotification"
      role    = var.labrole_arn
    }
    "getPresignedURL" = {
      file    = "getPresignedURL.js"
      handler = "getPresignedURL.getPresignedURL"
      role    = var.labrole_arn
    }
    "suscribeUserEmail" = {
      file    = "suscribeUserEmail.js"
      handler = "suscribeUserEmail.suscribeUserEmail"
      role    = var.labrole_arn
    }
  }
}
