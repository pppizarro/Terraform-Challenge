
# Random ID for DB name suffix as GCP reserves the name for 7 days after deletion
resource "random_id" "db_name_suffix" {
  byte_length = 4
}

# Import 
data "google_compute_network" "challenge_vpc" {
  project = var.project_id
  name    = "challenge-vpc"
}

# Google Cloud SQL Instance
# This block will create a Google Cloud SQL instance 
resource "google_sql_database_instance" "challenge" {
  provider            = google-beta
  project             = var.project_id
  name                = "challenge-${random_id.db_name_suffix.hex}"
  database_version    = var.postgres_database_version
  region              = var.region
  deletion_protection = var.enable_deletion_protection

  settings {
    tier              = var.instance_tier_type
    activation_policy = "ALWAYS"
    availability_type = "ZONAL"
    disk_autoresize   = true
    disk_type         = "PD_SSD"

    insights_config {
      query_insights_enabled = true
    }

    ip_configuration {
      ipv4_enabled    = var.cloud_sql_enable_public_ip
      private_network = data.google_compute_network.challenge_vpc.self_link
      require_ssl     = true
    }

    database_flags {
        name  = "log_duration"
        value = "on"
      }
    database_flags {
        name = "log_lock_waits"
        value = "on"
      }
    database_flags {
        name = "log_connections"
        value = "on"
      }
    database_flags {
        name = "log_checkpoints"
        value = "on"
      }
    database_flags {
        name = "log_disconnections"
        value = "on"
      }
    backup_configuration {
      enabled = true
    }

  }
}

# Google Cloud SQL Database list
resource "google_sql_database" "database" {
  project   = var.project_id
  for_each  = toset(var.databases)
  name      = each.value
  instance  = google_sql_database_instance.challenge.name
  charset   = "UTF8"
  collation = "en_US.UTF8"
}

resource "google_sql_user" "user" {
  project  = var.project_id
  for_each = var.db_users
  name     = each.key
  password = each.value
  instance = google_sql_database_instance.challenge.name
}
