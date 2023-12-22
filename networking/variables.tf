# Variable definitions for the GCP project and region

variable "project_id" {
  type = string
  description = "The GCP project ID"
}

variable "region" {
  type = string
  description = "The GCP region"
}

variable "zone" {
  type = string
  description = "The GCP zone"
}

variable "subnetwork_definition" {
  type = list(object(
    {
      name   = string
      cidr   = string
      region = string
    }
  ))
  description = "Subnetwork Definition"
}

variable "secondary_ranges" {
  type = list(object(
    {
      name = string
      cidr = string
    }
  ))
  description = "Secondary Ranges"
}

variable "cloud_nat_ip_count" {
  type        = string
  description = "Number of IPs that will be created to be used for Cloud NAT"
}

variable "private_reserved_range" {
  type = string
  description = "Private IP range that will be used for Cloud SQL Instances"
}
