# Contributing

Thanks for helping improve XZ. Event Scheduler! This project follows a simple
**GitHub Flow**: short-lived branches, one pull request per change, reviewed and
merged into `main`.

## Workflow

1. **Branch off `main`** for every change — one branch per feature or fix.
   Keep branches small and focused so they're easy to review.
2. **Commit** using the Conventional Commits style (see below).
3. **Open a pull request** into `main`. Fill in the PR template.
4. After review, **squash & merge**, then delete the branch.

> Don't push directly to `main` — everything goes through a PR.

## Branch naming

```
feat/<short-description>      new feature        e.g. feat/dst-aware-timezones
fix/<short-description>       bug fix            e.g. fix/opera-select-hover
docs/<short-description>      documentation      e.g. docs/readme-deploy
chore/<short-description>     maintenance        e.g. chore/bump-nginx
refactor/<short-description>  internal cleanup   e.g. refactor/template-render
```

Optionally prefix with the issue number: `fix/12-dst-warning`.

## Commit messages — Conventional Commits

```
<type>: <short summary in present tense>

[optional body explaining what and why]
```

Types: `feat`, `fix`, `docs`, `chore`, `refactor`, `style`, `test`, `perf`.

Examples:
```
feat: add DST-aware source timezones with mismatch warning
fix: remove native select arrow box in Opera on hover
docs: correct nginx port to 3005 in README
```

## Linking issues

In the PR description, use a closing keyword so the issue closes automatically
when the PR is merged into `main`:

```
Closes #12      (also: Fixes #12, Resolves #12)
```

## Pull requests

- Title in Conventional Commits style (matches the squash-merge commit).
- Describe **what**, **why**, and **how it was tested**.
- Prefer **Squash & merge** to keep `main` history clean (one commit per PR).

## Local development

The app is a single self-contained `index.html` — no build step. Open it in a
browser, or run it with Docker (see [README](README.md)).
