# AWS Web Application Infrastructure Terraform Module

## 🚀 Overview

This project provides a **modular, scalable, and production-ready infrastructure** for deploying a web application on AWS using **Terraform**. The infrastructure includes a Virtual Private Cloud (VPC), Application Load Balancer (ALB), Auto Scaling Group (ASG) for EC2 instances, an RDS database cluster, and optional ElastiCache integration. The design follows best practices for high availability, scalability, and security.

By using this project, you can quickly set up a robust cloud environment to host your web applications with minimal effort.

---

## 📂 Project Structure

The project is organized into modular components for better reusability and maintainability:

```
aws-webapp-infra/
├── main.tf           # Main module to orchestrate submodules
├── variables.tf      # Input variables for the main module
├── outputs.tf        # Outputs from the main module
├── modules/
│   ├── networking/   # Submodule for VPC and subnets
│   ├── compute/      # Submodule for ALB, ASG, and EC2 instances
│   └── database/     # Submodule for RDS and ElastiCache
└── README.md         # Documentation (this file)
```

Each submodule is self-contained and can be reused independently in other projects.

---

## 🛠 Features

- **Networking**:
  - Creates a VPC with public and private subnets across multiple availability zones.
  - Configures Internet Gateway, NAT Gateway, and route tables.

- **Compute**:
  - Deploys an Application Load Balancer (ALB) to distribute traffic.
  - Configures an Auto Scaling Group (ASG) of EC2 instances for scalability.
  - Includes security groups for ALB and EC2 instances.

- **Database**:
  - Sets up an Amazon Aurora RDS cluster (MySQL-compatible) in private subnets.
  - Provides an option to add ElastiCache for caching.

- **Modular Design**:
  - Separate modules for networking, compute, and database resources.
  - Easy to customize and extend based on your requirements.

---

## 🔧 Prerequisites

Before using this project, ensure you have the following:

1. **Terraform**: Installed on your local machine ([Install Terraform](https://developer.hashicorp.com/terraform/tutorials/aws-get-started/install-cli)).
2. **AWS CLI**: Installed and configured with appropriate credentials ([Install AWS CLI](https://docs.aws.amazon.com/cli/latest/userguide/install-cliv2.html)).
3. **AWS Account**: Access to an AWS account with permissions to create resources (VPC, EC2, RDS, etc.).

---

## 🚀 Getting Started

### 1. Clone the Repository

```bash
git clone https://github.com/your-repo/aws-webapp-infra.git
cd aws-webapp-infra
```

### 2. Initialize Terraform

Run the following command to initialize the project:

```bash
terraform init
```

### 3. Configure Variables

Update the `variables.tf` file or create a `terraform.tfvars` file in the root directory to provide values for required variables. 


Example:

```hcl
vpc_cidr            = "10.0.0.0/16"
public_subnet_cidrs = ["10.0.1.0/24", "10.0.2.0/24"]
private_subnet_cidrs = ["10.0.3.0/24", "10.0.4.0/24"]

db_username = "admin"
db_password = "securepassword123"
```

### 4. Plan the Infrastructure

Run the following command to see what Terraform will create:

```bash
terraform plan
```

### 5. Apply the Configuration

Deploy the infrastructure by running:

```bash
terraform apply
```

Type `yes` when prompted to confirm.

### 6. Access Outputs

After successful deployment, Terraform will display output values such as the ALB DNS name and RDS endpoint:

```plaintext
Outputs:

alb_dns_name = "webapp-alb-123456789.us-east-1.elb.amazonaws.com"
db_endpoint  = "webapp-db-cluster.cluster-123456789.us-east-1.rds.amazonaws.com"
```

Use these values to configure your web application.

---

## 📦 Modules Overview

### Networking Module (`modules/networking`)

This module creates a VPC with public and private subnets across multiple availability zones.

#### Inputs:
- `vpc_cidr`: CIDR block for the VPC.
- `public_subnet_cidrs`: List of CIDR blocks for public subnets.
- `private_subnet_cidrs`: List of CIDR blocks for private subnets.

#### Outputs:
- `vpc_id`: ID of the created VPC.
- `public_subnet_ids`: IDs of public subnets.
- `private_subnet_ids`: IDs of private subnets.

---

### Compute Module (`modules/compute`)

This module sets up an ALB, Auto Scaling Group (ASG), and EC2 instances.

#### Inputs:
- `vpc_id`: ID of the VPC.
- `public_subnet_ids`: List of public subnet IDs.
- `private_subnet_ids`: List of private subnet IDs.
- `instance_type`: Instance type for EC2 instances.
- `min_size`: Minimum number of instances in ASG.
- `max_size`: Maximum number of instances in ASG.

#### Outputs:
- `alb_dns_name`: DNS name of the ALB.

---

### Database Module (`modules/database`)

This module provisions an Amazon Aurora RDS cluster in private subnets.

#### Inputs:
- `vpc_id`: ID of the VPC.
- `private_subnet_ids`: List of private subnet IDs.
- `db_name`: Name of the database.
- `db_username`: Master username for the database.
- `db_password`: Master password for the database.

#### Outputs:
- `db_endpoint`: Endpoint address of the RDS cluster.

---

## 🛡 Security Best Practices

1. **Sensitive Variables**: Use environment variables or secret management tools (e.g., AWS Secrets Manager) to store sensitive values like database passwords.
2. **IAM Roles**: Ensure that your AWS credentials have least privilege access to create necessary resources.
3. **Key Management**: Use SSH key pairs securely when accessing EC2 instances.

---

