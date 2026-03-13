# Execution Pipeline: Browser-Based Code Editor and Executor

**Author:** Developer Jarvis  
**Contact:** [https://github.com/DeveloperJarvis](https://github.com/DeveloperJarvis)

---

## 1. Overview

The execution pipeline defines how user-submitted code travels from the **frontend editor** to execution, isolation, and result delivery. The system ensures **sandboxed execution**, **real-time output streaming**, and **robust logging**.

---

## 2. Pipeline Components

### 2.1 API Layer

- **Responsibility:** Receives HTTP requests and WebSocket connections from the frontend.
- **Files:**
  - `backend/api/routes/execute_routes.py`
  - `backend/api/routes/status_routes.py`
  - `backend/api/controllers/execution_controller.py`
- **Flow:**
  1. Receive `/execute` POST request.
  2. Validate request via **schemas**.
  3. Generate a unique `job_id` for the execution.
  4. Enqueue the job in the **Job Queue**.

---

### 2.2 Job Queue

- **Responsibility:** Decouples job submission from execution workers to improve scalability.
- **Files:**
  - `backend/queue/job_queue.py`
  - `backend/queue/producer.py`
  - `backend/queue/consumer.py`
- **Flow:**
  1. **Producer** pushes job details (code, language, stdin, timeout) to the queue.
  2. **Consumer/Worker** pulls jobs for execution asynchronously.

---

### 2.3 Execution Workers

- **Responsibility:** Execute code inside isolated sandbox environments.
- **Files:**
  - `backend/workers/execution_worker.py`
  - `backend/workers/worker_manager.py`
- **Flow:**
  1. Receive job from queue.
  2. Instantiate `ExecutionManager`.
  3. Pass code to **Sandbox Service** for secure execution.

---

### 2.4 Sandbox Layer

- **Responsibility:** Provides safe, isolated execution with resource limits.
- **Files:**
  - `backend/sandbox/sandbox_manager.py`
  - `backend/sandbox/container_runtime.py`
  - `backend/sandbox/resource_limits.py`
  - `backend/sandbox/filesystem_isolation.py`
- **Mechanisms:**
  - **Containerization:** Use Docker containers for each language.
  - **Filesystem Isolation:** Restrict access to a virtual filesystem.
  - **Resource Limits:** CPU, memory, and execution time constraints.
  - **Security Policies:** Apply seccomp profiles to prevent malicious system calls.

---

### 2.5 Execution Manager

- **Responsibility:** Orchestrates code execution and result collection.
- **Files:**
  - `backend/executor/execution_manager.py`
  - `backend/executor/code_runner.py`
  - `backend/executor/execution_context.py`
  - `backend/executor/timeout_guard.py`
  - `backend/executor/result_collector.py`
- **Flow:**
  1. Prepare execution environment (temporary files, stdin).
  2. Launch the **Code Runner** inside the sandbox.
  3. Stream stdout/stderr to WebSocket in real-time.
  4. Enforce **timeout limits** with `TimeoutGuard`.
  5. Collect final output, errors, and exit codes in `ResultCollector`.

---

### 2.6 WebSocket Output Streaming

- **Responsibility:** Real-time delivery of execution logs to the frontend.
- **Files:**
  - `backend/websocket/websocket_server.py`
  - `backend/websocket/connection_manager.py`
  - `backend/websocket/output_streamer.py`
- **Flow:**
  1. Frontend opens WebSocket for a given `job_id`.
  2. ExecutionWorker streams output events (`stdout`, `stderr`, `complete`).
  3. `ConnectionManager` ensures correct client receives the data.

---

### 2.7 Storage and Logging

- **Responsibility:** Persist execution results and logs for auditing/debugging.
- **Files:**
  - `backend/storage/execution_repository.py`
  - `backend/storage/log_repository.py`
- **Flow:**
  1. After execution, save job metadata (status, output, error, timestamps).
  2. Append execution logs to persistent storage.

---

## 3. Execution Lifecycle

1. **Submission:** User submits code via `/execute` endpoint.
2. **Validation:** API validates language, code size, timeout.
3. **Enqueue:** Job added to Job Queue.
4. **Worker Pick-up:** Worker retrieves job and initializes sandbox.
5. **Execution:** Code executed in isolated environment with resource constraints.
6. **Streaming:** Output sent to frontend via WebSocket.
7. **Completion:** Job marked `completed` or `failed`.
8. **Persistence:** Execution results and logs stored.
9. **Status Check:** Frontend polls `/status/{job_id}` for updates.

---

## 4. Security and Isolation

- Each execution runs **sandboxed** in a temporary container.
- Resource limits prevent **fork bombs**, **memory exhaustion**, or **infinite loops**.
- Seccomp profiles restrict system calls.
- Filesystem isolation prevents access to host files.

---

## 5. Diagram (Conceptual)

```

+-------------------+
|   Frontend Editor |
+---------+---------+
|
v
+---------+---------+
|    API Layer      |
|  (Execute Routes) |
+---------+---------+
|
v
+---------+---------+
|     Job Queue     |
+---------+---------+
|
v
+---------+---------+
|   ExecutionWorker |
+---------+---------+
|
v
+-------------------+
|      Sandbox      |
| (Containerized)   |
+-------------------+
|
v
+---------+---------+
| Output Streaming  |
|  (WebSocket)      |
+-------------------+
|
v
+-------------------+
|  Storage & Logs   |
+-------------------+

```

---

## 6. Notes

- Supports multiple languages: Python, C++, Node.js.
- Real-time output ensures **terminal-like experience** in browser.
- Modular design allows scaling workers horizontally.
- Supports future extensions like **authentication** or **job prioritization**.
