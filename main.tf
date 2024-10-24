terraform {
  required_providers {
    cloudflare = {
      source  = "cloudflare/cloudflare"
      version = "4.35.0"
    }
  }
}

provider "cloudflare" {
  email = "REPLACEME"
  api_key= "REPLACEME"
}

resource "cloudflare_tunnel" "REPLACEME" {
  account_id = "REPLACEME"
  name       = "test_tf"
  secret     = "REPLACEME"
  config_src = "cloudflare"
}

resource "cloudflare_record" "REPLACEME" {
  zone_id = "REPLACEME"
  name    = "REPLACEME"
  value   = "${cloudflare_tunnel.test_tf.cname}"
  type    = "CNAME"
  proxied = true 
}

resource "cloudflare_record" "icinga2" {
  zone_id = "REPLACEME"
  name    = "REPLACEME"
  value   = "${cloudflare_tunnel.test_tf.cname}"
  type    = "CNAME"
  proxied = true
}

resource "cloudflare_record" "uptimekuma" {
  zone_id = "REPLACEME"
  name    = "REPLACEME"
  value   = "${cloudflare_tunnel.test_tf.cname}"
  type    = "CNAME"
  proxied = true
}

resource "cloudflare_record" "kibana" {
  zone_id = "REPLACEME"
  name    = "REPLACEME"
  value   = "${cloudflare_tunnel.test_tf.cname}"
  type    = "CNAME"
  proxied = true
}

resource "cloudflare_tunnel_config" "testtf" {
  account_id = "REPLACEME"
  tunnel_id = cloudflare_tunnel.test_tf.id

config{
  ingress_rule {
    hostname = "REPLACEME"
    service  = "http://REPLACEME:3000"
  }
  ingress_rule {
    hostname = "REPLACEME"
    service  = "http://REPLACEME:90"
  }
  ingress_rule {
    hostname = "REPLACEME"
    service  = "http://REPLACEME:3001"
  }
  ingress_rule {
    hostname = "REPLACEME"
    service  = "http://REPLACEME:5601"
  }
  ingress_rule {
    hostname = "REPLACEME"
    service  = "http://REPLACEME"
  }
  ingress_rule {
    service = "http_status:404"
  }
}
}
