# Automated deployment

## The chain

Deployment to Azure so far has been handled through manually triggering it through the Azure CLI. The same script now is included in **deploy-app-service.sh** which is further called in the **deploy-app-service-pipeline.yml**. This specific pipeline is triggered on changes merged into the **main** branch of the repository.

Opening a pull request has no effect on the deployment process, triggering just the **build-test-pipeline.yml** which makes sure the changes are valid, tests pass and any other quality gates are being set up at this stage.

Assuming that no PRs will reach the **main** branch unless the changes have been reviewed and all the unit tests pass, these changes are valid and deployment should work without any issues once the PR is merged to **main**.

After deployment, the final check is the smoke test that compares the last version running in deployment is the latest commited version. The test is just a simple check and has nothing to do with the quality of the code.

## The rollback I tried

The mechanism of the smoke test adds a single file to the deployment folder which contains the SHA code of the latest commit. Test script itself checks if the latest local pushed commit is in production, and blocks deployment if not.

1.[Purposely broken deployment](https://github.com/cipriRusu/devops-kurs-repo/actions/runs/40715009894/job/124844596563) which contains valid code that would pass the quality gates, reach deployment but would get blocked by the smoke test.

2.[Reverted change](https://github.com/cipriRusu/devops-kurs-repo/actions/runs/40732051381) reverting this change would create a valid deployment that works.