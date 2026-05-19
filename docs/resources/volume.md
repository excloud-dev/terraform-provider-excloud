---
page_title: "excloud_volume Resource - excloud"
description: |-
  Manages an Excloud block volume.
---

# excloud_volume

Manages a block volume. This resource can create billable storage.

## Example Usage

```hcl
resource "excloud_volume" "example" {
  name     = "example-volume"
  zone_id  = 1
  size_gib = 10
}
```

## Arguments

- `name` - Optional volume name.
- `zone_id` - Zone where the volume is created. Changing this recreates the volume.
- `size_gib` - Volume size in GiB.
- `baseline_iops` - Optional baseline IOPS. Defaults to `3000`.
- `baseline_throughput_mbps` - Optional baseline throughput. Defaults to `125`.
- `source_snapshot_id` - Optional source snapshot ID.

## Import

```bash
terraform import excloud_volume.example <id>
```
