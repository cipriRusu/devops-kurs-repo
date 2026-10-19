
# Azure Deployment

## 1. What I Deployed

Deployed the current JavaScript web application to Azure and configured it to serve traffic on **port 8080**.

The deployment was performed using the **Azure CLI (`az`)**, with an Azure Resource Group and Web App.

### Deployment Logs

> **Note:** `az webapp deploy` does not run build automation (such as dependency installation or compilation) by default for Linux web apps. If the package is not pre-built, set the app setting `SCM_DO_BUILD_DURING_DEPLOYMENT=true` to enable builds during deployment.

```text
Initiating deployment
Deploying from local path: artifacts/app.zip
Warming up Kudu before deployment.
Warmed up Kudu instance successfully.
...
```

**Deployment result:** `RuntimeSuccessful`

**Application URL:** https://app-waypoint-crusu.azurewebsites.net/

---

## 2. Application and Log Verification

I made several HTTP requests, including valid and invalid requests, to verify how the application handles different states and situations. I also checked the application logs to confirm that requests were recorded.

### 2.1 Health Check

**Endpoint:** `/health`

Checked the application with a maximum of 30 attempts, spaced 5 seconds apart.

**Result: Successful**

```text
OK: the app answered 200 on attempt 1.
```

The application responded with HTTP `200 OK` on the first attempt.

---

### 2.2 Create a Link — Valid POST Request

**Request:**

```bash
curl \
  -X POST "$APP_URL/links" \
  -H "Content-Type: application/json" \
  -d '{"targetUrl":"https://example.com"}'
```

**Response:**

```json
{
  "code": "lqWpNO",
  "targetUrl": "https://example.com",
  "clicks": 0,
  "createdAt": "2026-10-19T12:46:33.889Z"
}
```

**Result: Successful**

The application accepted the valid POST request and returned a response containing the generated link code, target URL, click count, and creation timestamp.

---

### 2.3 Verify Request Logging — Valid POST Request

**Request:**

```bash
curl \
  -X POST "$APP_URL/links" \
  -H "Content-Type: application/json" \
  -d '{"targetUrl":"https://example.com"}'
```

**Relevant log output:**

```text
2026-10-19T12:48:51  Welcome, you are now connected to log-streaming service.

Ending Log Tail of existing logs ---
Starting Live Log Stream ---

2026-10-19T12:49:51  No new trace in the past 1 min(s).
2026-10-19T12:50:36.9456079Z POST /links 201
```

**Result: Successful**

The application log contains the `POST /links` request with HTTP status `201 Created`, confirming that a successful link-creation request was logged.

---

### 2.4 Verify Request Logging — GET `/`

**Request:**

```bash
curl \
  -X GET "$APP_URL" \
  -H "Content-Type: application/json" \
  -d '{"targetUrl":"https://example.com"}'
```

**Relevant log output:**

```text
2026-10-19T12:50:36.9456079Z POST /links 201
2026-10-19T12:51:51  No new trace in the past 1 min(s).
2026-10-19T12:52:51  No new trace in the past 2 min(s).
2026-10-19T12:53:10.5666846Z GET / 200
```

**Result: Successful**

The log shows a `GET /` request with HTTP status `200 OK`, confirming that the request was recorded.

---

### 2.5 Verify Error Handling — GET `/something`

**Request:**

```bash
curl \
  -X GET "$APP_URL/something" \
  -H "Content-Type: application/json" \
  -d '{"targetUrl":"https://example.com"}'
```

**Relevant log output:**

```text
2026-10-19T12:54:05.4731745Z GET /something 404
```

**Result: Expected error response**

The application returned HTTP `404 Not Found` for the unrecognized `/something` path. The failed request was also recorded in the application logs.

---

## 3. Summary

The deployment and initial verification confirmed the following:

- **Deployment:** The JavaScript web application was deployed to Azure successfully.
- **Health check:** The `/health` endpoint returned HTTP `200 OK` on the first attempt.
- **Link creation:** A valid `POST /links` request returned a successful response with the generated link details.
- **Request logging:** Successful POST and GET requests were visible in the application logs.
- **Error handling:** A request to an unrecognized endpoint returned HTTP `404 Not Found` and was recorded in the logs.

Overall, the checks demonstrate that the deployed application responds to HTTP requests and that both successful requests and a failed route request can be observed in the application logs.