---
page_title: "excloud_snapshots Data Source - excloud"
description: |-
  Lists Excloud block volume snapshots.
---

# excloud_snapshots

Lists snapshots visible to the configured Excloud organization.

## Example Usage

```hcl
data "excloud_snapshots" "all" {}
```

## Schema

### Read-Only

- `id` (String) Synthetic read ID.
- `snapshots` (List of Object) Snapshot records.

Each `snapshots` item includes:

- `id`
- `volume_id`
- `zone_id`
- `org_id`
- `size_bytes`
- `storage_class`
- `is_ami`
- `state`
- `name`
- `created_at`
