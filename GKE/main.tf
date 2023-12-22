# Local variables 
locals {
  # List of IAM Roles to be assigned to the GKE Nodes Service Account
  np_role_list = [
    # These roles are primarily used to write Logs and Metrics to Stackdriver
    # and also to view the Logs and Metrics at GCP console level.
    "roles/logging.logWriter",
    "roles/monitoring.metricWriter",
    "roles/monitoring.viewer",
    "roles/stackdriver.resourceMetadata.writer",
  ]
}

# Enable Container Engine API
resource "google_project_service" "container_api" {
  project = var.project_id
  service = "container.googleapis.com"
  disable_on_destroy = false
}

# Resources previously created at networking folder and imported through data
data "google_compute_network" "challenge_vpc" {
  project = var.project_id
  name    = "challenge-vpc"
}

data "google_compute_subnetwork" "challenge_subnet" {
  project = var.project_id
  name    = "challenge-us-central1"
  region  = var.region
}

# Service Account Used by GKE Nodes to access Google Cloud APIs
resource "google_service_account" "gke_sa_node" {
  project      = var.project_id
  account_id   = var.service_account_node_name
  display_name = "GKE node Service Account"
}

# Set IAM Roles for the Service Account
resource "google_project_iam_member" "gke_sa_nodes_roles" {
  # Set a list of roles using a foreach loop
  for_each = toset(local.np_role_list)
  project  = var.project_id
  role     = each.key
  member   = "serviceAccount:${google_service_account.gke_sa_node.email}"
}

# GKE cluster creation
resource "google_container_cluster" "main" {
  project  = var.project_id
  name     = var.cluster_name
  location = var.zone

  remove_default_node_pool = true
  initial_node_count       = 1
  network                  = data.google_compute_network.challenge_vpc.self_link
  subnetwork               = data.google_compute_subnetwork.challenge_subnet.self_link

  master_auth {
    client_certificate_config {
      issue_client_certificate = "true"
    }
  }

  release_channel {
    channel = "REGULAR"
  }

  ip_allocation_policy {
    cluster_secondary_range_name  = var.k8s_ip_range_pods
    services_secondary_range_name = var.k8s_ip_range_svcs
  }

  network_policy {
    enabled = true
  }

  master_authorized_networks_config {
    dynamic "cidr_blocks" {
      for_each = { for cidr_block in var.master_authorized_networks_config : cidr_block.display_name => cidr_block }
      content {
        cidr_block   = cidr_blocks.value.cidr_block
        display_name = cidr_blocks.value.display_name
      }
    }
  }

  private_cluster_config {
    enable_private_nodes    = true
    enable_private_endpoint = false
    master_ipv4_cidr_block  = var.k8s_master_block
  }

  workload_identity_config {
    workload_pool = "${var.project_id}.svc.id.goog"
  }

  enable_intranode_visibility = true
  enable_shielded_nodes       = true

  timeouts {
    create = "30m"
    update = "40m"
  }
  depends_on = [
    google_project_service.container_api
  ]
}

# GKE Node Pool Creation
resource "google_container_node_pool" "challenge_node_pool" {
  project = var.project_id
  name    = var.node_pool.name

  location = var.zone
  cluster  = google_container_cluster.main.name

  management {
    auto_repair  = true
    auto_upgrade = true
  }

  autoscaling {
    min_node_count = var.node_pool.autoscaling.min_node_count
    max_node_count = var.node_pool.autoscaling.max_node_count
  }

  node_config {
    preemptible     = false
    machine_type    = var.node_pool.machine_type
    disk_type       = var.node_pool.disk_type
    disk_size_gb    = var.node_pool.disk_size_gb
    image_type      = var.node_pool.image_type
    service_account = google_service_account.gke_sa_node.email
    tags            = var.node_network_tags
    labels = {
      "node-pool"   = var.node_pool.name
    }

    shielded_instance_config {
      enable_secure_boot          = true
      enable_integrity_monitoring = true
    }

    workload_metadata_config {
      mode = "GKE_METADATA"
    }

    oauth_scopes = [
      "https://www.googleapis.com/auth/cloud-platform",
      "https://www.googleapis.com/auth/compute",
      "https://www.googleapis.com/auth/logging.write",
      "https://www.googleapis.com/auth/monitoring",
      "https://www.googleapis.com/auth/servicecontrol",
      "https://www.googleapis.com/auth/service.management.readonly",
      "https://www.googleapis.com/auth/trace.append"
    ]
  }

  lifecycle {
    ignore_changes = [node_count]
  }
}
