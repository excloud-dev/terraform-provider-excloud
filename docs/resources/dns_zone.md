---
page_title: "excloud_dns_zone Resource - excloud"
description: |-
  Creates and manages an Excloud DNS zone.
---

# excloud_dns_zone

Creates and manages a DNS zone in Excloud DNS.

## Example Usage

```hcl
resource "excloud_dns_zone" "example" {
  name      = "example.com"
  zone_type = "public"
}
```

## Import

Import by zone name:

```bash
terraform import excloud_dns_zone.example example.com
```

## Schema

### Required

- `name` (String) DNS zone name without a trailing dot.
- `zone_type` (String) DNS zone type. Currently only `public` is supported by the Excloud DNS API.

### Read-Only

- `id` (String) Excloud DNS zone ID.
- `nameservers` (List of String) Authoritative nameservers returned at creation.
