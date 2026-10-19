# Azure deployment

## What I deployed
Deployed the current JS web app and serving it on PORT 8080. It has been done using az CLI using a resource group & web application.

Build logs:

Note: 'az webapp deploy' does not run build automation (dependency installation, compilation, etc.) by default for Linux web apps. If your package is not pre-built, set the app setting SCM_DO_BUILD_DURING_DEPLOYMENT=true to enable builds during deployment.
Initiating deployment
Deploying from local path: artifacts/app.zip
Warming up Kudu before deployment.
Warmed up Kudu instance successfully.

...

You can visit your app at: https://app-waypoint-crusu.azurewebsites.net/
RuntimeSuccessful

## What I saw in the log

Made a few HTTP calls (valid and invalid ones), and checked how the application handles different states/sitations:

After the sucessfull deployment, the working health check works as expected:

1. 
Checking https://app-waypoint-crusu.azurewebsites.net/health
At most 30 attempts, 5 seconds apart
OK: the app answered 200 on attempt 1.

Healthcheck works as expected

2. 
$ curl \
  -X POST "$APP_URL/links" \
  -H "Content-Type: application/json" \
  -d '{"targetUrl":"https://example.com"}'
{
  "code": "lqWpNO",
  "targetUrl": "https://example.com",
  "clicks": 0,
  "createdAt": "2026-10-19T12:46:33.889Z"
}

A valid link POST returns a valid response

3.
curl   -X POST "$APP_URL/links"   -H "Content-Type: application/json"   -d '{"targetUrl":"https://example.com"}'

2026-10-19T12:48:51  Welcome, you are now connected to log-streaming service.

---

Ending Log Tail of existing logs ---
Starting Live Log Stream ---
2026-10-19T12:49:51  No new trace in the past 1 min(s).
2026-10-19T12:50:36.9456079Z POST /links 201               <--- The logged request

A proper request can be also found in the logs

---

curl   -X GET "$APP_URL"   -H "Content-Type: application/json"   -d '{"targetUrl":"https://example.com"}'

2026-10-19T12:50:36.9456079Z POST /links 201
2026-10-19T12:51:51  No new trace in the past 1 min(s).
2026-10-19T12:52:51  No new trace in the past 2 min(s).
2026-10-19T12:53:10.5666846Z GET / 200                     <--- The logged request

4.

curl   -X GET "$APP_URL/something"   -H "Content-Type: application/json"   -d '{"targetUrl":"https://example.com"}'

2026-10-19T12:54:05.4731745Z GET /something 404

A failed request can also be found in the logs