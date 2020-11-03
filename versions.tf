terraform {
  required_version = ">= 0.13"
  required_providers {
    cloudflare = {
      source = "terraform-providers/cloudflare"
    }
    github = {
      source  = "hashicorp/github"
      version = "~> 3"
    }
  }
}
