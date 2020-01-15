# Provider configs.
#
# See https://www.terraform.io/docs/providers/

provider "github" {
    token        = var.github_token
    organization = var.github_organization
}

provider "cloudflare" {
    api_token    = var.cloudflare_api_token
    account_id   = var.cloudflare_account_id
}
