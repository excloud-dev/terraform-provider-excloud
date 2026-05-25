terraform {
  required_providers {
    excloud = {
      source = "excloud-dev/excloud"
    }
  }
}

# Uses provider attributes, environment variables, or ~/.exc/config from `exc login`.
provider "excloud" {}

# Reserves a Public IPv4 in zone 1. The reservation persists until released,
# so it counts against your Public IPv4 quota even when not associated with a
# VM interface.
resource "excloud_public_ipv4" "reserved" {
  name    = "tf-generated-reserved"
  zone_id = 1
}

output "reserved_ip" {
  value = excloud_public_ipv4.reserved.ip
}

output "reservation_id" {
  value = excloud_public_ipv4.reserved.id
}
