FROM --platform=linux/amd64 envoyproxy/envoy:v1.25-latest

RUN apt-get update \
    && apt-get install --no-install-recommends -y curl \
    && apt-get autoremove -y \
    && apt-get clean \
    && rm -rf /tmp/* /var/tmp/* /var/lib/apt/lists/*
COPY ./front-envoy.yaml /etc/front-envoy.yaml
RUN chmod go+r /etc/front-envoy.yaml
CMD ["/usr/local/bin/envoy", "-c", "/etc/front-envoy.yaml", "--service-cluster", "front-proxy"]