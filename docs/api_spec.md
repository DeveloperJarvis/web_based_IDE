# API Specification: Browser-Based Code Editor and Executor

**Author:** Developer Jarvis  
**Contact:** [https://github.com/DeveloperJarvis](https://github.com/DeveloperJarvis)

---

## 1. Overview

The API provides endpoints to submit code for execution, monitor job status, and check server health. It is designed for integration with the **frontend code editor** and **other clients**.

**Base URL:** `/api/v1`

**Authentication:** Optional (can be extended with API keys or OAuth)

**Content-Type:** `application/json`

---

## 2. Endpoints

### 2.1 Execute Code

**POST** `/execute`

Submit code for execution in a sandboxed environment.

**Request Body:**

```json
{
  "language": "python",
  "code": "print('Hello World')",
  "stdin": "optional input",
  "timeout": 5
}
```

**Parameters:**

| Field    | Type   | Required | Description                                    |
| -------- | ------ | -------- | ---------------------------------------------- |
| language | string | yes      | Programming language (`python`, `cpp`, `node`) |
| code     | string | yes      | Source code to execute                         |
| stdin    | string | no       | Standard input to pass to the program          |
| timeout  | int    | no       | Max execution time in seconds                  |

**Response:**

```json
{
  "job_id": "uuid-1234",
  "status": "queued"
}
```

- `job_id` – Unique identifier for the execution job.
- `status` – Initial status (`queued`).

---

### 2.2 Check Execution Status

**GET** `/status/{job_id}`

Fetch the current status of a submitted job.

**Response:**

```json
{
  "job_id": "uuid-1234",
  "status": "running",
  "start_time": "2026-03-13T12:34:56Z",
  "end_time": null,
  "output": "",
  "error": ""
}
```

**Fields:**

| Field      | Type   | Description                                  |
| ---------- | ------ | -------------------------------------------- |
| job_id     | string | Unique execution job ID                      |
| status     | string | `queued`, `running`, `completed`, `failed`   |
| start_time | string | ISO timestamp when execution started         |
| end_time   | string | ISO timestamp when execution ended (if done) |
| output     | string | Captured stdout                              |
| error      | string | Captured stderr                              |

---

### 2.3 Health Check

**GET** `/health`

Check server status and availability.

**Response:**

```json
{
  "status": "ok",
  "uptime": "3600",
  "active_jobs": 3
}
```

**Fields:**

| Field       | Type   | Description                      |
| ----------- | ------ | -------------------------------- |
| status      | string | `ok` or `error`                  |
| uptime      | int    | Server uptime in seconds         |
| active_jobs | int    | Number of jobs currently running |

---

### 2.4 Real-Time Output via WebSocket

**URL:** `ws://<server>/ws/execute/{job_id}`

- Connect to stream stdout/stderr in real-time.
- Events are sent as JSON:

```json
{
  "type": "stdout",
  "content": "Hello World\n"
}
```

```json
{
  "type": "stderr",
  "content": "Traceback (most recent call last)..."
}
```

```json
{
  "type": "complete",
  "status": "completed",
  "exit_code": 0
}
```

**Event Types:**

| Type     | Description                        |
| -------- | ---------------------------------- |
| stdout   | Standard output from the execution |
| stderr   | Standard error from the execution  |
| complete | Execution completed, final status  |

---

## 3. Error Handling

- **400 Bad Request:** Invalid parameters
- **404 Not Found:** Job ID does not exist
- **500 Internal Server Error:** Execution failure or system error
- **Timeout Handling:** Jobs exceeding the specified timeout are marked as `failed` and error message is returned.

---

## 4. Sample Usage

**Submit Python Code:**

```bash
curl -X POST http://localhost:8000/api/v1/execute \
-H "Content-Type: application/json" \
-d '{"language":"python","code":"print(\"Hello\")"}'
```

**Check Status:**

```bash
curl http://localhost:8000/api/v1/status/uuid-1234
```

**Connect via WebSocket:**

```javascript
const ws = new WebSocket("ws://localhost:8000/ws/execute/uuid-1234");
ws.onmessage = (event) => console.log(JSON.parse(event.data));
```

---

## 5. Notes

- All code execution happens **inside isolated sandboxes**.
- Maximum timeout defaults to 10 seconds if not specified.
- Output is streamed live to support **real-time terminal-like experience**.

```

```
