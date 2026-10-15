# Automated Multi-Node LXD Clustering & Provisioning Toolkit

## Executive Summary
This infrastructure bootstrapping toolkit automates the discovery, network pre-flight verification, and federation of heterogeneous physical and cloud hardware into a resilient LXD compute cluster. By synthesizing customized join scripts, ephemeral trust tokens, and network bridge definitions, the toolkit enables systems administrators to scale containerized bare-metal clusters across varying network topologies (local Ethernet, Wi-Fi uplinks, and WireGuard overlays) with zero manual certificate copying or configuration drift.

## Core Architectural Paradigms
- **Deterministic Pre-Flight Network Validation**: Runs port connectivity checks across clustering sockets (TCP :8443, DNS, and bridge interfaces) prior to running mutations, preventing half-joined cluster splits.
- **Dynamic Join-Script Synthesis**: Generates targeted, node-specific bootstrap scripts embedding pre-shared cluster tokens and trust fingerprints for zero-touch node onboarding.
- **Unified Virtual Bridge Orchestration**: Automatically configures and standardizes the `lxdbr0` software bridge and firewall forwarding rules across all nodes to provide transparent cross-node container networking.
- **Heterogeneous Hardware Federation**: Unifies distinct hardware classes (workstations, Intel NUC edge nodes, and high-performance bare-metal dedicated servers) under a single management plane.

## Systems Architecture Diagram

```mermaid
flowchart TB
    subgraph OrchestrationHost["Operator Workstation / Control Station"]
        Operator["Systems Architect"]
        KitGenerator["generate-lxd-kit.sh\n(Dynamic Script & Secret Synthesizer)"]
        PortChecker["port-check.sh\n(Pre-Flight TCP :8443 / :53 Diagnostic)"]
    end

    subgraph NodeCluster["Heterogeneous Multi-Node LXD Cluster"]
        subgraph LeaderNode["Primary Node (Primary bare-metal host)"]
            InitScript["provision-primary.sh / 3-join-primary.sh"]
            LXDLeader["LXD Primary Daemon & Trust Authority"]
            StoragePool["ZFS / Btrfs Storage Pool"]
        end

        subgraph EdgeNode1["Edge Node 1 (Edge workstation)"]
            JoinWS["1-init-workstation.sh"]
            LXDNode1["LXD Cluster Member"]
        end

        subgraph EdgeNode2["Edge Node 2 (Edge mini-PC)"]
            JoinNUC["2-join-edge-mini.sh"]
            LXDNode2["LXD Cluster Member"]
        end
    end

    subgraph ClusterFabric["Unified Virtual Network Fabric"]
        LXDNetBridge["lxdbr0 distributed bridge (private /24)"]
        MeshRouting["Direct Wire / Tailscale Inter-Node Mesh"]
    end

    Operator --> KitGenerator
    KitGenerator --> PortChecker
    PortChecker -->|Pre-Flight Verification| NodeCluster

    KitGenerator --> InitScript
    KitGenerator --> JoinWS
    KitGenerator --> JoinNUC

    InitScript --> LXDLeader
    JoinWS -->|"Trust Handshake (Token / TLS)"| LXDLeader
    JoinNUC -->|"Trust Handshake (Token / TLS)"| LXDLeader

    LXDLeader --> LXDNetBridge
    LXDNode1 --> LXDNetBridge
    LXDNode2 --> LXDNetBridge
    LXDNetBridge <--> MeshRouting
```

## Applied Systems Theory: Stocks & Flows Dynamics

```mermaid
flowchart LR
    classDef stock fill:#1e293b,stroke:#38bdf8,stroke-width:3px,color:#f8fafc;
    classDef flow fill:#0f172a,stroke:#a855f7,stroke-width:2px,color:#f8fafc;
    classDef loop fill:#312e81,stroke:#f59e0b,stroke-width:2px,stroke-dasharray: 5 5,color:#fbbf24;

    SourceHardware((Raw Bare-Metal & Edge Hardware))
    InflowPrep[Inflow: Pre-Flight Verification Rate]
    StockPrepared[Stock: Validated Unclustered Host Nodes]:::stock
    OutflowJoin[Outflow: Trust Handshake & Cluster Join Velocity]

    StockCluster[Stock: Federated Active LXD Cluster Nodes]:::stock
    OutflowFailure[Outflow: Node Offline / Partition Rate]

    StockCapacity[Stock: Cluster Compute & Storage Pool Inventory]:::stock
    OutflowContainer[Outflow: Workload Instance Allocation Velocity]

    SinkActive((Resilient Distributed Workload Execution))

    SourceHardware --> InflowPrep
    InflowPrep --> StockPrepared
    StockPrepared --> OutflowJoin
    OutflowJoin --> StockCluster
    StockCluster --> OutflowFailure
    OutflowFailure --> StockPrepared

    StockCluster --> StockCapacity
    StockCapacity --> OutflowContainer
    OutflowContainer --> SinkActive

    subgraph Loops["Systems Dynamics & Cluster Orchestration Loops"]
        LoopB1["Balancing Loop (B1): Network Port Pre-Flight Check\n(Port Unreachable -> Halts Cluster Provisioning Before Corruption)"]:::loop
        LoopB2["Balancing Loop (B2): Heartbeat Partition Detection\n(Inter-Node Latency Spike -> Demotes Node to Non-Voting Member)"]:::loop
        LoopR1["Reinforcing Loop (R1): Horizontal Elastic Scaling\n(Automated Scripted Joins -> Accelerates Cluster Capacity Onboarding)"]:::loop
    end

    StockPrepared -.->|Port Diagnostic Telemetry| LoopB1
    LoopB1 -.->|Validation Gate| OutflowJoin

    StockCluster -.->|WAN Mesh Latency| LoopB2
    LoopB2 -.->|Quorum Safety Vector| OutflowFailure

    StockCapacity -.->|Available Headroom| LoopR1
    LoopR1 -.->|Cluster Expansion Demand| SourceHardware
```

## Ephemeral Docker Compilation Command

To compile both `.mmd` diagrams into standalone `.svg` vectors locally without host dependencies:

```bash
docker run --rm -v "$(pwd)/projects/20-automated-lxd-clustering-provisioning-toolkit/diagrams":/data minlag/mermaid-cli -i /data/architecture.mmd -o /data/architecture.svg
docker run --rm -v "$(pwd)/projects/20-automated-lxd-clustering-provisioning-toolkit/diagrams":/data minlag/mermaid-cli -i /data/stocks-and-flows.mmd -o /data/stocks-and-flows.svg
```
