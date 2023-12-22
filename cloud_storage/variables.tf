# Variable definitions for the GCP project and region

variable "project_id" {
  type = string
  description = "The GCP project ID"
}

variable "region" {
  type = string
  description = "The GCP region"
}

variable "bucket_name" {
  type = string
  description = "The GCP bucket name for challenge"
}