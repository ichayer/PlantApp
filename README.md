# PlantApp
A cloud solution for taking care of your plants.

## FrontEnd
The front-end consists of a React app deployed in an S3 bucket.

## Backend
The back-end consists of lambda functions written in JavaScript, accessible via an API Gateway.

## Terraform deployment
PlantApp can be fully deployed with Terraform. Terraform will create all the AWS resources necessary, and will also run scripts for building and packaging the required code before deploying it.

Due to these scripts, **the terraform deployment must be run on Linux**. This is confirmed to work on Ubuntu 22.04 LTS.

### Requirements
- [Terraform](https://developer.hashicorp.com/terraform/install)
- The [AWS CLI](https://docs.aws.amazon.com/cli/latest/userguide/getting-started-install.html)
- [npm](https://docs.npmjs.com/downloading-and-installing-node-js-and-npm), and [Node 18](https://nodejs.org/en)
    - We recommend using [nvm](https://github.com/nvm-sh/nvm?tab=readme-ov-file#installing-and-updating) to install these:
    - `curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.1/install.sh | bash`
    - Once that's done, open a new terminal (existing terminals won't recognize nvm), and run `nvm install 18`
- The `zip` apt package, installable with `sudo apt install zip`

### Getting started
Once all the requirements have been installed, deploy the project by following these steps:
1. Ensure you have your AWS CLI credentials ready in `~/.aws/credentials`
    - Note: some of the scripts within terraform will invoke the AWS CLI manually
2. Fill in the terraform variables at `PlantApp/terraform/terraform.tfvars`
    - We have provided an example `terraform.tfvars-sample` file
3. Initialize and run terraform in the `terraform` directory
    - cd into the directory: `cd terraform`
    - Initialize Terraform on the directory: `terraform init`
    - Generate an execution plan and review: `terraform plan`
    - Apply changes on the infrastructure: `terraform apply`
