---
page_title: "excloud_bucket Resource - excloud"
description: |-
  Creates and manages an Excloud S3-compatible bucket.
---

# excloud_bucket

Creates and manages an Excloud bucket for S3-compatible object storage.

## Example Usage

```hcl
resource "excloud_bucket" "assets" {
  name      = "my-assets-bucket"
  is_public = false
}
```

## Import

Import by bucket name:

```bash
terraform import excloud_bucket.assets my-assets-bucket
```

## Schema

### Required

- `name` (String) Bucket name.

### Optional

- `is_public` (Boolean) Whether objects are publicly readable through the public endpoint. Defaults to `false`.

### Read-Only

- `id` (String) Bucket name.
- `org_id` (Number) Owning organization ID.
- `created_by` (Number) Creator account/principal.
- `created_at` (String) Creation timestamp.
- `size_bytes` (Number) Total stored bytes.
- `object_count` (Number) Total object count.
- `public_url` (String) Public URL prefix when public.
