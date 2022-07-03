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

In compose file and Envoy config external network is used, feel free to adjust it for your needs.

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
docker compose up renew
```

## Start Envoy reverse proxy server
```
docker compose up envoy
```