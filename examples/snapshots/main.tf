terraform {
  required_providers {
    excloud = {
      source = "excloud-dev/excloud"
    }
  }
}

# Uses provider attributes, environment variables, or ~/.exc/config from `exc login`.
provider "excloud" {}

resource "excloud_volume" "data" {
  name     = "snapshot-demo-volume"
  zone_id  = 1
  size_gib = 20
}

resource "excloud_snapshot" "data" {
  volume_id = tonumber(excloud_volume.data.id)
}

output "snapshot_id" {
  value = excloud_snapshot.data.id
}
