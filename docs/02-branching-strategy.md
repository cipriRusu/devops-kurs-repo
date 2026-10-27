# Branching Strategy

## Chosen Strategy

The chosen branching strategy for the application is the short/frequent branches strategy. It allows for small nuclear PRs that will be easier to follow and isolate which is the whole point of PRs.

---

## Branch Protection

Standard main branch protection has been setup on the main branch, so all changes need to go through a pull request.

Given that the is a single person that owns/uses the repository, PR's require no review at the very moment and can be merged to main directly.

---

## Tagging and Versioning

Tag `v0.1.0` has been added and is the first tagged version of the application, where the repo has in place a pull request template, a CODEOWNERS but

Agreed protocol for tagging is the following

## Versioning: `v0.0.0`

- **First `0` — Application flag:** Unchanged, since there is no application yet.
- **Second `0` — Feature flag:** Updated with `feat:`.
- **Third `0` — Fix flag:** Updated with `fix:`.

### Documentation Updates

The version number does not change when updating documentation. The `docs:` tag is reserved exclusively for documentation updates.