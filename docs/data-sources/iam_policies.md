---
page_title: "excloud_iam_policies Data Source - excloud"
description: |-
  Lists Excloud IAM policies.
---

# excloud_iam_policies

Lists IAM policies visible to the configured Excloud organization.

## Example Usage

```hcl
data "excloud_iam_policies" "all" {}
```

## Schema

### Read-Only

- `id` (String) Synthetic read ID.
- `policies` (List of Object) IAM policy records.

Each `policies` item includes:

- `id`
- `name`
- `org_id`
- `is_managed`
- `policy_json`
