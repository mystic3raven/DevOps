#!/bin/bash

# Define root Terraform directory
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
mkdir -p "$MODULES_DIR/iam"
mkdir -p "$MODULES_DIR/rds"
mkdir -p "$MODULES_DIR/alb"
mkdir -p "$ENV_DIR/dev"
mkdir -p "$ENV_DIR/prod"
mkdir -p "$CI_CD_DIR"

# Create main Terraform files
touch "$ROOT_DIR/main.tf"
touch "$ROOT_DIR/variables.tf"
touch "$ROOT_DIR/outputs.tf"
touch "$ROOT_DIR/providers.tf"

# Create module files
for module in vpc security-groups eks s3 iam rds alb; do
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

# Populate Terraform files for each module
echo "Creating module Terraform files..."

declare -A MODULE_CONTENTS

MODULE_CONTENTS[vpc]="resource \"aws_vpc\" \"main\" {
  cidr_block = var.cidr
}

variable \"cidr\" {
  type    = string
  default = \"10.0.0.0/16\"
}

output \"vpc_id\" {
  value = aws_vpc.main.id
}"

MODULE_CONTENTS[security-groups]="resource \"aws_security_group\" \"sg\" {
  vpc_id = var.vpc_id
}

variable \"vpc_id\" {
  type = string
}

output \"sg_id\" {
  value = aws_security_group.sg.id
}"

MODULE_CONTENTS[eks]="resource \"aws_eks_cluster\" \"cluster\" {
  name = var.cluster_name
}

variable \"cluster_name\" {
  type = string
}

output \"eks_id\" {
  value = aws_eks_cluster.cluster.id
}"

MODULE_CONTENTS[s3]="resource \"aws_s3_bucket\" \"bucket\" {
  bucket = var.bucket_name
}

variable \"bucket_name\" {
  type = string
}

output \"bucket_id\" {
  value = aws_s3_bucket.bucket.id
}"

MODULE_CONTENTS[iam]="resource \"aws_iam_role\" \"role\" {
  name = var.role_name
}

variable \"role_name\" {
  type = string
}

output \"role_id\" {
  value = aws_iam_role.role.id
}"

MODULE_CONTENTS[rds]="resource \"aws_db_instance\" \"rds\" {
  identifier = var.db_name
}

variable \"db_name\" {
  type = string
}

output \"rds_id\" {
  value = aws_db_instance.rds.id
}"

MODULE_CONTENTS[alb]="resource \"aws_lb\" \"alb\" {
  name               = var.alb_name
  load_balancer_type = \"application\"
}

variable \"alb_name\" {
  type = string
}

output \"alb_id\" {
  value = aws_lb.alb.id
}"

# Write module contents to respective files
for module in "${!MODULE_CONTENTS[@]}"; do
    echo "${MODULE_CONTENTS[$module]}" > "$MODULES_DIR/$module/main.tf"
done

echo "Terraform project structure created successfully."
