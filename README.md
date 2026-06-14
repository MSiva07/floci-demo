# floci-demo 🚀

Local AWS infrastructure playground using [Floci](https://floci.io) — a free, open-source AWS emulator — provisioned with Terraform.

## What's Inside

- **S3 bucket** with versioning and sample object upload
- **EKS cluster** (`floci-eks`) with managed node group
- **IAM roles** for EKS control plane and worker nodes
- **Remote state** stored in S3 with DynamoDB state locking

## Prerequisites

- [Docker Desktop](https://www.docker.com/products/docker-desktop/)
- [Floci CLI](https://floci.io)
- [Terraform](https://developer.hashicorp.com/terraform/install)
- [AWS CLI](https://aws.amazon.com/cli/)

## Quick Start

### 1. Start Floci
```bash
floci start
eval $(floci env)
```

### 2. Initialize and Apply
```bash
terraform init
terraform apply
```

### 3. Verify Resources
```bash
# List S3 buckets
aws s3 ls

# Check EKS cluster
aws eks describe-cluster --name floci-eks \
  --query "cluster.{name:name,version:version,status:status}"

# Update kubeconfig
aws eks update-kubeconfig --name floci-eks --region us-east-1
kubectl get nodes
```

## Project Structure

floci-demo/

├── main.tf          # EKS, IAM, S3, DynamoDB resources

├── backend.tf       # S3 remote state + DynamoDB locking

├── .gitignore       # Excludes state files and provider binaries

└── README.md

## Remote State

Terraform state is stored remotely in Floci S3 — not committed to git.

| Resource | Purpose |
|---|---|
| `s3://terraform-state-bucket` | Stores terraform.tfstate |
| `dynamodb: terraform-state-lock` | Prevents concurrent applies |

## Resources Provisioned

| Resource | Name |
|---|---|
| EKS Cluster | `floci-eks` |
| EKS Node Group | `floci-nodes` |
| IAM Role | `eks-cluster-role` |
| IAM Role | `eks-node-role` |
| S3 Bucket | `terraform-state-bucket` |
| DynamoDB Table | `terraform-state-lock` |

## Why Floci?

- ✅ Free and open source — no auth tokens, no pricing tiers
- ✅ Starts in milliseconds
- ✅ LocalStack alternative since its community edition sunset in March 2026
- ✅ Supports 41+ AWS services including EKS, Lambda, RDS, and more
