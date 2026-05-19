---
page_title: "excloud_public_ipv4 Resource - excloud"
description: |-
  Manages an Excloud public IPv4 reservation.
---

# excloud_public_ipv4

Reserves a public IPv4 address. This resource can be billable.

## Example Usage

```hcl
resource "excloud_public_ipv4" "example" {
  name    = "example-ip"
  zone_id = 1
}
```

## Arguments

- `name` - Optional reservation name.
- `zone_id` - Zone where the IPv4 is reserved.
- `interface_id` - Optional interface ID to associate at reservation time.

## Import

```bash
terraform import excloud_public_ipv4.example <id>
```
