FROM alpine

ENV CONSUL_TEMPLATE_VERSION=0.14.0

# Update wget to get support for SSL
RUN apk --update add haproxy wget && \
    rm -rf /var/cache/apk/*

# Download consul-template
RUN wget -q --no-check-certificate https://releases.hashicorp.com/consul-template/${CONSUL_TEMPLATE_VERSION}/consul-template_${CONSUL_TEMPLATE_VERSION}_linux_amd64.zip \
    -O /tmp/consul_template.zip && \
    unzip /tmp/consul_template.zip && \
    mv consul-template /usr/bin && \
    rm -rf /tmp/*

COPY haproxy.cfg /tmp/haproxy.cfg
COPY haproxy.ctmpl /tmp/haproxy.ctmpl

ENTRYPOINT ["consul-template","-config=/tmp/haproxy.cfg"]
CMD ["-consul=127.0.0.1:8500"]
