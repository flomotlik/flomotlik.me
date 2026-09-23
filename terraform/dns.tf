# The zone itself. Imported, not created — it has existed since 2017 and its
# nameservers are registered with the domain. Terraform must adopt it exactly
# as it is; a replace here would change the nameservers and take the domain off
# the internet.
resource "aws_route53_zone" "flomotlik_me" {
  name = "flomotlik.me"

  lifecycle {
    prevent_destroy = true
  }
}

# Apex -> GitHub Pages. These four addresses are GitHub's published Pages IPs.
# The CloudFormation stack still thinks this is an S3 alias; it is not, and has
# not been for years.
resource "aws_route53_record" "apex_a" {
  zone_id = aws_route53_zone.flomotlik_me.zone_id
  name    = "flomotlik.me"
  type    = "A"
  ttl     = 300
  records = [
    "185.199.108.153",
    "185.199.109.153",
    "185.199.110.153",
    "185.199.111.153",
  ]
}

resource "aws_route53_record" "www" {
  zone_id = aws_route53_zone.flomotlik_me.zone_id
  name    = "www.flomotlik.me"
  type    = "CNAME"
  ttl     = 300
  records = ["flomotlik.github.io"]
}

# Live email. Do not reorder, reformat or "tidy" these values.
resource "aws_route53_record" "mx" {
  zone_id = aws_route53_zone.flomotlik_me.zone_id
  name    = "flomotlik.me"
  type    = "MX"
  ttl     = 3600
  records = [
    "1 ASPMX.L.GOOGLE.COM",
    "5 ALT1.ASPMX.L.GOOGLE.COM",
    "5 ALT2.ASPMX.L.GOOGLE.COM",
    "10 ALT3.ASPMX.L.GOOGLE.COM",
    "10 ALT4.ASPMX.L.GOOGLE.COM",
  ]

  lifecycle {
    prevent_destroy = true
  }
}

resource "aws_route53_record" "txt" {
  zone_id = aws_route53_zone.flomotlik_me.zone_id
  name    = "flomotlik.me"
  type    = "TXT"
  ttl     = 43200
  records = ["google-site-verification=FUiaYFFdYrCtrcLB8viZUwT7Q2RjQAqksNJGw4WxWko"]
}

# --- New ------------------------------------------------------------------

# design-system.flomotlik.me -> the flomotlik/design-system Pages site.
# A CNAME rather than the apex A records, because the subdomain can point at
# the github.io host directly and follow GitHub's IPs if they ever change.
resource "aws_route53_record" "design_system" {
  zone_id = aws_route53_zone.flomotlik_me.zone_id
  name    = "design-system.flomotlik.me"
  type    = "CNAME"
  ttl     = 300
  records = ["flomotlik.github.io"]
}
