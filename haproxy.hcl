template {
  source = "/consul-template/template.d/haproxy.ctmpl"
  destination = "/etc/haproxy/haproxy.cfg"
  command = "haproxy -D -f /etc/haproxy/haproxy.cfg -sf $(pidof haproxy)"
}
