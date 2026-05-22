---
page_title: "excloud_snapshot Resource - excloud"
description: |-
  Creates and manages an Excloud block volume snapshot.
---

# excloud_snapshot

Creates a point-in-time snapshot from an Excloud block volume.

## Example Usage

```hcl
resource "excloud_volume" "data" {
  name     = "app-data"
  zone_id  = 1
  size_gib = 20
}

resource "excloud_snapshot" "data" {
  volume_id = tonumber(excloud_volume.data.id)
}
```

## Import

Import by snapshot ID:

```bash
terraform import excloud_snapshot.data 12345
```

## Schema

### Required

- `volume_id` (Number) Source volume ID to snapshot.

### Read-Only

- `id` (String) Snapshot ID.
- `zone_id` (Number) Zone ID.
- `org_id` (Number) Owning organization ID.
- `size_bytes` (Number) Snapshot logical size in bytes.
- `storage_class` (String) Snapshot storage class.
- `is_ami` (Boolean) Whether this snapshot is used as an image/AMI.
- `state` (String) Snapshot lifecycle state.
- `name` (String) Snapshot display name, when available.
- `created_at` (String) Creation time.
