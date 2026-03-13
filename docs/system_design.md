# System Design: Browser-Based Code Editor and Executor

**Author:** Developer Jarvis  
**Contact:** [https://github.com/DeveloperJarvis](https://github.com/DeveloperJarvis)

---

## 1. Overview

This system provides a **browser-based code editor** with the ability to **write, execute, and view results** of code in multiple programming languages. It is designed to be **secure, scalable, and modular**.

**Key Features:**

- Multi-language support (Python, C++, Node.js)
- Secure code execution via sandboxed containers
- Real-time output streaming using WebSockets
- Job queue for asynchronous execution
- Persistent logging and execution history
- REST API for editor integration

---

## 2. High-Level Architecture

```

+------------------------+
|      Browser UI        |
|  (HTML/CSS/JS Editor)  |
+-----------+------------+
|
v
+------------------------+
|       API Server       |
|  (FastAPI/Flask)       |
| - Execution Routes     |
| - Health Routes        |
| - Status Routes        |
+-----------+------------+
|
v
+------------------------+
|       Job Queue        |
|       (Redis)          |
+-----------+------------+
|
v
+------------------------+
|      Workers           |
| - Pick up jobs         |
| - Execute code         |
| - Stream output        |
+-----------+------------+
|
v
+------------------------+
|    Sandbox Containers  |
| - Python               |
| - C++                  |
| - Node.js              |
| - Filesystem Isolation |
| - Resource Limits      |
+------------------------+

```

---

## 3. Component Breakdown

### 3.1 Frontend

- **HTML/JS Editor**: Code input, syntax highlighting, and terminal output
- **WebSocket Client**: Receives real-time execution output
- **REST API Client**: Submits code and checks execution status
- **CSS**: Layout, editor styling, terminal look

### 3.2 Backend API

- Handles REST endpoints:
  - `POST /execute` – Submits code for execution
  - `GET /status` – Checks job status
  - `GET /health` – Health check
- Converts API requests to **execution jobs** and enqueues them

### 3.3 Job Queue

- **Redis** is used for task queueing
- Workers subscribe to the queue and pick jobs asynchronously
- Supports scalability: multiple workers can process jobs in parallel

### 3.4 Workers

- Fetch jobs from the queue
- Use **Execution Manager** to manage execution lifecycle:
  - Run code in sandbox
  - Enforce timeouts
  - Capture stdout/stderr
- Push real-time results to WebSocket service

### 3.5 Sandbox

- Provides **isolated environments** for code execution
- Supports multiple runtimes:
  - Python
  - Node.js
  - C++
- Features:
  - Containerized execution using Docker
  - Filesystem isolation
  - Resource limits (CPU, memory, execution time)
  - Optional security profiles (Seccomp)

### 3.6 Storage & Logging

- Execution results and logs are persisted
- Logs:
  - API server logs
  - Worker logs
  - Execution logs
- Enables auditing and debugging

### 3.7 WebSockets

- Streams output to the frontend in real-time
- Supports:
  - Stdout streaming
  - Error messages
  - Execution completion events

---

## 4. Execution Flow

1. User writes code in the browser editor.
2. Code is submitted via **REST API** (`POST /execute`).
3. API server creates a **job** and enqueues it in **Redis**.
4. Worker picks up the job:
   - Allocates sandbox container
   - Runs the code
   - Captures stdout/stderr
   - Sends incremental output via **WebSocket**
5. Worker stores final output and status in **persistent storage**.
6. Frontend receives streamed output in real-time and final result.

---

## 5. Security Considerations

- Sandboxed execution prevents host contamination
- Timeouts prevent infinite loops
- CPU and memory limits prevent resource abuse
- Seccomp profiles enforce syscall restrictions
- File system isolation prevents access to host files

---

## 6. Scaling & Extensibility

- **Horizontal Scaling**: Add more workers to increase execution throughput
- **Language Support**: Add more Docker-based sandboxes for new languages
- **Distributed Deployment**: Queue-based decoupling allows API and worker services to run independently

---

## 7. Future Enhancements

- Persistent user sessions and code history
- Collaborative real-time editing
- Advanced analytics on execution patterns
- Web-based debugging features
- Cloud deployment with auto-scaling

---

## 8. References

- [Docker Documentation](https://docs.docker.com/)
- [Redis Documentation](https://redis.io/)
- [WebSocket Protocol](https://developer.mozilla.org/en-US/docs/Web/API/WebSockets_API)
- [FastAPI Documentation](https://fastapi.tiangolo.com/)
