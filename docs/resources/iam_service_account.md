---
page_title: "excloud_iam_service_account Resource - excloud"
description: |-
  Creates and manages an Excloud IAM service account.
---

# excloud_iam_service_account

Creates and manages an Excloud IAM service account.

## Example Usage

```hcl
resource "excloud_iam_service_account" "worker" {
  name = "terraform-worker"
}
```

To configure assumers, pass the IAM API assumers object as JSON:

```hcl
resource "excloud_iam_service_account" "worker" {
  name = "terraform-worker"

  assumers_json = jsonencode({})
}
```

## Import

Import by service account ID:

```bash
terraform import excloud_iam_service_account.worker <service_account_id>
```

## Schema

### Required

- `name` (String) Service account name. Changing this replaces the service account.

### Optional

- `assumers_json` (String) JSON object describing external principals allowed to assume this service account. If omitted at creation, the provider sends an empty object.

### Read-Only

- `id` (String) IAM service account ID.
- `email` (String) Service account email-style principal identifier.
