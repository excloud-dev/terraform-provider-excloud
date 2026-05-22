---
page_title: "excloud_bucket_usage Data Source - excloud"
description: |-
  Returns Excloud bucket usage and quotas.
---

# excloud_bucket_usage

Returns current object-storage usage and quota values for the configured Excloud organization.

## Example Usage

```hcl
data "excloud_bucket_usage" "current" {}

output "bucket_count" {
  value = data.excloud_bucket_usage.current.bucket_count
}
```

## Schema

### Read-Only

- `id` (String) Synthetic read ID.
- `bucket_count` (Number) Number of buckets.
- `object_count` (Number) Total object count.
- `total_bytes` (Number) Total stored bytes.
- `max_buckets` (Number) Bucket quota.
- `max_objects_per_bucket` (Number) Per-bucket object quota.
- `max_total_bytes` (Number) Total storage quota in bytes.
