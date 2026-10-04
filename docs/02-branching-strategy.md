# Branching strategy

## Chosen strategy
The chosen branching strategy for the application is the short/frequent branches strategy. It allows for small
nuclear PRs that will be easier to follow and isolate which is the whole point of PRs.

## Branch protection
Standard main branch protection has been setup on the main branch, so all changes need to go through a pull request.
Given that the is a single person that owns/uses the repository, PR's require no review at the very moment and can
be merged to main directly.

## Tagging and versioning
Tag v0.1.0 has been added and is the first tagged version of the application, where the repo has in place a pull request template,
a CODEOWNERS but has no application yet.

Agreed protocol for tagging is the following

v0.0.0

First 0 -> Application flag (Unchanged since there is no application yet)
Second 0 -> Feature flag (Updated with feat:)
Third 0 -> Fix flag (Updated with fix:)

Does not update any of the tags, reserved only for updating documentation -> docs: 