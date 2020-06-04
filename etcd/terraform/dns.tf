
# Private (internal) DNS zone

resource "aws_route53_zone" "internal" {
  name = "${var.internal_dns_zone_name}"
  vpc { vpc_id = "${aws_vpc.main.id}" }
  force_destroy = true # etcd CNAMEs are not managed by Terraform, so Terraform must destroy the zone even when entries not Terraform-managed are present.

  tags {
    Name = "${var.vpc_name}"
    Owner = "${var.owner}"
  }
}

# SRV records for etcd DNS Discovery
# DNS records used for etcd DNS service discovery

resource "template_file" "srv_etcd_server_record" {
  count = "${var.node_count}"
  template = "0 0 ${var.etcd_peer_port} etcd${count.index}.${var.internal_dns_zone_name}"
}
resource "template_file" "srv_etcd_client_record" {
  count = "${var.node_count}"
  template = "0 0 ${var.etcd_client_port} etcd${count.index}.${var.internal_dns_zone_name}"
}


resource "aws_route53_record" "srv_etcd_server" {
  zone_id = "${aws_route53_zone.internal.id}"
  name = "_etcd-server._tcp"
  type = "SRV"
  ttl = 60
  records = ["${template_file.srv_etcd_server_record.*.rendered}"]
}
resource "aws_route53_record" "srv_etcd_client" {
  zone_id = "${aws_route53_zone.internal.id}"
  name = "_etcd-client._tcp"
  type = "SRV"
  ttl = 60
  records = ["${template_file.srv_etcd_client_record.*.rendered}"]
}
