terraform {
  required_providers {
    excloud = {
      source = "excloud-dev/excloud"
    }
  }
}

# Uses provider attributes, environment variables, or ~/.exc/config from `exc login`.
provider "excloud" {}

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

data "excloud_iam_service_accounts" "all" {}

data "excloud_iam_policies" "all" {}

data "excloud_iam_policy_bindings" "worker" {
  service_account_id = tonumber(excloud_iam_service_account.worker.id)
}

output "service_account_id" {
  value = excloud_iam_service_account.worker.id
}

output "service_account_email" {
  value = excloud_iam_service_account.worker.email
}
