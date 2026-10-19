# CI pipeline

## What the scripts do

build.sh -> first check verifies if any of the bash scripts have any errors (skips locally if it doesn't exist),
the second step checks if the project contains a .gitignore or README.md

test.sh -> 4 individual checks for: Readme existance, .gitignore, checks if build.sh is executable, checks if README start with a heading

Later Edit - Module 4:

build.sh -> the extra npm ci installs the necessary dependencies for the JS project.

test.sh -> the extra npm test runs the unit tests inside the JS project.

## The failure the pipeline caught
I have tried removing .gitignore in a first insance, and then README.md and both situations will determine the pipeline to break.

https://github.com/cipriRusu/devops-kurs-repo/actions/runs/37683786057/job/113006242511