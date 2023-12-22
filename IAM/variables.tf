# Variable definitions for the GCP project and region

variable "project_id" {
  type = string
  description = "The GCP project ID"
}

variable "user_email" {
  type = string
  description = "The email address of the user to be granted access to the project"
}

variable "admin_email" {
  type = string
  description = "The email address of the admin user to be granted access to the project"
}