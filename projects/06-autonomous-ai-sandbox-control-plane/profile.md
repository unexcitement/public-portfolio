# Autonomous AI Agent Containment & Ephemeral Sandbox Control Plane

## Executive Summary
This enterprise management control plane provides mathematical execution isolation for untrusted autonomous AI agents, script executors, and coding models. Built on top of the OASIS schema-isolated multi-tenant foundation, tenants can dynamically configure, snapshot, and execute unprivileged LXD and Docker workspaces with custom resource limits, GPU passthrough, and model routes. By enforcing a strict DEFCON 0 zero-egress perimeter via host-level UFW DOCKER-USER drop rules and isolated WireGuard/Tailscale network namespaces, the platform guarantees that agentic operations cannot leak proprietary intellectual property or pivot into internal infrastructure networks.

## Core Architectural Paradigms
- **Zero-Egress Containment (DEFCON 0)**: Physically drops all outbound WAN traffic by default at the host kernel packet filter layer, allowing outbound requests only through explicitly whitelisted VPN egress network namespaces.
- **Copy-on-Write (CoW) Ephemeral Storage**: Utilizes ZFS snapshotting to instantiate pre-warmed agent sandboxes in under 2 seconds and reliably demolishes workspace state upon task resolution with zero residual data remnants.
- **Hardware Quota & GPU Passthrough Isolation**: Implements deterministic resource fencing (CPU pinning, RAM cgroups, and isolated NVIDIA GPU slice assignment) preventing runaway agent processes from destabilizing host operations.
- **Decoupled Root Key Secret Brokerage**: Integrates with OpenBao to inject ephemeral, short-lived API credentials into container runtimes without ever writing secret keys to disk or environment variables.

## Systems Architecture Diagram

```mermaid
flowchart TB
    subgraph ControlPlanePerimeter["OASIS-Powered Multi-Tenant Control Plane"]
        Operator["Tenant Developer / Agent Orchestrator"]
        CaddyGateway["Caddy Gateway (Dynamic TLS & API Routing)"]
        NuxtConsole["Nuxt 3 Sandbox Fleet Manager"]
        
        subgraph APICore["Control Plane Core (Go / OASIS)"]
            PresetEngine["Sandbox Preset Engine (GPU, Tools, CLI, Model Routes)"]
            QuotaManager["Tenant Resource & Lease Allocator"]
            SecretsInjector["OpenBao Secrets Broker (Root Key Isolation)"]
        end
    end

    subgraph HostHypervisor["Bare-Metal Host Hypervisor Perimeter (01-eds-dedi)"]
        DaemonManager["LXD 6.x / Docker Engine Supervisor"]
        
        subgraph NetworkIsolation["Zero-Egress Network Isolation (DEFCON 0)"]
            UFWPolicy["UFW DOCKER-USER Drop Rules (WAN Severed)"]
            EgressBridge["Tailscale / WireGuard Egress Namespace (Whitelisted APIs Only)"]
        end

        subgraph SandboxFleet["Ephemeral Agent Sandbox Instances"]
            subgraph Sandbox1["Sandbox Instance: Tenant Alpha"]
                UnprivLXD1["Unprivileged LXD Container"]
                AgentRuntime1["Autonomous AI Agent (Claude/OpenAI CLI)"]
                ZFSStorage1["ZFS CoW Ephemeral Volume"]
            end
            
            subgraph Sandbox2["Sandbox Instance: Tenant Beta"]
                UnprivLXD2["Unprivileged LXD Container (GPU Passthrough)"]
                AgentRuntime2["Autonomous AI Agent (Local Ollama / PyTorch)"]
                ZFSStorage2["ZFS CoW Ephemeral Volume"]
            end
        end
    end

    Operator --> CaddyGateway
    CaddyGateway --> NuxtConsole
    NuxtConsole --> APICore
    APICore --> SecretsInjector
    APICore --> DaemonManager

    DaemonManager --> NetworkIsolation
    NetworkIsolation --> UFWPolicy
    NetworkIsolation --> EgressBridge

    DaemonManager -->|Provision CoW Snapshot| ZFSStorage1
    DaemonManager -->|Provision CoW Snapshot| ZFSStorage2
    UFWPolicy --> UnprivLXD1
    EgressBridge --> UnprivLXD2
    UnprivLXD1 --> AgentRuntime1
    UnprivLXD2 --> AgentRuntime2
```

## Applied Systems Theory: Stocks & Flows Dynamics

```mermaid
flowchart LR
    classDef stock fill:#1e293b,stroke:#38bdf8,stroke-width:3px,color:#f8fafc;
    classDef flow fill:#0f172a,stroke:#a855f7,stroke-width:2px,color:#f8fafc;
    classDef loop fill:#312e81,stroke:#f59e0b,stroke-width:2px,stroke-dasharray: 5 5,color:#fbbf24;

    SourceRequests((Agent Dispatch Trigger))
    InflowSpawn[Inflow: Sandbox Instantiation Rate]
    StockActive[Stock: Active Isolated Agent Sandboxes]:::stock
    OutflowTeardown[Outflow: Automated Teardown Flow]

    StockCompute[Stock: Host GPU / CPU Compute Inventory]:::stock
    OutflowCompute[Outflow: Token & Inference Burn Rate]

    StockStorage[Stock: ZFS Ephemeral Volume Allocations]:::stock
    OutflowStorage[Outflow: Snapshot Pruning Velocity]

    SinkTerminated((Clean Container Destruction))

    SourceRequests --> InflowSpawn
    InflowSpawn --> StockActive
    StockActive --> OutflowTeardown
    OutflowTeardown --> SinkTerminated

    StockCompute --> OutflowCompute
    StockActive --> StockStorage
    StockStorage --> OutflowStorage
    OutflowStorage --> SinkTerminated

    subgraph Loops["Systems Dynamics & Containment Feedback Loops"]
        LoopB1["Balancing Loop (B1): Host Capacity Quota Enforcer\n(Depleted Compute/ZFS -> Throttles New Sandbox Spawns)"]:::loop
        LoopB2["Balancing Loop (B2): Ephemeral Lease Expiry Watchdog\n(High Active Lifetime -> Auto-Demolishes Idle Containers)"]:::loop
        LoopR1["Reinforcing Loop (R1): Autonomous Task Velocity\n(Instant Pre-warmed Sandboxes -> Accelerates Task Completion)"]:::loop
    end

    StockCompute -.->|Capacity Headroom| LoopB1
    LoopB1 -.->|Backpressure Signal| InflowSpawn

    StockActive -.->|Lease TTL Monitor| LoopB2
    LoopB2 -.->|Reclaim Vector| OutflowTeardown

    OutflowTeardown -.->|Recycled Hardware Capacity| LoopR1
    LoopR1 -.->|Expands Pipeline Throughput| SourceRequests
```

## Ephemeral Docker Compilation Command

To compile both `.mmd` diagrams into standalone `.svg` vectors locally without host dependencies:

```bash
docker run --rm -v "$(pwd)/projects/06-autonomous-ai-sandbox-control-plane/diagrams":/data minlag/mermaid-cli -i /data/architecture.mmd -o /data/architecture.svg
docker run --rm -v "$(pwd)/projects/06-autonomous-ai-sandbox-control-plane/diagrams":/data minlag/mermaid-cli -i /data/stocks-and-flows.mmd -o /data/stocks-and-flows.svg
```
