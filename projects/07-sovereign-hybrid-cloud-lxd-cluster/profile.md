# Sovereign Multi-Node Hybrid-Cloud LXD Cluster & Zero-Trust Engine

## Executive Summary
This hybrid-cloud infrastructure platform anchors a resilient, self-hosted operational footprint across bare-metal dedicated servers, cloud quorum nodes, and physical edge hardware. Orchestrated via OpenTofu and Ansible, the LXD 6.9 cluster enforces strict zero-trust boundaries with central Authentik OIDC authentication, OpenBao secret management, and network-namespace-isolated WireGuard egress tunnels. By maintaining independent data residency and sovereign version control (Gitea) within an audited cluster perimeter, the architecture guarantees absolute control over enterprise IP while maintaining high availability.

## Core Architectural Paradigms
- **Raft Distributed Consensus with Cluster Guard**: Employs an odd-numbered Raft control plane spanning physical datacenter hosts and cloud VPS quorum witnesses, guarded by OpenTofu drift assertions that block execution upon quorum mismatch.
- **Unified Zero-Trust Identity & Secret Management**: Standardizes internal service authentication on Authentik SSO and dynamic programmatic secret injection via OpenBao, eliminating static hardcoded credentials across all instances.
- **Isolated Network Namespace Egress**: Routes outbound internet traffic from sensitive containers through dedicated network namespaces running WireGuard and Tailscale exit tunnels, severing direct WAN address exposure.
- **Telemetry-Driven Self-Observability**: Implements automated Prometheus metric discovery across all LXD nodes, coupled with Gatus distributed multi-vantage heartbeat probes and pre-configured Grafana dashboards.

## Systems Architecture Diagram

```mermaid
flowchart TB
    subgraph WANEdge["Public Ingress & DNS Perimeter"]
        PublicTraffic["Public Internet Requests"]
        NginxIngress["Ingress proxy (Nginx)\nForwardAuth & SSL Termination"]
        CloudflareEdge["Cloudflare Edge Armor (DDoS / WAF)"]
    end

    subgraph ClusterRaft["Distributed LXD 6.9 Raft Cluster Perimeter"]
        subgraph DedicatedDC["Primary Datacenter Node (Primary bare-metal host)"]
            ControlPlane["LXD Control Plane & Raft Leader"]
            
            subgraph WorkloadInstances["Isolated LXD Workload Containers"]
                SSONode["Identity provider (Authentik OIDC)"]
                BaoNode["Secrets manager (OpenBao KMS)"]
                MetricsNode["Metrics & dashboards (Prometheus/Grafana)"]
                GiteaNode["Self-hosted Git (Gitea)"]
                SemaphoreNode["Automation runner (Ansible Semaphore)"]
                MailNode["Mail server (Stalwart, own public address)"]
                GatusMaster["Uptime monitor (Gatus)"]
            end

            subgraph EgressPerimeter["Network Namespace Isolation (Egress gateway)"]
                ProtonWG["Proton WireGuard Tun (Isolated Netns)"]
                TailscaleExit["Tailscale Exit Node (Isolated Netns)"]
            end
        end

        subgraph QuorumNodes["Hybrid Cloud Quorum Layer (DC VPS)"]
            VPS00["Cloud quorum voter A (Voting Quorum Only)"]
            VPS01["Cloud quorum voter B (Voting Quorum Only)"]
        end

        subgraph EdgeNodes["Home Laboratory Perimeter (Edge Uplink)"]
            ZNUC["Edge mini-PC (uptime probe relay & Edge Egress)"]
            ZWS["Edge workstation (Ephemeral CI Runner)"]
        end
    end

    PublicTraffic --> CloudflareEdge
    CloudflareEdge --> NginxIngress
    NginxIngress --> SSONode
    NginxIngress --> WorkloadInstances

    ControlPlane <-->|"LXD Raft Consensus (TCP :8443)"| VPS00
    ControlPlane <-->|"LXD Raft Consensus (TCP :8443)"| VPS01
    ControlPlane <-->|Tailscale Mesh WAN| ZNUC
    ControlPlane <-->|Tailscale Mesh WAN| ZWS

    WorkloadInstances -.->|OIDC Authentication| SSONode
    WorkloadInstances -.->|Dynamic Secrets Injection| BaoNode
    WorkloadInstances -.->|Metrics Scraping| MetricsNode
    WorkloadInstances -->|Outbound Egress Routing| EgressPerimeter
```

## Applied Systems Theory: Stocks & Flows Dynamics

```mermaid
flowchart LR
    classDef stock fill:#1e293b,stroke:#38bdf8,stroke-width:3px,color:#f8fafc;
    classDef flow fill:#0f172a,stroke:#a855f7,stroke-width:2px,color:#f8fafc;
    classDef loop fill:#312e81,stroke:#f59e0b,stroke-width:2px,stroke-dasharray: 5 5,color:#fbbf24;

    SourceOps((OpenTofu State Declarations))
    InflowApply[Inflow: Terraform Provisioning Velocity]
    StockInstances[Stock: Running LXD Sovereign Instances]:::stock
    OutflowDecommission[Outflow: Instance Teardown Rate]

    StockRaft[Stock: Raft Distributed Consensus Log Entries]:::stock
    OutflowHeartbeat[Outflow: Quorum Synchronization Velocity]

    StockMetrics[Stock: Prometheus Time-Series Samples]:::stock
    OutflowCompaction[Outflow: Retention Policy Prune Rate]

    SinkTerminated((Clean Instance Destruction))

    SourceOps --> InflowApply
    InflowApply --> StockInstances
    StockInstances --> OutflowDecommission
    OutflowDecommission --> SinkTerminated

    StockInstances --> StockRaft
    StockRaft --> OutflowHeartbeat

    StockInstances --> StockMetrics
    StockMetrics --> OutflowCompaction

    subgraph Loops["Systems Dynamics & Infrastructure Resiliency Loops"]
        LoopB1["Balancing Loop (B1): Quorum Guard Assertion\n(Missing Quorum VPS -> Blocks OpenTofu Plan/Apply)"]:::loop
        LoopB2["Balancing Loop (B2): WAN Backpressure Shedding\n(Saturated Edge Uplink -> Backs off Non-Critical LXC Calls)"]:::loop
        LoopR1["Reinforcing Loop (R1): Sovereign Infrastructure Compounding\n(Air-Gapped Secrets & In-Cluster Services -> Mitigates Cloud Vendor Risk)"]:::loop
    end

    StockRaft -.->|Quorum Health Telemetry| LoopB1
    LoopB1 -.->|Lockout Signal| InflowApply

    StockInstances -.->|WAN Traffic Intensity| LoopB2
    LoopB2 -.->|Pacing Signal| OutflowHeartbeat

    StockInstances -.->|Autonomy Expansion| LoopR1
    LoopR1 -.->|Decoupled Architecture Leverage| SourceOps
```

## Ephemeral Docker Compilation Command

To compile both `.mmd` diagrams into standalone `.svg` vectors locally without host dependencies:

```bash
docker run --rm -v "$(pwd)/projects/07-sovereign-hybrid-cloud-lxd-cluster/diagrams":/data minlag/mermaid-cli -i /data/architecture.mmd -o /data/architecture.svg
docker run --rm -v "$(pwd)/projects/07-sovereign-hybrid-cloud-lxd-cluster/diagrams":/data minlag/mermaid-cli -i /data/stocks-and-flows.mmd -o /data/stocks-and-flows.svg
```
