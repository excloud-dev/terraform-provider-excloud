---
page_title: "excloud_subnets Data Source - excloud"
description: |-
  Lists Excloud subnets, optionally filtered by zone.
---

# excloud_subnets

Lists subnets.

## Example Usage

```hcl
data "excloud_subnets" "zone_1" {
  zone_id = 1
}
```

## Arguments

- `zone_id` - Optional zone filter.
