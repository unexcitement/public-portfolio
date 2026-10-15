# Monolithic Relational Full-Stack Scaffold (MEEN Architecture)

## Executive Summary
This architectural scaffold provides a battle-tested, monolithic foundation for database-driven web applications and operational tools. Utilizing the MEEN stack (MariaDB, Express, EJS, and Node.js), the template enforces robust request middleware pipelines, connection-pooled SQL execution, server-side template layout inheritance, and strict session isolation. By prioritizing architectural simplicity and single-binary containerization, it enables rapid deployment without distributed network latency or microservice coordination overhead.

## Core Architectural Paradigms
- **Monolithic Simplicity & Low Operational Latency**: Co-locates routing, business logic, templating, and database access within a unified process, eliminating inter-service network hops.
- **Pooled Relational Database Concurrency**: Manages MySQL/MariaDB connections using an asynchronous pool with automatic reconnection and leak detection.
- **Modular MVC Layout Inheritance**: Employs EJS view composition with reusable partials and master layout containers, accelerating user interface prototyping.
- **Defensive Input Sanitization**: Pre-validates incoming request bodies via `express-validator` and enforces strict 50MB payload limits to protect backend memory buffers.

## Systems Architecture Diagram

```mermaid
flowchart TB
    subgraph BrowserClient["Client Browser Tier"]
        EndUser["Web Browser Client"]
        HTMLResponse["Server-Rendered HTML5 & CSS"]
    end

    subgraph NodeAppliance["Express Monolithic Server (:3000)"]
        subgraph MiddlewarePipeline["HTTP Request Middleware Stack"]
            BodyParser["Body Parser (JSON & URL-Encoded : 50MB Limits)"]
            SessionAuth["Session Middleware (express-session / bcrypt)"]
            Validator["Input Sanitizer (express-validator)"]
        end

        subgraph MVCLayer["MVC Application Layer"]
            Router["Express Route Dispatcher"]
            Controllers["Domain Controllers"]
            EJSEngine["EJS Templating Engine (Layout Inheritance)"]
        end

        PoolManager["MariaDB Connection Pool"]
    end

    subgraph PersistenceTier["Relational Persistence Layer"]
        MariaDBInstance[("MariaDB Relational Database\n(ACID Tables & Relational Keys)")]
    end

    EndUser -->|HTTP Request| BodyParser
    BodyParser --> SessionAuth
    SessionAuth --> Validator
    Validator --> Router
    Router --> Controllers
    Controllers <-->|Pooled SQL Queries| PoolManager
    PoolManager <--> MariaDBInstance
    Controllers --> EJSEngine
    EJSEngine --> HTMLResponse
    HTMLResponse --> EndUser
```

## Applied Systems Theory: Stocks & Flows Dynamics

```mermaid
flowchart LR
    classDef stock fill:#1e293b,stroke:#38bdf8,stroke-width:3px,color:#f8fafc;
    classDef flow fill:#0f172a,stroke:#a855f7,stroke-width:2px,color:#f8fafc;
    classDef loop fill:#312e81,stroke:#f59e0b,stroke-width:2px,stroke-dasharray: 5 5,color:#fbbf24;

    SourceRequests((User Web Traffic))
    InflowRequests[Inflow: HTTP Request Ingress Velocity]
    StockQueue[Stock: Active Connection Buffer]:::stock
    OutflowRoute[Outflow: MVC Controller Processing Rate]

    StockDBPool[Stock: Available MariaDB Connection Slots]:::stock
    OutflowDB[Outflow: SQL Transaction Execution Velocity]

    SinkRendered((Delivered HTML Page Output))

    SourceRequests --> InflowRequests
    InflowRequests --> StockQueue
    StockQueue --> OutflowRoute
    OutflowRoute --> SinkRendered

    StockDBPool --> OutflowDB
    OutflowDB --> SinkRendered

    subgraph Loops["Systems Dynamics & Monolith Stability Loops"]
        LoopB1["Balancing Loop (B1): Database Connection Contention\n(Pool Depletion -> Throttles Controller Concurrency)"]:::loop
        LoopR1["Reinforcing Loop (R1): Monolithic Simplicity Compounding\n(Zero Network Hops -> Maximizes Developer Iteration Speed)"]:::loop
    end

    StockDBPool -.->|Connection Headroom Sensing| LoopB1
    LoopB1 -.->|Pacing Signal| OutflowRoute

    StockQueue -.->|Co-located Codebase Leverage| LoopR1
    LoopR1 -.->|Developer Productivity| SourceRequests
```

## Ephemeral Docker Compilation Command

To compile both `.mmd` diagrams into standalone `.svg` vectors locally without host dependencies:

```bash
docker run --rm -v "$(pwd)/projects/25-monolithic-relational-fullstack-scaffold/diagrams":/data minlag/mermaid-cli -i /data/architecture.mmd -o /data/architecture.svg
docker run --rm -v "$(pwd)/projects/25-monolithic-relational-fullstack-scaffold/diagrams":/data minlag/mermaid-cli -i /data/stocks-and-flows.mmd -o /data/stocks-and-flows.svg
```
