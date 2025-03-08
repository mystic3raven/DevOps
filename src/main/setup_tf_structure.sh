#!/bin/bash

# Define the root Terraform directory
ROOT_DIR="terraform_project"

# Define subdirectories
MODULES_DIR="$ROOT_DIR/modules"
ENV_DIR="$ROOT_DIR/environments"
CI_CD_DIR="$ROOT_DIR/.github/workflows"

# Create main Terraform directories
mkdir -p "$ROOT_DIR"
mkdir -p "$MODULES_DIR/vpc"
mkdir -p "$MODULES_DIR/security-groups"
mkdir -p "$MODULES_DIR/eks"
mkdir -p "$MODULES_DIR/s3"
mkdir -p "$ENV_DIR/dev"
mkdir -p "$ENV_DIR/prod"
mkdir -p "$CI_CD_DIR"

# Create main Terraform files
touch "$ROOT_DIR/main.tf"
touch "$ROOT_DIR/variables.tf"
touch "$ROOT_DIR/outputs.tf"
touch "$ROOT_DIR/providers.tf"

# Create module files
for module in vpc security-groups eks s3; do
    touch "$MODULES_DIR/$module/main.tf"
    touch "$MODULES_DIR/$module/variables.tf"
    touch "$MODULES_DIR/$module/outputs.tf"
done

# Create environment-specific files
for env in dev prod; do
    touch "$ENV_DIR/$env/backend.tf"
    touch "$ENV_DIR/$env/terraform.tfvars"
done

# Create GitHub Actions CI/CD pipeline file
echo "Creating GitHub Actions workflow..."
cat <<EOL > "$CI_CD_DIR/terraform.yml"
name: Terraform CI/CD

on:
  push:
    branches:
      - main
  pull_request:
    branches:
      - main

jobs:
  terraform:
    name: Terraform Deploy
    runs-on: ubuntu-latest

    permissions:
      id-token: write
      contents: read

    steps:
      - name: Checkout repository
        uses: actions/checkout@v3

      - name: Setup Terraform
        uses: hashicorp/setup-terraform@v2

      - name: Terraform Format
        run: terraform fmt -check

      - name: Terraform Init
        run: terraform init

      - name: Terraform Validate
        run: terraform validate

      - name: Terraform Plan
        run: terraform plan -out=tfplan
        env:
          AWS_ACCESS_KEY_ID: \${{ secrets.AWS_ACCESS_KEY_ID }}
          AWS_SECRET_ACCESS_KEY: \${{ secrets.AWS_SECRET_ACCESS_KEY }}

      - name: Terraform Apply
        if: github.ref == 'refs/heads/main'
        run: terraform apply -auto-approve tfplan
        env:
          AWS_ACCESS_KEY_ID: \${{ secrets.AWS_ACCESS_KEY_ID }}
          AWS_SECRET_ACCESS_KEY: \${{ secrets.AWS_SECRET_ACCESS_KEY }}
EOL

echo "Terraform project structure created successfully."
