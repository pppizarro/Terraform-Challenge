# Setting bucket name and prefix 
# for the terraform state file

terraform {
  backend "gcs" {
    bucket = "challenge-tf-state"
    prefix = "terraform/cloud-sql"
  }
  required_providers {
    google = {
      source = "hashicorp/google"
    }
  }
}