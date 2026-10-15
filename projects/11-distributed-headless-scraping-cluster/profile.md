# Containerized Distributed Traffic Exchange & Headless Browser Scraping Cluster

## Executive Summary
This scraping architecture combines legacy application modernization with high-concurrency headless browser automation. Built to handle complex, anti-bot-protected web targets, the system couples a containerized PHP/MySQL foundation with a high-performance Go microservice running headless Chrome (`chromedp`), proxy rotation, and automated DOM extraction. An independent watchdog daemon continuously probes worker liveness, triggering automated process restarts through PM2 upon detecting memory leaks or zombie browser threads.

## Core Architectural Paradigms
- **Headless Browser Microservice Modernization**: Offloads JavaScript execution, cookie extraction, and dynamic DOM rendering to an independent, ephemeral Go service compiled on `chromedp/headless-shell`.
- **Mutex-Protected Proxy Pool Rotation**: Implements thread-safe random proxy selection across distributed IP egress gateways, preventing rate-limiting and IP fingerprint clustering.
- **Per-Request Context Lifecycle**: Destroys browser execution contexts immediately after each scrape request, preventing Chromium zombie processes and eliminating cumulative memory leaks.
- **Autonomous Watchdog Health Recovery**: Employs an external health probe daemon that queries synthetic endpoints, automatically recycling worker processes via PM2 upon detecting deadlocks or hung child processes.

## Systems Architecture Diagram

```mermaid
flowchart TB
    subgraph WANPerimeter["External Web & Egress Perimeter"]
        TargetWeb["Target Websites & Web Applications"]
        ProxyPool["Rotating Residential / Datacenter Proxy Network"]
    end

    subgraph ClusterPerimeter["Containerized Scraping Appliance (Docker Compose)"]
        NginxGateway["Nginx Reverse Proxy & SSL Gateway"]
        
        subgraph ScrapingCore["Headless Browser Service (Go chromedp :9001)"]
            TokenAuth["Auth Token Gatekeeper (AUTH_TOKEN)"]
            ProxyRotator["Mutex-Protected Proxy Rotator (PROXIES Pool)"]
            BrowserContext["Ephemeral Headless Shell Engine\n(chromedp/headless-shell:latest)"]
            ResponseParser["DOM Selector & JSON/HTML Extractor"]
        end

        subgraph SupervisorLayer["Self-Healing Watchdog Tier (scrape-broker)"]
            HealthProber["Active Scrape Checker Daemon\n(Heartbeat Probe /api/v1/raw)"]
            PM2Supervisor["PM2 Process Supervisor & Crash Recovery"]
        end

        subgraph LegacyApp["Core Business Application (PHP 8 / MySQL)"]
            PHPApp["Legacy Orchestration Engine"]
            MySQLDB[("MySQL 8.0 Job & Result Store")]
        end
    end

    PHPApp -->|Internal HTTP GET :9001/scrape| NginxGateway
    NginxGateway --> TokenAuth
    TokenAuth --> ProxyRotator
    ProxyRotator --> BrowserContext
    
    BrowserContext -->|Route Through Proxies| ProxyPool
    ProxyPool -->|Automated Navigation| TargetWeb
    TargetWeb --> BrowserContext
    
    BrowserContext --> ResponseParser
    ResponseParser --> PHPApp
    PHPApp --> MySQLDB

    HealthProber -.->|Periodic Liveness Query| TokenAuth
    HealthProber -.->|On Failure / Hang| PM2Supervisor
    PM2Supervisor -.->|Auto-Restart Signal| ScrapingCore
```

## Applied Systems Theory: Stocks & Flows Dynamics

```mermaid
flowchart LR
    classDef stock fill:#1e293b,stroke:#38bdf8,stroke-width:3px,color:#f8fafc;
    classDef flow fill:#0f172a,stroke:#a855f7,stroke-width:2px,color:#f8fafc;
    classDef loop fill:#312e81,stroke:#f59e0b,stroke-width:2px,stroke-dasharray: 5 5,color:#fbbf24;

    SourceJobs((Extraction Task Ingestion))
    InflowScrape[Inflow: Job Submission Rate]
    StockJobs[Stock: In-Flight Scraping Job Queue]:::stock
    OutflowExec[Outflow: Browser Launch Velocity]

    StockBrowsers[Stock: Active Headless Chrome Contexts]:::stock
    OutflowDOM[Outflow: HTML/JSON Extract Rate]

    StockProxies[Stock: Healthy Rotating Proxy Pool]:::stock
    OutflowBan[Outflow: Rate-Limit Ban Rate]

    SinkExtracted((Parsed Structured Data Store))

    SourceJobs --> InflowScrape
    InflowScrape --> StockJobs
    StockJobs --> OutflowExec
    OutflowExec --> StockBrowsers
    StockBrowsers --> OutflowDOM
    OutflowDOM --> SinkExtracted

    StockProxies --> OutflowExec
    StockBrowsers --> OutflowBan
    OutflowBan --> StockProxies

    subgraph Loops["Systems Dynamics & Anti-Fragile Watchdog Loops"]
        LoopB1["Balancing Loop (B1): Mutex Proxy Saturation Throttle\n(Depleted Healthy Proxies -> Delays Browser Execution)"]:::loop
        LoopB2["Balancing Loop (B2): Watchdog Auto-Healing Trigger\n(Hanging Browser Contexts -> PM2 Force-Restarts Worker Daemon)"]:::loop
        LoopR1["Reinforcing Loop (R1): Extraction Throughput Compounding\n(High Proxy Health & Zero Memory Leaks -> Maximizes Task Velocity)"]:::loop
    end

    StockProxies -.->|Proxy Pool Health| LoopB1
    LoopB1 -.->|Pacing Signal| OutflowExec

    StockBrowsers -.->|Timeout Liveness Probe| LoopB2
    LoopB2 -.->|Restart Signal| OutflowExec

    StockBrowsers -.->|Clean Execution Metric| LoopR1
    LoopR1 -.->|Throughput Expansion| SourceJobs
```

## Ephemeral Docker Compilation Command

To compile both `.mmd` diagrams into standalone `.svg` vectors locally without host dependencies:

```bash
docker run --rm -v "$(pwd)/projects/11-distributed-headless-scraping-cluster/diagrams":/data minlag/mermaid-cli -i /data/architecture.mmd -o /data/architecture.svg
docker run --rm -v "$(pwd)/projects/11-distributed-headless-scraping-cluster/diagrams":/data minlag/mermaid-cli -i /data/stocks-and-flows.mmd -o /data/stocks-and-flows.svg
```
