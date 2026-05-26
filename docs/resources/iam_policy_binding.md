---
page_title: "excloud_iam_policy_binding Resource - excloud"
description: |-
  Binds an Excloud IAM policy to an account or service account.
---

# excloud_iam_policy_binding

Binds one IAM policy to an Excloud account or service account.

## Example Usage

```hcl
resource "excloud_iam_service_account" "worker" {
  name = "terraform-worker"
}

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

resource "excloud_iam_policy_binding" "worker_compute_read" {
  policy_id          = tonumber(excloud_iam_policy.compute_read.id)
  service_account_id = tonumber(excloud_iam_service_account.worker.id)
}
```

To bind a policy to an account, set `account_id` instead of `service_account_id`.

## Import

Import by target kind, target ID, and policy ID:

```bash
terraform import excloud_iam_policy_binding.worker_compute_read service_account:<service_account_id>:<policy_id>
terraform import excloud_iam_policy_binding.account_compute_read account:<account_id>:<policy_id>
```

## Schema

### Required

- `policy_id` (Number) IAM policy ID to bind. Changing this replaces the binding.

### Optional

- `account_id` (Number) Account ID target. Exactly one of `account_id` or `service_account_id` must be set. Changing this replaces the binding.
- `service_account_id` (Number) Service account ID target. Exactly one of `account_id` or `service_account_id` must be set. Changing this replaces the binding.

### Read-Only

- `id` (String) Composite binding ID.
