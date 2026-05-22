---
page_title: "excloud_dns_record Resource - excloud"
description: |-
  Creates and manages an Excloud DNS record.
---

# excloud_dns_record

Creates and manages a DNS record in an Excloud DNS zone.

## Example Usage

```hcl
resource "excloud_dns_zone" "example" {
  name      = "example.com"
  zone_type = "public"
}

resource "excloud_dns_record" "www" {
  zone_name = excloud_dns_zone.example.name
  name      = "www"
  type      = "A"
  value     = "203.0.113.10"
  ttl       = 3600
}

resource "excloud_dns_record" "mail" {
  zone_name  = excloud_dns_zone.example.name
  name       = "@"
  type       = "MX"
  value      = "mail.example.com"
  preference = 10
  ttl        = 3600
}
```

## Supported record types

- `A`, `AAAA`: set `value` to the IP address and `ttl`.
- `CNAME`, `NS`: set `value` to the target hostname and `ttl`.
- `TXT`: set `value` to the text and `ttl`.
- `PTR`: set `value` to the pointer target and `ttl`.
- `MX`: set `value`, `preference`, and `ttl`.
- `WEIGHTED_A`, `WEIGHTED_AAAA`, `WEIGHTED_CNAME`, `WEIGHTED_TXT`: set `value`, `weight`, and `ttl`.

## Schema

### Required

- `zone_name` (String) DNS zone name without a trailing dot.
- `name` (String) Record name relative to the zone. Use `@` for the apex.
- `type` (String) DNS record type.
- `value` (String) Primary record value.

### Optional

- `ttl` (Number) Record TTL in seconds.
- `preference` (Number) MX preference.
- `weight` (Number) Weighted-record weight.

### Read-Only

- `id` (String) Composite record ID.
- `fqdn` (String) Fully qualified domain name.
- `zone_id` (Number) DNS zone ID.

## Import

DNS record import is not supported yet because the API identifies records by the full record payload, not only a simple ID.
