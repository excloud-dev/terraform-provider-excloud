---
page_title: "excloud_iam_policy_bindings Data Source - excloud"
description: |-
  Lists Excloud IAM policies bound to an account or service account.
---

# excloud_iam_policy_bindings

Lists IAM policies bound to an Excloud account or service account.

## Example Usage

```hcl
data "excloud_iam_policy_bindings" "worker" {
  service_account_id = tonumber(excloud_iam_service_account.worker.id)
}
```

To list policies bound to an account, set `account_id` instead of `service_account_id`.

## Schema

### Optional

- `account_id` (Number) Account ID target. Exactly one of `account_id` or `service_account_id` must be set.
- `service_account_id` (Number) Service account ID target. Exactly one of `account_id` or `service_account_id` must be set.

### Read-Only

- `id` (String) Synthetic read ID.
- `policies` (List of Object) IAM policies bound to the target.

Each `policies` item includes:

- `id`
- `name`
- `org_id`
- `is_managed`
- `policy_json`
