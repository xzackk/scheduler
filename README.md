# 🌍 XZ. Event Scheduler

[![Build & push image](https://github.com/xzackk/scheduler/actions/workflows/docker.yml/badge.svg)](https://github.com/xzackk/scheduler/actions/workflows/docker.yml)
[![License: MIT](https://img.shields.io/badge/License-MIT-green.svg)](LICENSE)

A tiny self-hosted tool for scheduling client events across timezones. Enter a
client-provided date/time/zone, convert it to **Sofia time** and **UTC**, and
generate a ready-to-paste Outlook event template.

Single self-contained `index.html` - no build step, no external dependencies.
Served as a static site behind nginx.

## Features

- Date + time + timezone → **Sofia (EET/EEST)** and **UTC** conversion
- Shows the hour/date difference, including day rollovers
- Optional window end for scheduling windows, shown as a range
- Editable email templates with copyable subject + auto-filled maintenance window
- Any `{{token}}` in a template becomes an input field; fields can be links
- Manage the timezone dropdown (add/remove from ~70 zones)
- Dark / light theme — everything persists in `localStorage`

> Templates, timezones and theme live in each user's **browser**, not on the
> server, so internal links never reach this repo.

## Run locally (no Docker)

Just open `index.html` in a browser.

## Build & run with Docker

```bash
docker build -t scheduler:latest .
docker run --rm -p 3006:3005 scheduler:latest
# open http://localhost:3006
```

nginx listens on **3005** inside the container.

## Deploy with Docker Compose

`docker-compose.yml` runs the single nginx container and bind-mounts
`index.html` / `nginx.conf` / favicon, so the content comes from the repo files
(no rebuild needed to update — just `git pull`).

```bash
git clone https://github.com/<you>/scheduler.git
cd scheduler
cp .env.example .env      # optional: set IMAGE (defaults to GHCR)
docker compose up -d
# served on http://<host>:3006
```

**Update:** `git pull && docker compose restart` — nginx re-reads the
bind-mounted `index.html` immediately.

The `wud.watch=true` label lets [WUD](https://github.com/getwud/wud) (or any
image-update notifier you run) flag new base-image versions; it does not
auto-update.

## Public access (Cloudflare Tunnel)

Expose it through a Cloudflare Tunnel by adding a **public hostname** that points
to the container — `http://scheduler:3005` if `cloudflared` shares the Docker
network, or `http://<host>:3006` otherwise. No inbound ports need to be opened.

## Deploy to k3s (alternative)

Manifests are in `k8s/` for running on an existing cluster.

1. Set the image in `k8s/deployment.yaml` and the host in `k8s/ingress.yaml`.
2. `kubectl apply -f k8s/`

k3s ships Traefik as the default ingress controller, so `ingress.yaml` works out
of the box once the host is set.

## CI

`.github/workflows/docker.yml` builds the image on every push to `main` and
pushes it to `ghcr.io/<you>/scheduler:latest`.

## Project layout

```
scheduler/
├── index.html          # the whole app
├── nginx.conf          # static-serving config (port 3005)
├── Dockerfile          # nginx-unprivileged, non-root
├── docker-compose.yml  # single app container, bind-mounted content
├── .env.example        # IMAGE override
├── .dockerignore
├── .github/workflows/  # CI: build & push image to GHCR
└── k8s/                # optional Kubernetes / k3s manifests
```

## Contributing

Pull requests welcome. See [CONTRIBUTING.md](CONTRIBUTING.md) for the branch
naming, commit, and PR conventions.

## License

MIT - see [LICENSE](LICENSE).
