# GitHub resources.
#
# See https://www.terraform.io/docs/providers/github/

#
# GitHub organization memberships.
#
resource "github_membership" "members" {
    for_each = var.github_members

    username = each.key
    role     = each.value
}

#
# GitHub organization repositories.
#

resource "github_repository" "repos" {
    for_each     = var.github_repositories

    name         = each.key
    description  = each.value.description
    homepage_url = each.value.homepage_url
    has_issues   = each.value.has_issues
    has_wiki     = each.value.has_wiki
    topics       = each.value.topics
}
