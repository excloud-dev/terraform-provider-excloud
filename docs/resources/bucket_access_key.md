---
page_title: "excloud_bucket_access_key Resource - excloud"
description: |-
  Creates and manages an Excloud bucket S3 access key.
---

# excloud_bucket_access_key

Creates an S3 access key for Excloud buckets. The secret access key is returned only once during creation and is stored in Terraform state as sensitive.

## Example Usage

```hcl
resource "excloud_bucket_access_key" "automation" {
  name = "terraform-automation"
}

output "bucket_access_key_id" {
  value = excloud_bucket_access_key.automation.access_key_id
}

output "bucket_secret_access_key" {
  value     = excloud_bucket_access_key.automation.secret_access_key
  sensitive = true
}
```

## Import

Import by access key ID. Imported resources do not recover `secret_access_key` because the API returns it only at creation.

```bash
terraform import excloud_bucket_access_key.automation EXC7H3PZQ4WXKJ2BNYV5
```

## Schema

### Required

- `name` (String) Human-friendly access key name.

### Read-Only

- `id` (String) Access key ID.
- `access_key_id` (String) S3 access key ID.
- `secret_access_key` (String, Sensitive) S3 secret access key returned only at creation.
- `org_id` (Number) Owning organization ID.
- `holder` (Number) Account or principal that owns the key.
- `is_principal` (Boolean) Whether holder is a principal/service account.
- `created_at` (String) Creation timestamp.
- `last_used_at` (String) Last used timestamp, when available.
