---
page_title: "excloud_iam_policy Resource - excloud"
description: |-
  Creates and manages an Excloud IAM policy.
---

# excloud_iam_policy

Creates and manages an Excloud IAM policy. Policy documents are supplied as JSON.

## Example Usage

```hcl
resource "excloud_iam_policy" "compute_read" {
  name = "terraform-compute-read"

  policy_json = jsonencode({
    Version = "2024-03-05"
    Statements = [{
      Effect   = "Allow"
      Action   = ["compute:instance:list"]
      Resource = ["*"]
    }]
  })
}
```

## Import

Import by policy ID:

```bash
terraform import excloud_iam_policy.compute_read <policy_id>
```

## Schema

### Required

- `name` (String) Policy name. Changing this replaces the policy.
- `policy_json` (String) IAM policy document JSON. Use `Version` and `Statements` fields matching the IAM API policy document shape.

### Read-Only

- `id` (String) IAM policy ID.
- `org_id` (Number) Owning organization ID.
- `is_managed` (Boolean) Whether this is a provider-managed policy.
