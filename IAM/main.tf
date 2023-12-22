locals {
  user_roles = [
    "roles/container.clusterViewer",
    "roles/storage.legacyBucketReader",
    "roles/storage.objectViewer",
    "roles/cloudsql.viewer"
  ]

  admin_roles = [
    "roles/container.admin",
    "roles/storage.admin",
    "roles/cloudsql.admin"
  ]
}

# Enable IAM API
resource "google_project_service" "iam_api" {
  project = var.project_id
  service = "iam.googleapis.com"
  disable_on_destroy = false
}

# Add IAM user roles to an specific user
resource "google_project_iam_member" "user_roles" {
  for_each = toset(local.user_roles)
  project = var.project_id
  role    = each.value
  member  = "user:${var.user_email}"
}

# Add IAM admin roles to an specific admin user
resource "google_project_iam_member" "admin_roles" {
  for_each = toset(local.admin_roles)
  project = var.project_id
  role    = each.value
  member  = "user:${var.admin_email}"
}