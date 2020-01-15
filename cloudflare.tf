#
# Cloudflare resources.
#

resource "cloudflare_zone" "main" {
    zone = var.domain
    plan = "free"
}

resource "cloudflare_page_rule" "forward_www" {
    zone_id = cloudflare_zone.main.id
    target  = "www.${var.domain}/*"
    actions {
        forwarding_url {
            url         = "https://${var.domain}/$1"
            status_code = 301
        }
    }
}
