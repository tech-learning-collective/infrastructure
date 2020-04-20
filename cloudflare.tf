#
# Cloudflare resources.
#

resource "cloudflare_zone" "main" {
    zone = var.domain
    plan = "free"
}

#
# Cloudflare DNS.
#
# GitHub Pages provides four redundant IP addresses. Use all of them.
#
resource "cloudflare_record" "gh_pages_1" {
    zone_id = cloudflare_zone.main.id
    type    = "A"
    name    = "@"
    value   = "185.199.108.153"
    proxied = true
}

resource "cloudflare_record" "gh_pages_2" {
    zone_id = cloudflare_zone.main.id
    type    = "A"
    name    = "@"
    value   = "185.199.109.153"
    proxied = true
}

resource "cloudflare_record" "gh_pages_3" {
    zone_id = cloudflare_zone.main.id
    type    = "A"
    name    = "@"
    value   = "185.199.110.153"
    proxied = true
}

resource "cloudflare_record" "gh_pages_4" {
    zone_id = cloudflare_zone.main.id
    type    = "A"
    name    = "@"
    value   = "185.199.111.153"
    proxied = true
}

# We don't use the `www` subdomain, so we only have one record for it.
resource "cloudflare_record" "gh_pages_www_1" {
    zone_id = cloudflare_zone.main.id
    type    = "A"
    name    = "www"
    value   = "185.199.108.153"
    proxied = true
}

# Custom Cloudflare DNS rules.
resource "cloudflare_record" "hacker-trivia-night" {
    zone_id = cloudflare_zone.main.id
    type    = "CNAME"
    name    = "hacker-trivia-night"
    value   = "${var.github_organization}.github.io"
    proxied = true
}

# Hackers Next Door
resource "cloudflare_record" "hnd" {
    zone_id = cloudflare_zone.main.id
    type    = "CNAME"
    name    = "hnd"
    value   = "${var.github_organization}.github.io"
    proxied = true
}

#
# Cloudflare Page Rules.
#
resource "cloudflare_page_rule" "forward_www" {
    zone_id  = cloudflare_zone.main.id
    target   = "www.${var.domain}/*"
    priority = 1
    actions {
        forwarding_url {
            url         = "https://${var.domain}/$1"
            status_code = 301
        }
    }
}

# The SEC101 placement test has a question regarding HTML comments.
# These should be retained in the output, so we cannot minify the page
# on which these comments exist via Cloudflare like we do for the rest
# of the site.
resource "cloudflare_page_rule" "sec101_placement_test" {
    zone_id  = cloudflare_zone.main.id
    target   = "${var.domain}/courses/sec101*"
    priority = 2
    actions {
        minify {
            html = "off"
            css  = "on"
            js   = "on"
        }
    }
}
