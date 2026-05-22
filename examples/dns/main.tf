terraform {
  required_providers {
    excloud = {
      source = "excloud-dev/excloud"
    }
  }
}

# Uses provider attributes, environment variables, or ~/.exc/config from `exc login`.
provider "excloud" {}

resource "excloud_dns_zone" "example" {
  name      = "example.com"
  zone_type = "public"
}

output "nameservers" {
  value = excloud_dns_zone.example.nameservers
}

resource "excloud_dns_record" "www" {
  zone_name = excloud_dns_zone.example.name
  name      = "www"
  type      = "A"
  value     = "203.0.113.10"
  ttl       = 3600
}
