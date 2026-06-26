# Security Policy

## Reporting a vulnerability

Please report security issues **privately** — do not open a public issue for
anything sensitive.

- Preferred: use GitHub's **[Private vulnerability reporting](https://github.com/xzackk/scheduler/security/advisories/new)**
  (Security tab → Report a vulnerability).
- You will get an acknowledgement, and a fix or response as soon as possible.

## Scope

This is a self-contained static web app (a single `index.html` served by nginx).
There is no backend and no user data stored on the server — templates, timezones
and theme live only in the visitor's browser `localStorage`.

When self-hosting, the main things to secure are your own deployment:
the reverse proxy / tunnel, access controls, and any secrets in `.env`
(which is git-ignored and must never be committed).

## Supported versions

The latest `main` is the only supported version.
