# **Low-Level Design (LLD)** for a **Browser-based Code Editor & Executor**

---

# 1⃣ System Overview

A **browser-based code editor** allows users to:

1. Write code in the browser
2. Execute code remotely
3. Stream output in real-time
4. Maintain execution isolation (sandbox)
5. Handle multiple users simultaneously

Example platforms:

- online IDEs
- coding interview tools
- notebook-like platforms

---

# 2⃣ High-Level Architecture

```
Browser (Code Editor UI)
        |
        | HTTP / WebSocket
        v
API Gateway / Backend Server
        |
        | Task Queue
        v
Execution Manager
        |
        | Sandbox Container
        v
Code Runner
        |
        v
Streaming Output
```

---

# 3⃣ Major Components

## 1. Frontend (Browser Editor)

Responsibilities:

- Code editing
- Language selection
- Send execution requests
- Receive output streams
- Display logs/errors

### Key Features

Editor (e.g. Monaco):

- syntax highlighting
- autocomplete
- formatting

### Client Actions

```
User writes code
↓
Click Run
↓
Send code to backend
↓
Receive output via WebSocket
↓
Display logs in terminal
```

---

# 4⃣ Backend Services

## 4.1 API Server

Handles **HTTP requests** from the browser.

Responsibilities:

- receive code
- validate input
- create execution job
- send job to execution queue
- return execution ID

### APIs

**POST /execute**

Request:

```
{
  language: "python",
  code: "print('hello')",
  input: ""
}
```

Response:

```
{
  execution_id: "abc123",
  websocket_url: "/ws/abc123"
}
```

---

## 4.2 WebSocket Server

Used for **real-time output streaming**.

Responsibilities:

- connect client to execution job
- stream stdout/stderr
- send execution status
- handle disconnects

### Flow

```
Browser connects to WebSocket
↓
Subscribes to execution_id
↓
Receives logs
↓
Execution complete message
```

---

# 5⃣ Execution Manager

Responsible for **orchestrating code execution**.

Responsibilities:

- manage execution lifecycle
- allocate sandbox
- enforce time limits
- track job status
- kill runaway processes

### Internal Steps

```
Receive execution job
↓
Create sandbox environment
↓
Start code runner
↓
Stream logs
↓
Cleanup resources
```

---

# 6⃣ Sandbox Environment

Critical for **security**.

User code must never run directly on the server.

### Options

1⃣ Docker containers
2⃣ Firecracker microVMs
3⃣ gVisor sandbox

### Responsibilities

- isolate processes
- restrict filesystem
- restrict network
- enforce CPU/memory limits

### Security Restrictions

```
No root access
Limited memory
Limited CPU
No external internet
Filesystem isolation
```

---

# 7⃣ Code Runner

Executes the code inside the sandbox.

Responsibilities:

- write user code to file
- compile (if needed)
- execute program
- capture output
- send logs

### Execution Pipeline

```
Receive code
↓
Create temp directory
↓
Write file
↓
Run interpreter
↓
Capture stdout/stderr
↓
Stream output
```

---

# 8⃣ Streaming Output System

Execution output is **streamed line-by-line**.

Mechanism:

```
Program output
↓
Captured by runner
↓
Sent to WebSocket server
↓
Forwarded to client
```

Example output stream:

```
Compiling...
Running...
Hello World
Execution finished
```

---

# 9⃣ Job Queue System

Prevents blocking the API server.

### Responsibilities

- manage execution jobs
- support concurrency
- retry failed tasks

### Possible Tools

- Redis queue
- RabbitMQ
- Kafka
- Celery workers

### Flow

```
API receives request
↓
Push job to queue
↓
Worker picks job
↓
Execution manager runs job
```

---

# 🔟 Storage Layer

Used for persistence.

### Stored Data

Execution metadata

```
Execution ID
User ID
Language
Code
Status
Start time
End time
Logs
```

### Database Options

- PostgreSQL
- MongoDB

---

# 1⃣1⃣ Execution State Machine

Each execution has states:

```
CREATED
QUEUED
RUNNING
COMPLETED
FAILED
TIMEOUT
```

Transitions:

```
CREATED → QUEUED
QUEUED → RUNNING
RUNNING → COMPLETED
RUNNING → FAILED
RUNNING → TIMEOUT
```

---

# 1⃣2⃣ Security Considerations

Critical in a code execution platform.

### Protection Measures

Input validation

Sandbox isolation

Rate limiting

Execution limits:

```
Max runtime: 5 sec
Max memory: 256MB
Max file size
```

Disable:

```
fork bombs
infinite loops
network access
file system access
```

---

# 1⃣3⃣ Scalability Design

To support many users:

### Horizontal scaling

```
Multiple API servers
Multiple workers
Container orchestration
```

Use:

- Kubernetes
- Docker Swarm

### Auto-scaling workers

When queue grows:

```
Spawn more execution containers
```

---

# 1⃣4⃣ Failure Handling

Possible failures:

1⃣ Container crash
2⃣ Execution timeout
3⃣ WebSocket disconnect
4⃣ Worker crash

Solutions:

```
Timeout watchdog
Retry policy
Job status persistence
Execution logs stored
```

---

# 1⃣5⃣ Monitoring & Observability

Metrics:

```
Execution time
Queue length
Container usage
Error rate
Active WebSocket connections
```

Tools:

- Prometheus
- Grafana
- centralized logging

---

# 1⃣6⃣ Example Execution Flow

```
User writes code
↓
Click Run
↓
POST /execute
↓
Job pushed to queue
↓
Worker picks job
↓
Sandbox created
↓
Code executed
↓
Output streamed via WebSocket
↓
Execution finished
↓
Client receives result
```

---

# 1⃣7⃣ Key Design Decisions

| Component     | Decision                 |
| ------------- | ------------------------ |
| Communication | WebSockets for streaming |
| Isolation     | Docker sandbox           |
| Queue         | Redis/Celery             |
| Execution     | Worker pool              |
| Scaling       | Horizontal               |

---

# 1⃣8⃣ Extensions (Advanced Features)

Future improvements:

### Multi-language support

```
Python
C++
Java
JavaScript
```

### Persistent projects

Users can save files.

### Collaborative editing

Using:

- Operational transforms
- CRDT

### Notebook mode

Jupyter-style execution cells.

---

✅ This LLD demonstrates knowledge of:

- backend architecture
- sandbox security
- real-time streaming
- distributed systems

which are **key skills for backend engineers**.
