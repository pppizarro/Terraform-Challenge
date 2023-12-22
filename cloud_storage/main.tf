# Google Cloud Storage Bucket
# This block will create a Google Cloud Storage Bucket with 
# the name and in the region provided in the variable file.

resource "google_storage_bucket" "bucket-for-challenge" {
  name          = var.bucket_name
  location      = var.region

  uniform_bucket_level_access = true
  public_access_prevention = "enforced"

  versioning {
    enabled = true
  }
}