# Troubleshooting

## Authentication failures

The provider reads credentials from provider attributes first, then environment variables. `.env` loading is disabled by default for production safety.

For local development, either export environment variables directly or enable `.env` loading explicitly:

```hcl
provider "excloud" {
  load_dotenv = true
}
```

or:

```bash
EXCLOUD_TF_LOAD_DOTENV=true terraform plan
```

## Not found during refresh

If the API returns HTTP 404, the provider treats the resource as gone and removes it from Terraform state during refresh. This now uses typed SDK `APIError` status codes instead of only string matching.

## Dependency conflicts during destroy

Some resources cannot be deleted until their dependents are gone. For example, a security group can remain attached to a VM interface until the VM reaches `TERMINATED`. The compute instance delete waiter intentionally waits for `TERMINATED`, not merely `TERMINATING`.

## Quota or validation errors

Quota, validation, and authorization errors are exposed from the SDK with HTTP status codes, API error codes when available, and response bodies. Terraform diagnostics should show the API message without requiring provider-side string matching.

## Live test cleanup

If a live test is interrupted, inspect resources by name prefix (`tf-acc-*` or `tf-*`) and destroy them manually before rerunning tests. Avoid VM tests unless explicitly approved because they can create billable resources.
