---
owner_slack: "#govuk-2ndline"
title: Deploy AWS infrastructure with Terraform
section: Deployment
layout: manual_layout
parent: "/manual.html"
last_reviewed_on: 2019-05-02
review_in: 3 months
---

We use [Terraform](https://terraform.io) for configuring the GOV.UK
infrastructure in AWS.

## 1. Check what you can deploy

Which changes you can deploy depends on the level of access you have
to our AWS environments. Specifically, the level of access your Amazon Resource Name or ARN has been given.

- `govuk-users` (`role_user_user_arns`) can't deploy anything
- `govuk-powerusers` (`role_poweruser_user_arns`) and `govuk-platformhealth-powerusers` (`role_platformhealth_poweruser_user_arns`) can deploy everything except IAM (users and policies).
- `govuk-administrators` (`role_admin_user_arns`) and `govuk-internal-administrators` (`role_internal_admin_user_arns`) can deploy everything including IAM.

You can find which class of user you are (what your arn has been assigned to) [in the infra-security
project in
govuk-aws-data](https://github.com/alphagov/govuk-aws-data/tree/master/data/infra-security).

Choose either steps 2 and 3, or step 4 to continue.

## 2. Get your credentials

Before deploying you'll have to assume a role for the environment you're deploying to.

If you have the `govuk aws` script available, you can use this to get
credentials corresponding to the profiles you have configured. For
example, for the profile called `govuk-integration`, you would run:

```sh
govuk aws --profile govuk-integration
```

Otherwise you can use the `aws` command line tool:

```sh
aws sts assume-role \
  --role-session-name "$(whoami)-$(date +%d-%m-%y_%H-%M)" \
  --role-arn <Role ARN> \
  --serial-number <MFA ARN> \
  --duration-seconds 28800 \
  --profile gds \
  --token-code <MFA token>
```

If you've [set up AWS CLI correctly](/manual/aws-cli-access.html) you can get the Role ARN and MFA ARN with `cat ~/.aws/config`.

## 3. Terraform `plan` & `deploy`

Always `plan` first, check the output is what you expect, then `apply`.
👉 [Deploy to integration using Jenkins][deploy-integration]

## 4. Use `tools/deploy.rb`

The Ruby script `tools/deploy.rb` in the `govuk-aws` repository takes care of requesting temporary AWS credentials with an assumed role and queuing the deployment Jenkins job.

To use this script, you need to have [set up AWS CLI
correctly][aws-cli-access] and have a [GitHub personal access
token][github-token] (with the `read:org` scope).

[aws-cli-access]: /manual/aws-cli-access.html
[github-token]: https://github.com/settings/tokens

Then, run the script like the following example:

```
GITHUB_USERNAME=<your GitHub username> GITHUB_TOKEN=<your GitHub personal access token> ruby tools/deploy.rb plan integration blue app-backend
```

If your AWS session has expired, you'll be asked for your MFA code. Once the script has run, you can visit the [Jenkins job][deploy-integration] to see it running or queued.

[deploy-integration]: https://ci-deploy.integration.publishing.service.gov.uk/job/Deploy_Terraform_GOVUK_AWS
