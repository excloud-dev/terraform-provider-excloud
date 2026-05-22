---
page_title: "excloud_dns_zones Data Source - excloud"
description: |-
  Lists Excloud DNS zones.
---

# excloud_dns_zones

Lists DNS zones visible to the configured Excloud organization.

## Example Usage

```hcl
data "excloud_dns_zones" "all" {}
```

## Schema

### Read-Only

- `id` (String) Synthetic read ID.
- `zones` (List of Object) DNS zone summaries.

Each `zones` item includes:

- `id`
- `name`
