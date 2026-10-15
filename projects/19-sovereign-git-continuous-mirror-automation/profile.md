# Sovereign Git Synchronization & Continuous Mirroring Automation

## Executive Summary
This zero-dependency code sovereignty engine automates the batch extraction of public cloud source repositories and establishes continuous, automated pull-mirrors on a private, self-hosted Gitea infrastructure. Designed to run directly within browser developer consoles without requiring local runtime installations (Node.js, Python, or shell tools), the workflow exports complete repository manifests, configures upstream authentication tokens, and orchestrates background git sync daemons. This guarantees complete intellectual property sovereignty and immunity from upstream SaaS outages or provider account revocations.

## Core Architectural Paradigms
- **Zero-Dependency DevTools Execution**: Runs completely inside browser JavaScript runtimes, bypassing local OS package installation hurdles and avoiding credential leakage to local scratch files.
- **Continuous Pull-Mirror Architecture**: Leverages Gitea's native background worker daemon to poll upstream repositories continuously, ensuring private mirrors stay in lockstep with live code commits.
- **Least-Privilege Token Scoping**: Utilizes granular fine-grained GitHub access tokens strictly scoped to read-only metadata and contents, minimizing exposure risk.
- **Resilient Batch Rate-Limit Handling**: Automatically monitors API quota headers, inserting dynamic backoff intervals between requests to prevent API rate-limit lockouts during multi-hundred-repository migrations.

## Systems Architecture Diagram

```mermaid
flowchart TB
    subgraph BrowserDevTools["Client Browser DevTools Runtime (Zero-Host Install)"]
        Operator["Systems Architect / Operator"]
        
        subgraph Scripts["Client-Side Migration Scripts"]
            ExportScript["exportToJSON.js\n(Executes in github.com DevTools Console)"]
            JSONState["Structured Metadata JSON Artifact\n(Repo Names, Visibility, Clone URLs)"]
            ImportScript["importFromJSON.js\n(Executes in Gitea DevTools Console)"]
        end
    end

    subgraph CloudVCS["Public Cloud Git Provider (GitHub)"]
        GitHubAPI["GitHub REST API (v3 / GraphQL)"]
        PublicRepos["Public & Private Enterprise Repositories"]
    end

    subgraph SovereignVCS["Self-Hosted Sovereign VCS (Private Gitea Instance)"]
        GiteaAPI["Gitea REST API (/api/v1/repos/migrate)"]
        ContinuousMirrors["Continuous Pull-Mirror Repositories\n(Scheduled Background Git Fetch / Sync)"]
    end

    Operator --> ExportScript
    ExportScript <-->|Authenticated Read via PAT| GitHubAPI
    GitHubAPI --> PublicRepos
    ExportScript -->|Downloads File| JSONState

    Operator --> ImportScript
    JSONState --> ImportScript
    ImportScript -->|Continuous Pull-Mirror Payload| GiteaAPI
    GiteaAPI --> ContinuousMirrors
    ContinuousMirrors <-->|"Continuous Automated Sync (SSH/HTTPS)"| PublicRepos
```

## Applied Systems Theory: Stocks & Flows Dynamics

```mermaid
flowchart LR
    classDef stock fill:#1e293b,stroke:#38bdf8,stroke-width:3px,color:#f8fafc;
    classDef flow fill:#0f172a,stroke:#a855f7,stroke-width:2px,color:#f8fafc;
    classDef loop fill:#312e81,stroke:#f59e0b,stroke-width:2px,stroke-dasharray: 5 5,color:#fbbf24;

    SourceCloud((Public Cloud Git Repositories))
    InflowExport[Inflow: Metadata Export Rate]
    StockJSON[Stock: Serialized Repository Manifest]:::stock
    OutflowImport[Outflow: Gitea Mirror Creation Velocity]

    StockMirrors[Stock: Active Sovereign Continuous Pull-Mirrors]:::stock
    OutflowSync[Outflow: Continuous Git Fetch Sync Rate]

    SinkSovereign((Immutable Air-Gapped Code Vault))

    SourceCloud --> InflowExport
    InflowExport --> StockJSON
    StockJSON --> OutflowImport
    OutflowImport --> StockMirrors
    StockMirrors --> OutflowSync
    OutflowSync --> SinkSovereign

    subgraph Loops["Systems Dynamics & Sovereign Mirroring Loops"]
        LoopB1["Balancing Loop (B1): API Token Rate-Limit Throttling\n(GitHub Rate Limit Approaching -> Sleep Between Export Calls)"]:::loop
        LoopB2["Balancing Loop (B2): Mirror Network Egress Pacing\n(Concurrent Gitea Clone Capacity -> Paces Initial Pull Queues)"]:::loop
        LoopR1["Reinforcing Loop (R1): Data Sovereignty Compounding\n(Zero Egress IP Vault -> Shields Critical Code from Cloud Outages/Bans)"]:::loop
    end

    StockJSON -.->|API Rate Limit Margin| LoopB1
    LoopB1 -.->|Pacing Signal| InflowExport

    StockMirrors -.->|Clone Queue Concurrency| LoopB2
    LoopB2 -.->|Pacing Vector| OutflowImport

    StockMirrors -.->|Sovereignty Independence| LoopR1
    LoopR1 -.->|Institutional Resilience| SourceCloud
```

## Ephemeral Docker Compilation Command

To compile both `.mmd` diagrams into standalone `.svg` vectors locally without host dependencies:

```bash
docker run --rm -v "$(pwd)/projects/19-sovereign-git-continuous-mirror-automation/diagrams":/data minlag/mermaid-cli -i /data/architecture.mmd -o /data/architecture.svg
docker run --rm -v "$(pwd)/projects/19-sovereign-git-continuous-mirror-automation/diagrams":/data minlag/mermaid-cli -i /data/stocks-and-flows.mmd -o /data/stocks-and-flows.svg
```
