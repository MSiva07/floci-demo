terraform {
  backend "s3" {
    bucket         = "terraform-state-bucket"
    key            = "floci-demo/terraform.tfstate"
    region         = "us-east-1"
    dynamodb_table = "terraform-state-lock"
    encrypt        = true

    endpoint                    = "http://localhost:4566"
    dynamodb_endpoint           = "http://localhost:4566"
    skip_credentials_validation = true
    skip_metadata_api_check     = true
    skip_requesting_account_id  = true
    force_path_style            = true
  }
}