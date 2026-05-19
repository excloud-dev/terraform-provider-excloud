---
page_title: "Excloud Provider"
description: |-
  Terraform provider for Excloud compute resources and data sources.
---

# Excloud Provider

The Excloud provider manages Excloud compute resources through the Excloud API.

## Example Usage

```hcl
terraform {
  required_providers {
    excloud = {
      source  = "excloud-in/excloud"
      version = "0.1.0"
    }
  }
}

provider "excloud" {
  # Prefer environment variables or explicit attributes in production.
  # api_key = var.excloud_api_key
  # org_id  = var.excloud_org_id
}
```

For local development only, `.env` loading can be enabled explicitly:

```hcl
provider "excloud" {
  load_dotenv = true
}
```

## Authentication

The provider supports these attributes and corresponding environment variables:

- `api_key` / `API_KEY` / `EXCLOUD_API_KEY` / `EXCLOUD_ACCESS_TOKEN` / `ACCESS_TOKEN`
- `id_token` / `ID_TOKEN` / `EXCLOUD_ID_TOKEN`
- `account_id` / `ACCOUNT_ID` / `EXCLOUD_ACCOUNT_ID`
- `org_id` / `ORG_ID` / `EXCLOUD_ORG_ID`
- `compute_base_url` / `EXCLOUD_COMPUTE_BASE_URL`

## Safety

Some resources create billable infrastructure, including compute instances, volumes, and public IPv4 reservations. Review plans carefully before applying.
