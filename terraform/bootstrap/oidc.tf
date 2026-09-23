# --- CI access ---------------------------------------------------------------
# GitHub Actions authenticates through OIDC rather than a stored access key:
# no long-lived secret in the repository, and the trust policy pins which repo
# and which refs may assume the role.
#
# The role can only be created by an apply that runs locally with your own
# credentials. Until that has happened once, the workflow cannot authenticate —
# chicken and egg, and expected.

variable "github_repository" {
  description = "owner/name of the repository allowed to assume the CI role"
  type        = string
  default     = "flomotlik/flomotlik.me"
}

data "aws_caller_identity" "current" {}

resource "aws_iam_openid_connect_provider" "github" {
  url             = "https://token.actions.githubusercontent.com"
  client_id_list  = ["sts.amazonaws.com"]
  thumbprint_list = ["6938fd4d98bab03faadb97b34396831e3780aea1"]
}

data "aws_iam_policy_document" "github_assume" {
  statement {
    effect  = "Allow"
    actions = ["sts:AssumeRoleWithWebIdentity"]

    principals {
      type        = "Federated"
      identifiers = [aws_iam_openid_connect_provider.github.arn]
    }

    condition {
      test     = "StringEquals"
      variable = "token.actions.githubusercontent.com:aud"
      values   = ["sts.amazonaws.com"]
    }

    # Only this repository, and only the default branch or a pull request.
    condition {
      test     = "StringLike"
      variable = "token.actions.githubusercontent.com:sub"
      values = [
        "repo:${var.github_repository}:ref:refs/heads/master",
        "repo:${var.github_repository}:pull_request",
      ]
    }
  }
}

resource "aws_iam_role" "terraform_ci" {
  name               = "flomotlik-terraform-ci"
  description        = "GitHub Actions: plan and apply the flomotlik.me DNS"
  assume_role_policy = data.aws_iam_policy_document.github_assume.json
}

# Scoped to what this configuration actually touches: one hosted zone, the
# state bucket, and the lock table. Not AdministratorAccess.
data "aws_iam_policy_document" "terraform_ci" {
  statement {
    effect = "Allow"
    actions = [
      "route53:GetHostedZone",
      "route53:ListHostedZones",
      "route53:ListResourceRecordSets",
      "route53:ChangeResourceRecordSets",
      "route53:GetChange",
      "route53:ListTagsForResource",
    ]
    resources = ["*"]
  }

  statement {
    effect    = "Allow"
    actions   = ["s3:ListBucket"]
    resources = ["arn:aws:s3:::flomotlik-terraform-state"]
  }

  statement {
    effect    = "Allow"
    actions   = ["s3:GetObject", "s3:PutObject"]
    resources = ["arn:aws:s3:::flomotlik-terraform-state/flomotlik.me/*"]
  }

  statement {
    effect    = "Allow"
    actions   = ["dynamodb:GetItem", "dynamodb:PutItem", "dynamodb:DeleteItem"]
    resources = ["arn:aws:dynamodb:eu-central-1:${data.aws_caller_identity.current.account_id}:table/flomotlik-terraform-locks"]
  }
}

resource "aws_iam_role_policy" "terraform_ci" {
  name   = "terraform-dns"
  role   = aws_iam_role.terraform_ci.id
  policy = data.aws_iam_policy_document.terraform_ci.json
}

output "ci_role_arn" {
  value       = aws_iam_role.terraform_ci.arn
  description = "Set as the AWS_ROLE_ARN repository variable for GitHub Actions"
}
