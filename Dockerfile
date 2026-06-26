# Unprivileged variant: runs as uid 101; nginx.conf makes it listen on 3005
FROM nginxinc/nginx-unprivileged:1.31-alpine

# Static site — single self-contained HTML, no build step needed
COPY index.html /usr/share/nginx/html/index.html
COPY nginx.conf /etc/nginx/conf.d/default.conf

EXPOSE 3005

# Run as non-root (nginx-alpine ships an "nginx" user)
HEALTHCHECK --interval=30s --timeout=3s \
  CMD wget -qO- http://127.0.0.1:3005/ >/dev/null 2>&1 || exit 1
