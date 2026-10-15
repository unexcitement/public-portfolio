# High-Throughput Network Reconnaissance & RTSP Stream Intelligence Pipeline

## Executive Summary
This distributed open-source intelligence (OSINT) and network reconnaissance pipeline performs mass-scale IP space surveying and real-time RTSP media stream verification. Architected as a modular suite of ultra-fast, concurrent Go micro-utilities, the toolchain decomposes multi-million IP CIDR ranges, performs non-blocking ICMP ping sweeps, validates TCP transport routes, and filters active video streams with automated duplicate removal. The architecture maximizes socket I/O concurrency without triggering network edge saturation or kernel file descriptor exhaustion.

## Core Architectural Paradigms
- **Deterministic Workload Sharding**: Uses lightweight dataset partitioning tools (`Go txt sharder`) to slice astronomical IP scopes into deterministic ranges for parallel execution across distributed compute nodes.
- **Asynchronous Protocol Probing**: Replaces blocking network calls with Goroutine worker pools and non-blocking socket polling, completing sweeps across `/16` subnets in seconds.
- **Multi-Stage Signal Pruning**: Employs a strict pipeline cascade (CIDR Expansion → Fast ICMP Sweep → Route Checking → Banner Verification → RTSP DESCRIBE Handshaking), rejecting inactive targets at the earliest and cheapest network stage.
- **Stream Fingerprinting & Deduplication**: Analyzes stream response digests and frame characteristics to eliminate duplicate feeds originating from the same physical encoder behind multiple NAT addresses.

## Systems Architecture Diagram

```mermaid
flowchart TB
    subgraph TargetSpace["Public Network IPv4 Address Space (WAN)"]
        CIDRTargets["Target Subnet Blocks (/16 - /24 CIDRs)"]
        EdgeRouters["Target Network Endpoints & RTSP IP Cameras"]
    end

    subgraph ShardingPipeline["Concurrent Processing & Sharding Layer"]
        CIDRExpander["Go CIDR to IPs Generator\n(Bitwise IP Calculation Engine)"]
        TxtSharder["Go Worker Sharder\n(Deterministic Hash Range Partitioner)"]
        subgraph WorkerPools["Parallel Go Micro-Worker Fleet"]
            PingerWorker["Go Pinger (Concurrent Raw ICMP / Fast Ping)"]
            RouteWorker["Go Route Checker (TCP SYN/ACK Handshake Verifier)"]
            ScanWorker["Go Port Scanner (Protocol Fingerprint & Banner Grab)"]
            RTSPScanner["Go RTSP Scanner (Digest Auth & URI Path Probe)"]
        end
        DedupEngine["Go RTSP Deduplication & Hash Filter"]
        Unsharder["Go Unsharder & Stream Coalescer"]
    end

    subgraph IntelligenceStore["Reconnaissance Ledger Tier"]
        CleanTargetFile[("Verified Stream Intelligence Dataset\n(JSONL / CSV / SQLite)")]
        TelemetryLogger["Real-Time Recon Telemetry Stream"]
    end

    CIDRTargets --> CIDRExpander
    CIDRExpander --> TxtSharder
    TxtSharder -->|Distributed Batches| PingerWorker
    
    PingerWorker -->|Responsive Host Vector| RouteWorker
    RouteWorker -->|"Open Media Ports (:554, :8554)"| ScanWorker
    ScanWorker -->|RTSP Protocol Validated| RTSPScanner

    PingerWorker -.->|ICMP Probes| EdgeRouters
    RouteWorker -.->|SYN Packets| EdgeRouters
    RTSPScanner -.->|DESCRIBE Handshake| EdgeRouters

    RTSPScanner --> DedupEngine
    DedupEngine --> Unsharder
    Unsharder --> CleanTargetFile
    Unsharder --> TelemetryLogger
```

## Applied Systems Theory: Stocks & Flows Dynamics

```mermaid
flowchart LR
    classDef stock fill:#1e293b,stroke:#38bdf8,stroke-width:3px,color:#f8fafc;
    classDef flow fill:#0f172a,stroke:#a855f7,stroke-width:2px,color:#f8fafc;
    classDef loop fill:#312e81,stroke:#f59e0b,stroke-width:2px,stroke-dasharray: 5 5,color:#fbbf24;

    SourceCIDR((Target Network Scope))
    InflowExpand[Inflow: Subnet Expansion Rate]
    StockTargetIPs[Stock: Unprobed Raw IP Target Pool]:::stock
    OutflowPing[Outflow: ICMP Ping Sweep Velocity]

    StockAlive[Stock: Alive Host Verification Pool]:::stock
    OutflowPort[Outflow: TCP Handshake Probing Rate]

    StockOpenPorts[Stock: Open Media Port Endpoints]:::stock
    OutflowRTSP[Outflow: Protocol Fingerprint Verification Flow]

    StockVerified[Stock: Verified Video Stream Intelligence]:::stock
    OutflowDedup[Outflow: Deduplication & Clean Ingestion Flow]

    SinkOutput((Aggregated Threat/Intelligence DB))

    SourceCIDR --> InflowExpand
    InflowExpand --> StockTargetIPs
    StockTargetIPs --> OutflowPing
    OutflowPing --> StockAlive
    StockAlive --> OutflowPort
    OutflowPort --> StockOpenPorts
    StockOpenPorts --> OutflowRTSP
    OutflowRTSP --> StockVerified
    StockVerified --> OutflowDedup
    OutflowDedup --> SinkOutput

    subgraph Loops["Systems Dynamics & Network Throttle Loops"]
        LoopB1["Balancing Loop (B1): Kernel File Descriptor Limit\n(High Active Sockets -> Backs off Ingress Goroutine Spawns)"]:::loop
        LoopB2["Balancing Loop (B2): Network Egress Drop Prevention\n(Packet Loss Spike -> Slows Ping Dispatch Inter-Packet Delay)"]:::loop
        LoopR1["Reinforcing Loop (R1): Autonomous Discovery Compounding\n(Responsive Subnets -> Triggers Adjacent CIDR Heuristic Probes)"]:::loop
    end

    StockAlive -.->|Socket Saturation| LoopB1
    LoopB1 -.->|Pacing Signal| OutflowPing

    StockOpenPorts -.->|Drop Rate Sensing| LoopB2
    LoopB2 -.->|Delay Signal| OutflowPort

    StockVerified -.->|Subnet Density Analytics| LoopR1
    LoopR1 -.->|New Scope Influx| SourceCIDR
```

## Ephemeral Docker Compilation Command

To compile both `.mmd` diagrams into standalone `.svg` vectors locally without host dependencies:

```bash
docker run --rm -v "$(pwd)/projects/10-high-throughput-network-recon-pipeline/diagrams":/data minlag/mermaid-cli -i /data/architecture.mmd -o /data/architecture.svg
docker run --rm -v "$(pwd)/projects/10-high-throughput-network-recon-pipeline/diagrams":/data minlag/mermaid-cli -i /data/stocks-and-flows.mmd -o /data/stocks-and-flows.svg
```
