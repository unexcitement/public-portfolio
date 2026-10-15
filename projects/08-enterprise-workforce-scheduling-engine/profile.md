# Enterprise Workforce Scheduling & Optimistic Concurrency Rota Engine

## Executive Summary
This workforce planning and labor allocation system orchestrates shift scheduling across high-turnover hospitality environments with mathematical conflict avoidance. Engineered inside a hardened, unprivileged Docker container running FastAPI and React 19, the architecture enforces an optimistic revision control scheme (HTTP 409 collision prevention) paired with physical dual-database isolation between sensitive authentication credentials and operational rosters. Incorporating headless Chromium for pixel-perfect PDF export and zero-downtime rolling deployments over Tailscale, it eliminates scheduling chaos and payroll drift.

## Core Architectural Paradigms
- **Optimistic Concurrency Control**: Tracks global weekly revision integers, instantly rejecting out-of-order manager edits with HTTP 409 clashes and requiring HTTP 428 preconditions when mutating historical rotas.
- **Physical Dual-Database Segmentation**: Separates business operations (`rota.sqlite3`) from authentication and audit telemetry (`auth.sqlite3`), ensuring routine operational database backups never compromise customer credentials.
- **Continuous 15-Minute Integer Grid**: Models shifts as integer minutes offset from the business start-of-day up to 2880 minutes, natively handling complex overnight shifts without timezone or daylight savings parsing ambiguities.
- **Headless Chromium Document Pipeline**: Embeds an isolated Playwright Chromium instance inside the application container to render pixel-accurate, server-generated print sheets and management PDF exports.

## Systems Architecture Diagram

```mermaid
flowchart TB
    subgraph ClientDevices["Client Tier (Phone-First PWA & Desktop)"]
        MobileStaff["Staff Mobile Interface (PhoneWeek / Ready Shifts)"]
        ManagerDesktop["Manager Desktop Grid (ShiftSheet / Rota Control)"]
    end

    subgraph ContainerPerimeter["Hardened Container Perimeter (Non-Root UID 10001)"]
        subgraph APIServer["FastAPI Application Server (Uvicorn Worker :8183)"]
            StaticMount["React 19 / Vite Static Asset Server"]
            CSRFAuth["scrypt Auth & Sliding Session Validator"]
            RevisionGuard["Optimistic Concurrency Guard (Revision 409/428)"]
            ScheduleEngine["Shift Allocation & Minute-Grid Computation"]
            ExportService["Headless Playwright & Spreadsheet Compiler"]
        end

        subgraph HeadlessWorker["Embedded Headless Chrome (Playwright)"]
            ChromiumPDF["Headless Chromium Renderer\n(Print-Exact PDF Generation)"]
        end

        subgraph StorageIsolation["Dual-Database Physical Isolation"]
            RotaDB[("rota.sqlite3\n(Business Schedules, Rates, Presets)")]
            AuthDB[("auth.sqlite3\n(Hashed Sessions, Credentials, Audit Logs)")]
        end
    end

    subgraph IngressGateway["Ingress & Deployment Perimeter"]
        CaddyProxy["Caddy Edge Reverse Proxy (Loopback Only 127.0.0.1:8183)"]
        TailscaleTunnel["Tailscale Secure Mesh Ingress"]
        BackupEngine["Automated Daily & Pre-Delete Snapshot Daemon"]
    end

    MobileStaff --> TailscaleTunnel
    ManagerDesktop --> TailscaleTunnel
    TailscaleTunnel --> CaddyProxy
    CaddyProxy --> StaticMount
    CaddyProxy --> CSRFAuth

    CSRFAuth --> RevisionGuard
    RevisionGuard --> ScheduleEngine
    ScheduleEngine --> RotaDB
    CSRFAuth --> AuthDB

    ScheduleEngine --> ExportService
    ExportService --> ChromiumPDF
    
    BackupEngine -.->|"Safe Rotation (Excludes Auth)"| RotaDB
    BackupEngine -.->|Credentialed Vault| AuthDB
```

## Applied Systems Theory: Stocks & Flows Dynamics

```mermaid
flowchart LR
    classDef stock fill:#1e293b,stroke:#38bdf8,stroke-width:3px,color:#f8fafc;
    classDef flow fill:#0f172a,stroke:#a855f7,stroke-width:2px,color:#f8fafc;
    classDef loop fill:#312e81,stroke:#f59e0b,stroke-width:2px,stroke-dasharray: 5 5,color:#fbbf24;

    SourceDemands((Weekly Operational Staffing Need))
    InflowDraft[Inflow: Shift Scheduling Rate]
    StockDraft[Stock: In-Flight Schedule Revisions]:::stock
    OutflowClash[Outflow: 409 Collision Rejection Rate]
    OutflowCommit[Outflow: Validated Revision Commit Velocity]

    StockPublished[Stock: Confirmed Weekly Work Schedule]:::stock
    OutflowWorked[Outflow: Shift Fulfillment & Labor Burn Rate]

    StockCapacity[Stock: Available Staff Weekly Hour Pool]:::stock
    OutflowPayroll[Outflow: Payroll & Wage Export Rate]

    SinkExecuted((Operational Weekly Closeout))

    SourceDemands --> InflowDraft
    InflowDraft --> StockDraft
    StockDraft --> OutflowClash
    OutflowClash --> StockDraft
    StockDraft --> OutflowCommit
    OutflowCommit --> StockPublished
    StockPublished --> OutflowWorked
    OutflowWorked --> SinkExecuted

    StockCapacity --> OutflowWorked
    OutflowWorked --> OutflowPayroll
    OutflowPayroll --> SinkExecuted

    subgraph Loops["Systems Dynamics & Operational Feedback Loops"]
        LoopB1["Balancing Loop (B1): Optimistic Concurrency Collision Guard\n(Stale Revision Detected -> Triggers 409 Rejection & Client Resync)"]:::loop
        LoopB2["Balancing Loop (B2): Working Time Directive Ceiling\n(Depleted Staff Hours -> Flags Overtime & Blocks Further Shifts)"]:::loop
        LoopR1["Reinforcing Loop (R1): Labor Efficiency Compounding\n(Accurate Rota Forecasting -> Lowers Churn & Stabilizes Availability)"]:::loop
    end

    StockDraft -.->|Revision Vector Clashing| LoopB1
    LoopB1 -.->|409 Abort Signal| OutflowClash

    StockCapacity -.->|Threshold Monitoring| LoopB2
    LoopB2 -.->|Allocation Cap| InflowDraft

    StockPublished -.->|Predictable Scheduling Telemetry| LoopR1
    LoopR1 -.->|Staff Retention Reinvestment| StockCapacity
```

## Ephemeral Docker Compilation Command

To compile both `.mmd` diagrams into standalone `.svg` vectors locally without host dependencies:

```bash
docker run --rm -v "$(pwd)/projects/08-enterprise-workforce-scheduling-engine/diagrams":/data minlag/mermaid-cli -i /data/architecture.mmd -o /data/architecture.svg
docker run --rm -v "$(pwd)/projects/08-enterprise-workforce-scheduling-engine/diagrams":/data minlag/mermaid-cli -i /data/stocks-and-flows.mmd -o /data/stocks-and-flows.svg
```
