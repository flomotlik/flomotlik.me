# DNS for flomotlik.me

Terraform for the `flomotlik.me` Route 53 zone.

## Why this exists

The zone was created in 2017 by a CloudFormation stack (`flomotlikme`,
eu-central-1) driven by [formica]. That arrangement no longer works:

- the stack has sat in `UPDATE_ROLLBACK_COMPLETE` since **2017-04-28**;
- the live `A` record was edited by hand afterwards and now points at GitHub
  Pages, while CloudFormation still believes it is an S3 alias — the stack and
  reality disagree;
- `formica` 0.6.2 cannot run on any current Python (its pinned `deepdiff`
  imports `collections.Mapping`, removed in 3.10), and the `dns/cname` module
  at the pinned commit is missing its top-level `Resources:` key;
- upstream formica dropped the `Modules:` syntax this template uses in 0.7.

So the records are, in practice, unmanaged. This directory takes ownership of
them in Terraform.

## State

S3 backend, `flomotlik-terraform-state` in eu-central-1, versioned, encrypted,
public access blocked, with a DynamoDB lock table `flomotlik-terraform-locks`.
Both were bootstrapped by hand — a state backend cannot manage itself.

## The CloudFormation stack is still there

`flomotlikme` in eu-central-1 still *claims* the hosted zone, the `A`/`MX`/`TXT`
records and the `flomotlik.me` S3 bucket. It is inert — nothing can deploy it
any more — but it has not been deleted, because deleting it as it stands would
try to delete the hosted zone and the MX records with it.

Retiring it safely is a separate, deliberate job:

1. Set `DeletionPolicy: Retain` on every resource in the stack template.
2. Update the stack so the retain policies take effect. (This is the awkward
   step: the stack is in `UPDATE_ROLLBACK_COMPLETE` and its tooling is dead, so
   this likely means `aws cloudformation update-stack` with a hand-written
   template body.)
3. `aws cloudformation delete-stack` — with retain in place, the resources stay.
4. Confirm the records still resolve.

Do not delete the stack before step 1. **The MX records carry live email.**

[formica]: https://github.com/flomotlik/formica

## Two states, on purpose

| Directory | State key | Applied by | Contains |
|---|---|---|---|
| `terraform/` | `flomotlik.me/dns.tfstate` | GitHub Actions on `master` | the zone and its records |
| `terraform/bootstrap/` | `flomotlik.me/bootstrap.tfstate` | you, by hand | the GitHub OIDC provider and the CI role |

They are split because the CI role must not be able to manage its own IAM
policy. A role that can rewrite its own permissions can grant itself anything,
which would make scoping it pointless. CI's policy therefore covers exactly one
hosted zone, the state object and the lock table — and the configuration it
applies contains no IAM at all.

`bootstrap/` changes rarely. Apply it locally:

```bash
cd terraform/bootstrap
terraform init && terraform plan   # then apply if it looks right
```
