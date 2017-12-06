provider "dnsimple" {
  token   = "helllo"
  account = "world"
}

resource "dnsimple_record" "example" {
  domain = "one.two.com"
  type   = "A"
  name   = "anything"
  value  = "${aws_instance.web.0.public_ip}"
}
