# Tech Learning Collective - Infrastructure

This repository is a [Terraform](https://terraform.io/) root [module](https://www.terraform.io/docs/modules/) that provisions [Tech Learning Collective](https://techlearningcollective.com/) infrastructure. We at Tech Learning Collective use this code to run our own infrastructure, but it is variablized to a modest extent to keep certain bits of private information out of the codebase and also so that you can reuse this module with your own [input variables](https://www.terraform.io/docs/configuration/variables.html) to create an independent organization that mirrors the structure of the Tech Learning Collective. We also hope this will serve as an illustrative example to our students who are learning about Infrastructure-as-Code (IaC) practices in any of [our courses](https://techlearningcollective.com/courses/).

## Prerequisites

Currently, this module provisions infrastructure on the following cloud providers:

* [GitHub.com](https://github.com/)
* [Cloudflare](https://cloudflare.com/)

This means you must have (optionally, free) accounts with these providers to make use of this module.

## Quick start

1. Download the source code:
    ```sh
    git clone https://github.com/tech-learning-collective/infrastructure.git
    ```
1. Go to the module directory and copy the various files ending in `.tfvars-sample` to the same path without that suffix:
    ```sh
    cd infrastructure
    for i in $(ls *.tfvars-sample); do cp "$i" $(basename -s .tfvars-sample "$i"); done;
    ```
1. Fill in the variables in all of those files according to the instructions provided in the comments:
    ```sh
    vim $(ls *.tfvars)
    ```
    These will include your provider credentials (API keys/tokens) and organization-specific resources (domain names, user account names, etcetera). Remember to grant appropriate privileges for your tokens; e.g., GitHub API tokens require the `admin:org` [scope](https://developer.github.com/apps/building-oauth-apps/scopes-for-oauth-apps/) in order to make changes to the GitHub Organization resource, such as adding members.
1. Once configured to your liking, run `terraform` as you normally would:
    ```sh
    terraform init
    terraform plan
    ```
1. If the report of the `terraform plan` looks good, apply the configuration to create your infrastructure:
    ```sh
    terraform apply
    ```
1. If you'd like to store this code in your own organization, configure a Git remote in your clone to point at your organization's `infrastructure` repository, which will have been created by the above `terraform apply` invocation, and then `git push` this code to it:
    ```sh
    git remote add $YOUR_GIT_REMOTE_NAME git@github.com:${YOUR_ORGANIZATION_NAME}/infrastructure.git
    git push $YOUR_GIT_REMOTE_NAME master
    ```
