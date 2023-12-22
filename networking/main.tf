# Enable Compute Engine API
resource "google_project_service" "compute_api" {
  project = var.project_id
  service = "compute.googleapis.com"
  disable_on_destroy = false
}

# Enable Service Networking API
resource "google_project_service" "servicenetworking_api" {
  project = var.project_id
  service = "servicenetworking.googleapis.com"
  disable_on_destroy = false
}

# VPC Creation
resource "google_compute_network" "challenge_vpc" {
  project = var.project_id
  name    = "challenge-vpc"

  auto_create_subnetworks = false
  routing_mode            = "GLOBAL"

  depends_on = [
    google_project_service.compute_api
  ]
}

resource "google_compute_subnetwork" "challenge_subnetwork" {
  for_each                 = { for subnet in var.subnetwork_definition : subnet.name => subnet }
  name                     = "${each.value.name}"
  project                  = var.project_id
  ip_cidr_range            = each.value.cidr
  network                  = google_compute_network.challenge_vpc.self_link
  region                   = each.value.region
  private_ip_google_access = true
  private_ipv6_google_access = "ENABLE_OUTBOUND_VM_ACCESS_TO_GOOGLE"

  # Secondary IP Ranges for Private GKE Clusters (pods and services)
  dynamic "secondary_ip_range" {
    for_each = var.secondary_ranges
    content {
      ip_cidr_range = lookup(secondary_ip_range.value, "cidr")
      range_name    = lookup(secondary_ip_range.value, "name")
    }
  }
}

resource "google_compute_router" "challenge_router" {
  project     = var.project_id
  name        = "challenge-nat-vpc"
  region      = var.region
  network     = google_compute_network.challenge_vpc.id
  description = "Router to be used by Cloud NAT"
}

resource "google_compute_address" "challenge_nat_ips" {
  count = var.cloud_nat_ip_count

  project     = var.project_id
  name        = "challenge-nat-ip-address-${count.index}"
  region      = var.region
  description = "Cloud NAT IP's used by challenge vpc"
}

resource "google_compute_router_nat" "challenge_nat" {
  project                             = var.project_id
  name                                = "challenge-nat"
  router                              = google_compute_router.challenge_router.name
  region                              = var.region
  nat_ip_allocate_option              = "MANUAL_ONLY"
  nat_ips                             = google_compute_address.challenge_nat_ips.*.self_link
  source_subnetwork_ip_ranges_to_nat  = "ALL_SUBNETWORKS_ALL_IP_RANGES"
  enable_endpoint_independent_mapping = true
  min_ports_per_vm                    = 128

  log_config {
    enable = false
    filter = "ALL"
  }
}

##### PRIVATE IP ADDRESSES #####

resource "google_compute_global_address" "private_ip_range" {
  project       = var.project_id
  name          = "private-ip-addresses"
  purpose       = "VPC_PEERING"
  address_type  = "INTERNAL"
  prefix_length = 16
  network       = google_compute_network.challenge_vpc.self_link
  address       = var.private_reserved_range
}

resource "google_service_networking_connection" "private_vpc_connection" {

  network                 = google_compute_network.challenge_vpc.id
  service                 = "servicenetworking.googleapis.com"
  reserved_peering_ranges = [google_compute_global_address.private_ip_range.name]

  depends_on = [
    google_project_service.servicenetworking_api
  ]
}

resource "google_compute_firewall" "allow_healthcheck" {
  project = var.project_id
  name =  "allow-gcp-healthcheck"
  network = google_compute_network.challenge_vpc.self_link

  allow {
    protocol = "tcp"
  }
  # Allow healthcheck ranges from GCP - https://cloud.google.com/load-balancing/docs/health-check-concepts#ip-ranges
  source_ranges = ["35.191.0.0/16", "130.211.0.0/22", "209.85.152.0/22", "209.85.204.0/22"]
}
