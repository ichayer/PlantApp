# PlantApp
A cloud solution for taking care of your plants

## FrontEnd
There lies the React app

## Backend
Handlers for lambda functions developed in JavaScript

## Terraform deployment
### Requirements
- [Terraform](https://developer.hashicorp.com/terraform/install)

### Getting started
To automate AWS infrastructure deployment using Terraform, follow these steps:
1. Ensure your project root directory contains the following files:
   - `aws_credentials`: File containing AWS credentials. Obtain these from your AWS account under "AWS Details" > "Show" next to AWS CLI.
   - `terraform.tfvars`: Configuration file with parameters.

2. Run Terraform commands

    ```bash
    # Initialize Terraform to set up your working directory
    > terraform init
    ```

    ```bash
    # Generate an execution plan. Review proposed changes before applying
    > terraform plan
    ```

    ```bash
    # Apply changes to create or update infrastructure based on the execution plan
    > terrform apply
    ```

    ```bash
    # Destroy the infrastructure provisioned by Terraform
    > terraform destroy
    ```
