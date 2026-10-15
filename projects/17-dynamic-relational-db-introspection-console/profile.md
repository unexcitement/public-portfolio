# Lightweight Dynamic Relational Database Introspection & Administration Console

## Executive Summary
This lightweight database administration console dynamically reflects relational database schemas to generate instant data exploration and manipulation surfaces. Built with Node.js, Express, and EJS, the engine interrogates target MySQL/MariaDB instances at request time, parsing live metadata without needing pre-generated models, ORM mappings, or static entity schemas. The platform provides software engineers and systems administrators with rapid data introspection capabilities in resource-constrained edge environments.

## Core Architectural Paradigms
- **Zero-Config Dynamic Schema Reflection**: Discovers database tables, primary keys, and data types on demand via raw metadata queries, eliminating the overhead of ORM code-generation cycles.
- **Automated CRUD Interface Synthesis**: Automatically builds responsive tabular views and row-level edit/insert forms based entirely on reflected database schema constraints.
- **Parameter-Sanitized SQL Execution**: Wraps all generated and custom DML operations in parameterized queries to prevent SQL injection vulnerabilities across dynamic inputs.
- **Minimal Edge Footprint**: Operates with a minimal dependency profile, allowing rapid deployment as an internal sidecar container alongside production databases.

## Systems Architecture Diagram

```mermaid
flowchart TB
    subgraph BrowserSurface["Administrative Browser Surface"]
        Admin["Database Administrator / Developer"]
        WebUI["Dynamic Web Interface (EJS / Bootstrap)"]
    end

    subgraph ServerEngine["Node.js Introspection Core (:3000)"]
        ExpressRouter["Express HTTP Controller"]
        
        subgraph IntrospectionEngine["Schema Discovery & Reflection Core"]
            SchemaInspector["Dynamic Table & Column Reflection Engine\n(SHOW TABLES / DESCRIBE table)"]
            CRUDGenerator["Automated SQL Query Builder\n(INSERT / UPDATE / SELECT Generator)"]
            Sanitizer["SQL Parameter Sanitization & Safety Layer"]
        end

        ConnectionPool["MariaDB / MySQL Connection Pool Manager"]
    end

    subgraph RelationalDB["Target Database Perimeter"]
        TargetDatabase[("Target Relational Database (MySQL / MariaDB)\n(Dynamic User Schemas & Tables)")]
    end

    Admin --> WebUI
    WebUI -->|HTTP GET/POST /sql| ExpressRouter
    ExpressRouter --> SchemaInspector
    SchemaInspector <-->|Introspection Queries| ConnectionPool
    ExpressRouter --> CRUDGenerator
    CRUDGenerator --> Sanitizer
    Sanitizer --> ConnectionPool
    ConnectionPool <-->|Raw SQL Execution| TargetDatabase
    ConnectionPool --> WebUI
```

## Applied Systems Theory: Stocks & Flows Dynamics

```mermaid
flowchart LR
    classDef stock fill:#1e293b,stroke:#38bdf8,stroke-width:3px,color:#f8fafc;
    classDef flow fill:#0f172a,stroke:#a855f7,stroke-width:2px,color:#f8fafc;
    classDef loop fill:#312e81,stroke:#f59e0b,stroke-width:2px,stroke-dasharray: 5 5,color:#fbbf24;

    SourceDDL((Database Schema Mutations))
    InflowDetect[Inflow: Dynamic Schema Reflection Rate]
    StockTables[Stock: Discovered Table & Field Entities]:::stock
    OutflowRender[Outflow: CRUD View Generation Velocity]

    StockQueries[Stock: In-Flight SQL Transactions]:::stock
    OutflowExecute[Outflow: Row Mutation Execution Rate]

    SinkCommitted((Persisted Database State))

    SourceDDL --> InflowDetect
    InflowDetect --> StockTables
    StockTables --> OutflowRender
    OutflowRender --> StockQueries
    StockQueries --> OutflowExecute
    OutflowExecute --> SinkCommitted

    subgraph Loops["Systems Dynamics & Database Connection Loops"]
        LoopB1["Balancing Loop (B1): Pool Connection Saturation Throttle\n(High Query Concurrency -> Queues Ingress Database Transactions)"]:::loop
        LoopR1["Reinforcing Loop (R1): Schema Discovery Agility\n(Instant Introspection -> Eliminates Migration Code Generation Delay)"]:::loop
    end

    StockQueries -.->|Pool Headroom Sensing| LoopB1
    LoopB1 -.->|Pacing Signal| OutflowRender

    StockTables -.->|Zero-Config Advantage| LoopR1
    LoopR1 -.->|Developer Velocity| SourceDDL
```

## Ephemeral Docker Compilation Command

To compile both `.mmd` diagrams into standalone `.svg` vectors locally without host dependencies:

```bash
docker run --rm -v "$(pwd)/projects/17-dynamic-relational-db-introspection-console/diagrams":/data minlag/mermaid-cli -i /data/architecture.mmd -o /data/architecture.svg
docker run --rm -v "$(pwd)/projects/17-dynamic-relational-db-introspection-console/diagrams":/data minlag/mermaid-cli -i /data/stocks-and-flows.mmd -o /data/stocks-and-flows.svg
```
