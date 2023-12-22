# Variable definitions for the GCP project and region

variable "project_id" {
  type        = string
  description = "GCP Project ID"
}

variable "region" {
  type        = string
  description = "The GCP region"
}

variable "service_account_node_name" {
  type    = string
  default = "gke-sa-nodes"
}

variable "cluster_name" {
  type        = string
  description = "GKE cluster name"
}

variable "zone" {
  type        = string
  description = "The GCP zone"
}

variable "k8s_ip_range_pods" {
  type        = string
  description = "CIDR to be used for pods"
  default     = ""
}

variable "k8s_ip_range_svcs" {
  type        = string
  description = "CIDR to be used for services"
  default     = ""
}

variable "master_authorized_networks_config" {
  type = list(object({
    cidr_block   = string
    display_name = string
  }))
  default = []
}

variable "k8s_master_block" {
  type        = string
  description = "CIDR to be used for GKE master nodes"
}

variable "node_pool" {
  type = object({
    name       = string,
    node_count = number,
    autoscaling = object({
      min_node_count = number,
      max_node_count = number
    })
    machine_type = string,
    disk_type    = string,
    disk_size_gb = number
    image_type   = string,
  })
  description = "Node Pool configuration"
}

variable "node_network_tags" {
  type        = list(string)
  description = "Network tags to be applied to nodes"
  default     = []
}

