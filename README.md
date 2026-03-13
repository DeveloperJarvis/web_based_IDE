# Browser-Based Code Editor & Executor

A browser-based platform that allows users to write, execute, and view code output directly from the browser. The system provides a real-time coding environment with secure sandboxed execution and live output streaming using WebSockets.

This project demonstrates backend system design concepts including API architecture, job queues, real-time communication, and secure code execution environments.

---

## Author

**Developer Jarvis (Pen Name)**
GitHub: https://github.com/DeveloperJarvis

---

## Overview

The Browser-Based Code Editor & Executor enables users to write code in a web-based editor and execute it on remote servers. The execution happens inside isolated sandbox environments to ensure security and resource control.

The platform focuses on:

- Remote code execution
- Real-time output streaming
- Secure sandboxed environments
- Scalable backend architecture

Such systems are commonly used in:

- Online coding interview platforms
- Educational coding tools
- Interactive programming environments
- Online IDE platforms

---

## Key Features

### Web-Based Code Editor

- In-browser code editing interface
- Syntax highlighting
- Multi-language support (extensible)
- Input support for program execution

### Remote Code Execution

- Code is sent to backend execution servers
- Execution handled through job queues
- Results streamed back to the browser

### Real-Time Output Streaming

- Uses WebSockets to deliver output incrementally
- Displays stdout and stderr as the program runs
- Supports long-running programs

### Secure Sandbox Execution

User code is executed inside isolated environments to prevent malicious activity.

Security controls include:

- Process isolation
- CPU and memory limits
- Restricted filesystem access
- Disabled external network access

### Scalable Architecture

The system is designed to scale horizontally with increasing users by separating:

- API servers
- execution workers
- sandbox containers
- message queues

---

## System Architecture

High-level architecture:

```
Browser Editor
      |
      | HTTP / WebSocket
      v
Backend API Server
      |
      | Job Queue
      v
Execution Manager
      |
      v
Sandbox Environment
      |
      v
Code Runner
      |
      v
Streaming Output (WebSocket)
```

---

## Core Components

### Frontend Editor

Provides the browser-based coding interface.

Responsibilities:

- Code editing
- Sending execution requests
- Displaying execution output
- Connecting to WebSocket streams

---

### API Server

Handles incoming HTTP requests from the client.

Responsibilities:

- Receive code execution requests
- Validate input
- Create execution jobs
- Push jobs to queue
- Provide WebSocket connection details

---

### WebSocket Server

Responsible for real-time communication between the client and backend execution process.

Responsibilities:

- Stream execution logs
- Send program output
- Notify execution completion

---

### Job Queue

Prevents execution tasks from blocking the API server.

Responsibilities:

- Store pending execution jobs
- Distribute jobs to workers
- Enable scalable execution

Typical queue technologies include Redis-based task queues or message brokers.

---

### Execution Manager

Coordinates the execution lifecycle.

Responsibilities:

- Allocate sandbox environments
- Start and monitor code execution
- Enforce execution limits
- Handle job completion and cleanup

---

### Sandbox Environment

All user code is executed inside secure sandbox environments.

Typical implementations include container-based isolation.

Responsibilities:

- Process isolation
- Memory limits
- CPU limits
- Filesystem restrictions
- Network restrictions

---

### Code Runner

Executes the user-submitted code within the sandbox.

Responsibilities:

- Write code to temporary files
- Compile if necessary
- Execute program
- Capture program output
- Stream logs back to the WebSocket server

---

## Execution Flow

1. User writes code in the browser editor.
2. The user clicks the **Run** button.
3. The frontend sends a request to the backend API.
4. The backend creates an execution job.
5. The job is pushed to the execution queue.
6. A worker retrieves the job.
7. A sandbox environment is created.
8. The code is executed.
9. Program output is streamed to the client via WebSockets.
10. Execution completes and resources are cleaned up.

---

## Execution Lifecycle

Each execution job transitions through multiple states:

```
CREATED
  ↓
QUEUED
  ↓
RUNNING
  ↓
COMPLETED / FAILED / TIMEOUT
```

These states help track execution status and improve reliability.

---

## Security Considerations

Running arbitrary code requires strict security measures.

Key protections include:

- Sandboxed execution environments
- Resource limits (CPU, memory, runtime)
- Filesystem isolation
- Network access restrictions
- Execution timeouts
- Input validation

These controls prevent malicious or resource-intensive code from affecting the system.

---

## Scalability

The system can scale by separating responsibilities across services:

- Multiple API servers
- Distributed execution workers
- Container-based sandbox environments
- Load-balanced WebSocket servers

When demand increases, additional execution workers can be provisioned automatically.

---

## Monitoring and Observability

Operational monitoring helps ensure system reliability.

Important metrics include:

- Execution latency
- Queue size
- Worker utilization
- WebSocket connections
- Error rates

Centralized logging and metrics dashboards help diagnose failures and track system performance.

---

## Future Enhancements

Potential improvements for the platform include:

- Support for additional programming languages
- Persistent user projects
- Collaborative real-time editing
- Notebook-style execution environments
- Code completion and linting
- File system access inside sandboxes

---

## License

This project is intended for educational and demonstration purposes.

---

## Contact

Author: **Developer Jarvis (Pen Name)**
GitHub: https://github.com/DeveloperJarvis
