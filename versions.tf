terraform {
  required_version = ">= 0.13"
  required_providers {
    cloudflare = {
      source = "terraform-providers/cloudflare"
    }
    github = {
      source  = "hashicorp/github"
      # The Terraform GitHub provider at version 2.3.0 introduced a
      # breaking change (for us) regarding templates and variable
      # type constraints so, for the moment, stick to this version.
      version = "~> 2.2.1"
    }
  }
}
