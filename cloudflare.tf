#
# Cloudflare resources.
#

resource "cloudflare_zone" "main" {
    zone = var.domain
    plan = "free"
}

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
