// terraform code to backup cloudns into route 53

provider "aws" {
  region = "us-east-1"
  shared_credentials_file = "/Users/xxxx/.aws/credentials"
  profile = "xxxx"
}

resource "aws_route53_zone" "cloudns" {
  name = "cloudns.net"
}

resource "aws_route53_record" "cloudns" {
  zone_id = "${aws_route53_zone.cloudns.zone_id}"
  name = "${aws_route53_zone.cloudns.name}"
  type = "NS"
  ttl = 300
  records = [
    "ns1.cloudns.net.",
    "ns2.cloudns.net.",
    "ns3.cloudns.net.",
    "ns4.cloudns.net.",
    "ns5.cloudns.net.",
    "ns6.cloudns.net.",
    "ns7.cloudns.net.",
    "ns8.cloudns.net.",
    "ns9.cloudns.net.",
    "ns10.cloudns.net."
  ]
}

resource "aws_route53_record" "cloudns" {
  zone_id = "${aws_route53_zone.cloudns.zone_id}"
  name = "cloudns.net"
  type = "SOA"
  ttl = 300
  records = [
    "ns1.cloudns.net. hostmaster.cloudns.net. 2018122001 10800 3600 604800 3600"
  ]
}

resource "aws_route53_record" "cloudns" {
  zone_id = "${aws_route53_zone.cloudns.zone_id}"
  name = "cloudns.net"
  type = "A"
  ttl = 300
  records = [
    ""
    ]
}

