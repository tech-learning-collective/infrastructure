# Input variables.
#
# See https://www.terraform.io/docs/configuration/variables.html

#
# Credentials.
#
# These have no defaults and should be set by the user in the
# project's `terraform.tfvars` file (outside source control).
#
variable "github_token" {
    description = "API token with which to authenticate to GitHub."
    type        = string
}

variable "cloudflare_api_token" {
    description = "API token with which to authenticate to Cloudflare."
    type        = string
}

variable "cloudflare_account_id" {
    description = "Cloudflare Account ID of the account owning the zone (domain)."
    type        = string
}

#
# Provider variables.
#
variable "github_organization" {
    description = "Name of the organization on GitHub."
    default     = "tech-learning-collective"
    type        = string
}

#
# Resource variables.
#
variable "domain" {
    description = "Main domain name for the project."
    default     = "techlearningcollective.com"
    type        = string
}

variable "github_members" {
    description = "GitHub user account names and their role within the organization."
    type        = map(string)
}

variable "github_repositories" {
    description = "GitHub repositories."
    type        = map(
        object({
            description  = string
            homepage_url = string
            has_issues   = bool
            has_wiki     = bool
            topics       = list(string)
        })
    )
}
