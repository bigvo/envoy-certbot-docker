# Envoy & Certbot with CloudFlare API in Docker - usage example
This is an example how to configure Envoy and Certbot to automatically renew certificates, Envoy automatically watch if certs are updated and hot-reload them.
Because Envoy doesn't support ACME challenge, DNS challenge done via Cloudflare.

To use this example put cloudflare.ini file in cfg directory with token created in Cloudflare dashboard.
(!Important to create and use Zone edit token, !not a Global one!)

Create .env file and save:
```
DOMAIN=example.com
EMAIL=some@email.com
```

Create a volume to save issued certificates:
```
docker volume create certs
```

Create Docker network via which Dockerized app will be proxied (Or modify docker compose up to your needs)
```
docker network create dockernet
```

In compose file and Envoy config external network is used, feel free to adjust it for your needs.
Because Envoy can't push environment variables to config, update front-envoy to your domain

## First time certificate acquire
```
docker compose run --rm acquire
```

To test and not exceed acquire attemps use dry-run:
```
docker compose run --rm acquire --dry-run
```

## Start infinite loop to run every 12H certbot renew
```
docker compose up -d renew
```

## Start Envoy reverse proxy server
```
docker compose up -d envoy
```