# Unprivileged variant: listens on 8080, runs as uid 101 by default
FROM nginxinc/nginx-unprivileged:1.27-alpine

# Static site — single self-contained HTML, no build step needed
COPY index.html /usr/share/nginx/html/index.html
COPY nginx.conf /etc/nginx/conf.d/default.conf

<<<<<<< HEAD
EXPOSE 3005

# Run as non-root (nginx-alpine ships an "nginx" user)
HEALTHCHECK --interval=30s --timeout=3s \
  CMD wget -qO- http://127.0.0.1:3005/ >/dev/null 2>&1 || exit 1
=======
EXPOSE 8080

# Run as non-root (nginx-alpine ships an "nginx" user)
HEALTHCHECK --interval=30s --timeout=3s \
  CMD wget -qO- http://127.0.0.1:8080/ >/dev/null 2>&1 || exit 1
>>>>>>> 3c9ae6daf97c7c66675341145046a5eb7c6424e8
