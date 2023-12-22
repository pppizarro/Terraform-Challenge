# Variable definitions for the GCP project and region

variable "project_id" {
  type        = string
  description = "The GCP project ID"
}

variable "postgres_database_version" {
  type        = string
  description = "The GCP Postgres database version"
  default     = "POSTGRES_15_2"
}

variable "region" {
  type        = string
  description = "The GCP region"
}

variable "enable_deletion_protection" {
  type        = bool
  description = "Enable deletion protection for the GCP Cloud SQL instance"
  default     = true
}

variable "instance_tier_type" {
  type        = string
  description = "The GCP Cloud SQL instance tier type"
}

variable "cloud_sql_enable_public_ip" {
  type        = bool
  description = "Enable public IP for the GCP Cloud SQL instance"
  default     = false
}

variable "databases" {
  type        = list(string)
  description = "The list of databases to create in the GCP Cloud SQL instance"
}

variable "db_users" {
  type        = map(string)
  description = "The list of database users to create in the GCP Cloud SQL instance"
}