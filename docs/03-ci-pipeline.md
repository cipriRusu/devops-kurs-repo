# CI pipeline

## What the scripts do

build.sh -> first check verifies if any of the bash scripts have any errors (skips locally if it doesn't exist),
the second step checks if the project contains a .gitignore or README.md

test.sh -> 4 individual checks for: Readme existance, .gitignore, checks if build.sh is executable, checks if README start with a heading

## The failure the pipeline caught
I have tried removing .gitignore in a first insance, and then README.md and both situations will determine the pipeline to break.