# CI pipeline

## What the scripts do

### [`build.sh`](/scripts/build.sh)

- The first check verifies if any of the bash scripts have any errors (skips locally if it doesn't exist).
- The second step checks if the project contains a [`.gitignore`](/.gitignore) or [`README.md`](/README.md).

### [`test.sh`](/scripts/test.sh)

4 individual checks for:
- Readme existance
- [`.gitignore`](/.gitignore)
- Checks if [`build.sh`](/scripts/build.sh) is executable
- Checks if README start with a heading

### Later Edit - Module 4

#### [`build.sh`](/scripts/build.sh)

The extra `npm ci` installs the necessary dependencies for the JS project.

#### [`test.sh`](/scripts/test.sh)

The extra `npm test` runs the unit tests inside the JS project. The flow will be blocked if any of the tests won't pass.

### [`check-commit-messages.sh`](/scripts/check-commit-messages.sh)

Optional script that checks the commit message's formatting. Used initially as a hook locally and also included in the [`build-test-pipeline.yml`](/.github/workflows/build-test-pipeline.yml) workflow.

### Later Edit - Module 4

#### [`health-check.sh`](/scripts/health-check.sh)

Newly added script which checks if the deployed application answers. It takes several arguments/parameters:

- **parameter:** url. It is mandatory
- **ATTEMPTS:** how many times will the loop run and try to get a response from the url. The parameter is optional with a default value of 10
- **DELAY:** how much time will a run wait until moving to the next iteration. The parameter is optional with a default value of 5

## The failure the pipeline caught

I have tried removing [`.gitignore`](/.gitignore) in a first insance, and then [`README.md`](/README.md) and both situations will determine the pipeline to break.

[https://github.com/cipriRusu/devops-kurs-repo/actions/runs/37683786057/job/113006242511](https://github.com/cipriRusu/devops-kurs-repo/actions/runs/37683786057/job/113006242511)