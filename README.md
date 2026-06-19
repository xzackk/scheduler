# 🌍 TZ Event Scheduler

A tiny self-hosted tool for scheduling client events across timezones. Enter a
client-provided date/time/zone, convert it to **Sofia time** and **UTC**, and
generate a ready-to-paste Outlook event template.

Single self-contained `index.html` - no build step, no external dependencies.
Served as a static site behind nginx.

## Features

- Date + time + timezone → **Sofia (EET/EEST)** and **UTC** conversion
- Shows the hour/date difference, including day rollovers
- Editable email templates with auto-filled maintenance window (UTC)
- Manage the timezone dropdown (add/remove from ~70 zones), persisted in `localStorage`
- Dark / light theme

## Run locally (no Docker)

Just open `index.html` in a browser.

## Build & run with Docker

```bash
docker build -t scheduler:latest .
docker run --rm -p 8080:8080 scheduler:latest
# open http://localhost:8080
```

## Deploy to k3s

1. Build and push the image to your registry (e.g. GHCR):

   ```bash
   docker build -t ghcr.io/<you>/scheduler:latest .
   docker push ghcr.io/<you>/scheduler:latest
   ```

2. Edit the placeholders:
   - `k8s/deployment.yaml` → set the `image:`
   - `k8s/ingress.yaml` → set the `host:` (and TLS, if used)

3. Apply:

   ```bash
   kubectl apply -f k8s/
   ```

k3s ships Traefik as the default ingress controller, so the included
`ingress.yaml` works out of the box once the host is set.

## Deploy with Docker + Cloudflare Tunnel (recommended)

Simplest path for a single static site. `docker-compose.yml` runs three
containers: the app, a Cloudflare Tunnel (public access, no open ports), and
Watchtower (auto-pulls a new image when GitHub Actions pushes `:latest`).

1. In Cloudflare **Zero Trust → Networks → Tunnels**, create a tunnel, copy its
   **token**, and add a **public hostname**: `scheduler.<your-domain>` →
   `http://scheduler:8080`.
2. On the server:
   ```bash
   git clone https://github.com/<you>/scheduler.git
   cd scheduler
   cp .env.example .env      # set IMAGE + TUNNEL_TOKEN
   docker compose up -d
   ```

Updates are automatic: push to `main` → Actions builds & pushes to GHCR →
Watchtower redeploys within ~2 min. (Make the GHCR package **public**, or log
the server in to GHCR, so it can pull.)

## Project layout

```
tz-scheduler/
├── index.html          # the whole app
├── nginx.conf          # static-serving config (port 8080)
├── Dockerfile          # nginx-unprivileged, non-root
├── docker-compose.yml  # app + cloudflared + watchtower
├── .env.example        # IMAGE + TUNNEL_TOKEN
├── .dockerignore
└── k8s/
    ├── deployment.yaml # Deployment + Service
    └── ingress.yaml    # Traefik ingress
```
