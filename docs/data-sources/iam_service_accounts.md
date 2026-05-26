---
page_title: "excloud_iam_service_accounts Data Source - excloud"
description: |-
  Lists Excloud IAM service accounts.
---

# excloud_iam_service_accounts

Lists IAM service accounts visible to the configured Excloud organization.

## Example Usage

```hcl
data "excloud_iam_service_accounts" "all" {}
```

## Schema

### Read-Only

- `id` (String) Synthetic read ID.
- `service_accounts` (List of Object) IAM service account records.

Each `service_accounts` item includes:

- `id`
- `name`
- `email`
- `assumers_json`
