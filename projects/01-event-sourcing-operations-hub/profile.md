# Decoupled Event-Sourcing Operations Hub & Human-in-the-Loop Gateway

## Executive Summary
This platform decouples high-leverage intellectual decision-making from high-volume mechanical execution via an asynchronous, event-driven command layer. Built around an ultra-lean Go ingestion proxy paired with an append-only SQLite WAL ledger and a real-time Nuxt 3 presentation surface, the architecture eliminates human operational bottlenecks while preserving deterministic auditability. By bridging operational telemetry to unprivileged, zero-egress LXD sandboxes, it achieves enterprise operational leverage without exposing critical infrastructure or internal state to third-party cloud boundaries.

## Core Architectural Paradigms
- **Append-Only Event Sourcing**: Incoming webhooks and state transitions are immutably persisted to a Write-Ahead Log (WAL) SQLite ledger prior to broadcast, guaranteeing crash resilience and zero event loss.
- **Thread-Safe Unicast & Fanout Streaming**: Low-overhead Server-Sent Events (SSE) stream state transitions to frontend operators with sub-millisecond dispatch latency via native Go synchronization primitives.
- **Human-in-the-Loop Gateway**: High-impact execution paths require explicit operator consensus before spawning autonomous execution workers, preventing systemic cascade failure.
- **Zero-Egress Containment (DEFCON 0)**: Provisioned execution workers run within kernel-isolated, unprivileged LXD containers governed by OpenTofu IaC and strict host firewall isolation.

## Systems Architecture Diagram

```mermaid
flowchart TB
    subgraph IngressBoundary["WAN / External Perimeter (Zero-Trust Ingress)"]
        Client["External Webhook Producers / Telemetry Sources"]
        ReverseProxy["Caddy Edge Ingress (TLS Termination & Rate Limiting)"]
    end

    subgraph HostBoundary["Host Security Perimeter (01-eds-dedi)"]
        subgraph ProxyPerimeter["Go Proxy Middleware Service (:8080)"]
            IngressChan["Non-blocking Buffered Ingress Channel"]
            WALEngine["WAL Commit Engine (Pessimistic Sync)"]
            SSEBroadcaster["Thread-Safe SSE Broadcaster (/stream/events)"]
        end

        subgraph StorageLayer["Immutable Event Storage"]
            SQLiteWAL[("SQLite WAL Append-Only Ledger (nerve.db)")]
        end

        subgraph UIBoundary["Presentation & Control Surface (:3000)"]
            NuxtUI["Nuxt 3 SSR Command Dashboard"]
            ZodValidator["Zod Runtime Schema Validation"]
            WarRoom["Human-in-the-Loop Gateway (War Room)"]
        end
    end

    subgraph LXDSandboxPerimeter["LXD Hardened Sandbox Perimeter (DEFCON 0 / Zero-Egress)"]
        direction TB
        SandboxProfile["OpenTofu Unprivileged LXD Profile"]
        UFWDrop["UFW DOCKER-USER Drop Rule (WAN Severed)"]
        ExecutionContainer["Isolated Agent Execution Container"]
    end

    Client -->|HTTPS POST /api/v1/webhook| ReverseProxy
    ReverseProxy -->|Loopback TCP| IngressChan
    IngressChan -->|Sync Write| WALEngine
    WALEngine -->|Append-Only Commit| SQLiteWAL
    WALEngine -->|Emit Event| SSEBroadcaster
    SSEBroadcaster -->|Server-Sent Events| ZodValidator
    ZodValidator --> NuxtUI
    NuxtUI --> WarRoom
    WarRoom -->|Control Plane Command| SandboxProfile
    SandboxProfile --> UFWDrop
    UFWDrop --> ExecutionContainer
```

## Applied Systems Theory: Stocks & Flows Dynamics

```mermaid
flowchart LR
    classDef stock fill:#1e293b,stroke:#38bdf8,stroke-width:3px,color:#f8fafc;
    classDef flow fill:#0f172a,stroke:#a855f7,stroke-width:2px,color:#f8fafc;
    classDef loop fill:#312e81,stroke:#f59e0b,stroke-width:2px,stroke-dasharray: 5 5,color:#fbbf24;

    SourceIn((External Event Generation))
    InflowRate[Inflow: Webhook Ingress Velocity]
    StockQueue[Stock: Buffered Ingress Queue]:::stock
    OutflowIngress[Outflow: WAL Persistence Rate]
    
    StockWAL[Stock: Immutable Event Ledger WAL]:::stock
    OutflowBroadcast[Flow: SSE Telemetry Velocity]
    
    StockCognitive[Stock: Human Decision Bandwidth]:::stock
    OutflowDecisions[Outflow: Command Resolution Rate]
    
    StockSandbox[Stock: Active Isolated Sandboxes]:::stock
    OutflowDeprovision[Outflow: Sandbox Tear-down Flow]
    
    SinkDone((Resolved System State))

    SourceIn --> InflowRate
    InflowRate --> StockQueue
    StockQueue --> OutflowIngress
    OutflowIngress --> StockWAL
    StockWAL --> OutflowBroadcast
    OutflowBroadcast --> StockCognitive
    StockCognitive --> OutflowDecisions
    OutflowDecisions --> StockSandbox
    StockSandbox --> OutflowDeprovision
    OutflowDeprovision --> SinkDone

    subgraph Loops["Systems Dynamics & Feedback Loops"]
        LoopB1["Balancing Loop (B1): Ingress Backpressure Throttling\n(High StockQueue -> Shed Inflow)"]:::loop
        LoopB2["Balancing Loop (B2): Cognitive Overload Protection\n(Depleted Cognitive Bandwidth -> Batch War Room Ingress)"]:::loop
        LoopR1["Reinforcing Loop (R1): Sovereign Intellectual Capital\n(Automated Container Execution -> Expands Cognitive Bandwidth)"]:::loop
    end

    StockQueue -.->|Sensing Depth| LoopB1
    LoopB1 -.->|Throttling Signal| InflowRate

    StockCognitive -.->|Sensing Capacity| LoopB2
    LoopB2 -.->|Pacing Signal| OutflowBroadcast

    OutflowDecisions -.->|Automated Workflows| LoopR1
    LoopR1 -.->|Capacity Reinvestment| StockCognitive
```

## Ephemeral Docker Compilation Command

To compile both `.mmd` diagrams into standalone `.svg` vectors locally without installing Node.js or Mermaid CLI dependencies on the host:

```bash
docker run --rm -v "$(pwd)/projects/01-event-sourcing-operations-hub/diagrams":/data minlag/mermaid-cli -i /data/architecture.mmd -o /data/architecture.svg
docker run --rm -v "$(pwd)/projects/01-event-sourcing-operations-hub/diagrams":/data minlag/mermaid-cli -i /data/stocks-and-flows.mmd -o /data/stocks-and-flows.svg
```
