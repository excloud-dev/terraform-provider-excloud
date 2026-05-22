terraform {
  required_providers {
    excloud = {
      source = "excloud-dev/excloud"
    }
  }
}

# Uses provider attributes, environment variables, or ~/.exc/config from `exc login`.
provider "excloud" {}

resource "excloud_bucket" "assets" {
  name      = "my-assets-bucket"
  is_public = false
}

resource "excloud_bucket_access_key" "automation" {
  name = "terraform-automation"
}

output "bucket_name" {
  value = excloud_bucket.assets.name
}

output "bucket_access_key_id" {
  value = excloud_bucket_access_key.automation.access_key_id
}

output "bucket_secret_access_key" {
  value     = excloud_bucket_access_key.automation.secret_access_key
  sensitive = true
}
