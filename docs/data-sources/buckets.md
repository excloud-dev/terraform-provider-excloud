---
page_title: "excloud_buckets Data Source - excloud"
description: |-
  Lists Excloud buckets.
---

# excloud_buckets

Lists S3-compatible buckets visible to the configured Excloud organization.

## Example Usage

```hcl
data "excloud_buckets" "all" {}
```

## Schema

### Read-Only

- `id` (String) Synthetic read ID.
- `buckets` (List of Object) Bucket records.

Each `buckets` item includes:

- `name`
- `is_public`
- `org_id`
- `created_by`
- `created_at`
- `size_bytes`
- `object_count`
- `public_url`
