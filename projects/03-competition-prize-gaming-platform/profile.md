# UK Regulatory-Compliant Competition & Prize Gaming Platform

## Executive Summary
This platform delivers a high-throughput, legally compliant digital prize draw and gaming engine capable of processing intense checkout spikes during flash competition drops. By pairing an optimistic Nuxt 3 presentation layer with a pessimistic transactional locking mechanism and a BullMQ Redis queue, the system eliminates duplicate ticket allocations and prevents race conditions under extreme load. The architecture incorporates cryptographically verifiable Pseudo-Random Number Generation (PRNG) draw execution and immutable audit logging to satisfy stringent UK compliance guidelines.

## Core Architectural Paradigms
- **Pessimistic Inventory Locking**: Uses ACID transactions and atomic Redis key TTL reservations to guarantee zero double-spend or duplicate ticket issuance during concurrent flash sales.
- **Decoupled Asynchronous Order Settlement**: Defers resource-intensive post-checkout processing (ledger updates, transactional emails, webhook distribution) to BullMQ worker pools, keeping edge checkout response times under 50ms.
- **Verifiable PRNG Draw Mechanics**: Generates provably fair draw results through seeded pseudorandom algorithms with immutable draw certificate generation archived directly to S3.
- **Regulatory Audit Trail**: Maintains an append-only transaction history linking contestants, verified identification, payment gateway receipts, and specific ticket IDs.

## Systems Architecture Diagram

```mermaid
flowchart TB
    subgraph ClientLayer["Edge & Client Perimeter"]
        PublicUser["Public Contestants (High-Concurrency Spike Ingress)"]
        AdminUser["Auditors & Platform Operators"]
        EdgeCDN["Cloudflare / Caddy Edge (DDoS Mitigation & Caching)"]
    end

    subgraph StorefrontLayer["Front-End Presentation Tiers (Nuxt 3 SSR)"]
        PublicStore["Contestant Storefront (Nuxt 3 / Pinia / Tailwind)"]
        AdminPortal["Compliance & Draw Control Admin (Nuxt 3 / RBAC)"]
    end

    subgraph APIServices["Application API Cluster (TypeScript / Node.js)"]
        APIGateway["Express REST & Event Controller (:4000)"]
        subgraph ConcurrencyEngine["Transactional Ticket Allocation Engine"]
            LockManager["Pessimistic Row Lock & Reservation Coordinator"]
            RNGService["Cryptographically Verifiable PRNG Draw Auditor"]
        end
        JobQueue["BullMQ Asynchronous Queue Workers"]
    end

    subgraph StateStorage["State & Ledger Cluster"]
        RedisStore[("Redis Cluster (Ticket Reservation TTL & BullMQ)")]
        MySQLDB[("MySQL Database (ACID Ledger & Transaction Isolation)")]
        S3Storage[("Encrypted S3 Object Store (Audit & Winner Certificates)")]
    end

    PublicUser --> EdgeCDN
    AdminUser --> EdgeCDN
    EdgeCDN --> PublicStore
    EdgeCDN --> AdminPortal

    PublicStore -->|HTTP/REST Checkout| APIGateway
    AdminPortal -->|JWT Authenticated Ops| APIGateway

    APIGateway --> ConcurrencyEngine
    LockManager -->|Atomic Reserve / TTL Release| RedisStore
    LockManager -->|SELECT FOR UPDATE / ACID Commit| MySQLDB
    APIGateway -->|Enqueue Settlement Job| JobQueue
    JobQueue --> RedisStore
    JobQueue --> MySQLDB

    ConcurrencyEngine -->|Trigger Draw Execution| RNGService
    RNGService -->|Write Immutable Draw Certificate| S3Storage
    RNGService -->|Commit Certified Winner| MySQLDB
```

## Applied Systems Theory: Stocks & Flows Dynamics

```mermaid
flowchart LR
    classDef stock fill:#1e293b,stroke:#38bdf8,stroke-width:3px,color:#f8fafc;
    classDef flow fill:#0f172a,stroke:#a855f7,stroke-width:2px,color:#f8fafc;
    classDef loop fill:#312e81,stroke:#f59e0b,stroke-width:2px,stroke-dasharray: 5 5,color:#fbbf24;

    SourceContestants((Public Demand Surge))
    InflowHold[Inflow: Reservation Hold Velocity]
    StockAvailable[Stock: Available Ticket Inventory Pool]:::stock
    StockHold["Stock: In-Checkout Held Tickets (TTL)"]:::stock
    
    OutflowAbandon[Outflow: TTL Expiration & Return Flow]
    OutflowSettle[Outflow: Payment Settlement Flow]
    
    StockSettled[Stock: Confirmed Ticket Ledger]:::stock
    OutflowDraw[Outflow: Draw Resolution Flow]
    
    SinkCompleted((Certified Winner Payout))

    StockAvailable --> InflowHold
    InflowHold --> StockHold
    StockHold --> OutflowAbandon
    OutflowAbandon --> StockAvailable
    StockHold --> OutflowSettle
    OutflowSettle --> StockSettled
    StockSettled --> OutflowDraw
    OutflowDraw --> SinkCompleted

    subgraph Loops["Systems Dynamics & Regulatory Balancing Loops"]
        LoopB1["Balancing Loop (B1): Absolute Inventory Ceiling\n(StockAvailable -> 0 terminates Hold Inflow)"]:::loop
        LoopB2["Balancing Loop (B2): TTL Hold Expiry Eviction\n(Unpaid reservations auto-reclaim after 10 mins)"]:::loop
        LoopR1["Reinforcing Loop (R1): Drop Scarcity Hype Dynamics\n(High Settled Rate -> Accelerates Perceived Urgency & Demand)"]:::loop
    end

    StockAvailable -.->|Depletion Sensing| LoopB1
    LoopB1 -.->|Cutoff Signal| InflowHold

    StockHold -.->|TTL Monitor| LoopB2
    LoopB2 -.->|Reclaim Vector| OutflowAbandon

    StockSettled -.->|Public Progress Bar Telemetry| LoopR1
    LoopR1 -.->|Demand Stimulation| SourceContestants
```

## Ephemeral Docker Compilation Command

To compile both `.mmd` diagrams into standalone `.svg` vectors locally without host dependencies:

```bash
docker run --rm -v "$(pwd)/projects/03-competition-prize-gaming-platform/diagrams":/data minlag/mermaid-cli -i /data/architecture.mmd -o /data/architecture.svg
docker run --rm -v "$(pwd)/projects/03-competition-prize-gaming-platform/diagrams":/data minlag/mermaid-cli -i /data/stocks-and-flows.mmd -o /data/stocks-and-flows.svg
```
