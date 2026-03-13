# Project Structure

```text
browser-code-editor/
│
├── README.md
├── LICENSE
├── .gitignore
├── requirements.txt
├── docker-compose.yml
│
├── frontend/
│   │
│   ├── index.html
│   │
│   ├── css/
│   │   ├── reset.css
│   │   ├── layout.css
│   │   ├── editor.css
│   │   └── terminal.css
│   │
│   ├── js/
│   │   ├── app.js
│   │   ├── editor.js
│   │   ├── api.js
│   │   ├── websocket.js
│   │   ├── terminal.js
│   │   └── utils.js
│   │
│   ├── assets/
│   │   ├── icons/
│   │   │   ├── run.svg
│   │   │   └── stop.svg
│   │   │
│   │   └── images/
│   │       └── logo.png
│   │
│   └── vendor/
│       └── monaco-editor/
│
├── backend/
│   │
│   ├── main.py
│   ├── server.py
│   │
│   ├── api/
│   │   ├── routes/
│   │   │   ├── execute_routes.py
│   │   │   ├── health_routes.py
│   │   │   └── status_routes.py
│   │   │
│   │   ├── controllers/
│   │   │   ├── execution_controller.py
│   │   │   └── health_controller.py
│   │   │
│   │   └── schemas/
│   │       ├── execution_request.py
│   │       └── execution_response.py
│   │
│   ├── websocket/
│   │   ├── websocket_server.py
│   │   ├── connection_manager.py
│   │   └── output_streamer.py
│   │
│   ├── executor/
│   │   ├── execution_manager.py
│   │   ├── code_runner.py
│   │   ├── execution_context.py
│   │   ├── timeout_guard.py
│   │   └── result_collector.py
│   │
│   ├── sandbox/
│   │   ├── sandbox_manager.py
│   │   ├── container_runtime.py
│   │   ├── resource_limits.py
│   │   └── filesystem_isolation.py
│   │
│   ├── queue/
│   │   ├── job_queue.py
│   │   ├── producer.py
│   │   └── consumer.py
│   │
│   ├── workers/
│   │   ├── execution_worker.py
│   │   └── worker_manager.py
│   │
│   ├── models/
│   │   ├── execution.py
│   │   ├── execution_status.py
│   │   └── language_config.py
│   │
│   ├── services/
│   │   ├── execution_service.py
│   │   ├── websocket_service.py
│   │   └── sandbox_service.py
│   │
│   ├── storage/
│   │   ├── execution_repository.py
│   │   └── log_repository.py
│   │
│   ├── config/
│   │   ├── settings.py
│   │   ├── logging_config.py
│   │   └── constants.py
│   │
│   └── utils/
│       ├── id_generator.py
│       ├── file_utils.py
│       └── time_utils.py
│
├── sandbox/
│   │
│   ├── docker/
│   │   ├── Dockerfile.python
│   │   ├── Dockerfile.cpp
│   │   └── Dockerfile.node
│   │
│   ├── runtime/
│   │   ├── run_python.sh
│   │   ├── run_cpp.sh
│   │   └── run_node.sh
│   │
│   └── policies/
│       ├── seccomp_profile.json
│       └── resource_limits.json
│
├── scripts/
│   ├── start_api.sh
│   ├── start_worker.sh
│   ├── build_sandbox.sh
│   └── dev_server.sh
│
├── docs/
│   ├── architecture.md
│   ├── system_design.md
│   ├── api_spec.md
│   └── execution_pipeline.md
│
├── tests/
│   │
│   ├── api/
│   │   ├── test_execute_api.py
│   │   └── test_health_api.py
│   │
│   ├── executor/
│   │   ├── test_execution_manager.py
│   │   └── test_code_runner.py
│   │
│   ├── websocket/
│   │   └── test_streaming.py
│   │
│   └── integration/
│       └── test_end_to_end_execution.py
│
└── logs/
    ├── api.log
    ├── worker.log
    └── execution.log
```

---

# Frontend File Responsibilities (HTML + CSS + JS)

### `index.html`

Main UI layout:

- Code editor
- Run button
- Language selector
- Terminal output

---

### `css/`

Styles for the interface.

| File           | Purpose                  |
| -------------- | ------------------------ |
| `reset.css`    | Normalize browser styles |
| `layout.css`   | Page layout              |
| `editor.css`   | Code editor styling      |
| `terminal.css` | Output terminal styling  |

---

### `js/`

Frontend logic.

| File           | Responsibility       |
| -------------- | -------------------- |
| `app.js`       | Entry point          |
| `editor.js`    | Code editor setup    |
| `api.js`       | Calls backend APIs   |
| `websocket.js` | WebSocket connection |
| `terminal.js`  | Output display       |
| `utils.js`     | Helper utilities     |

---

# Backend Responsibilities

### API Layer

Handles HTTP requests like:

```
POST /execute
GET /status/{execution_id}
```

---

### WebSocket Layer

Streams program output to the browser.

Example:

```
Program Output
↓
Execution Worker
↓
WebSocket Server
↓
Browser Terminal
```

---

### Execution Engine

Handles:

- code execution
- runtime limits
- process monitoring
- result collection

---

### Sandbox

Executes code inside:

- Docker containers
- restricted CPU
- limited memory
- isolated filesystem

---

# Why This Structure is Good

This design demonstrates knowledge of:

- backend APIs
- WebSocket communication
- sandbox security
- distributed workers
- scalable architecture

These are **important backend engineering skills**.
