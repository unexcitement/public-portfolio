# Containerized E-Commerce Storefront & Design System Engine

## Executive Summary
This enterprise e-commerce development environment and design system orchestrates modern Shopify theme development within a zero-dependency containerized sandbox. Built around an isolated Dockerized toolchain running the Shopify CLI, the architecture allows developers to build, preview, and synchronize bespoke Liquid templates, CSS frameworks, and dynamic section schemas without installing Node.js, Ruby, or global package managers on the host workstation.

## Core Architectural Paradigms
- **Host-Isolated CLI Toolchain**: Encapsulates Shopify CLI and local preview server toolchains within an ephemeral Docker container, eliminating environment version conflicts across developer machines.
- **Bi-Directional Remote Synchronization**: Manages live theme asset pushes and pulls via authenticated Shopify Admin APIs, keeping local version-controlled files in continuous parity with remote stores.
- **Zero-Latency Hot Previewing**: Forwards local development ports (`:9292`) through Docker socket bindings, rendering real-time storefront changes against live store products without impacting production customer sessions.
- **Modular Liquid Component System**: Structures UI components into reusable, atomic Liquid snippets and section schemas for rapid brand adaptation.

## Systems Architecture Diagram

```mermaid
flowchart TB
    subgraph HostWorkstation["Host Developer Machine (Zero NPM / CLI Installs)"]
        Dev["Theme Engineer / Storefront Architect"]
        SourceFiles["Theme Source Files (DawnSpaceTheme / Liquid / CSS / JSON)"]
    end

    subgraph ContainerRuntime["Hardened Ephemeral Container (shopify_dev)"]
        ShopifyCLI["Shopify CLI Runtime Engine"]
        DevServer["Local Development Preview Server (:9292)"]
        ThemeSyncEngine["Theme Push / Pull Bidirectional Sync Engine"]
    end

    subgraph ShopifyCloud["Shopify Cloud Infrastructure"]
        LiveStore["Live Storefront Instance (*.myshopify.com)"]
        ThemeAPI["Shopify Theme REST/GraphQL API"]
        AssetCDN["Shopify Fastly Asset CDN"]
    end

    Dev -->|Edits Templates & Assets| SourceFiles
    SourceFiles <-->|Docker Volume Bind Mount| ContainerRuntime
    Dev -->|docker exec -it shopify_dev sh| ShopifyCLI

    ShopifyCLI --> DevServer
    DevServer -->|Local Real-time Preview| Dev

    ShopifyCLI --> ThemeSyncEngine
    ThemeSyncEngine <-->|Authenticated TLS API Calls| ThemeAPI
    ThemeAPI --> LiveStore
    LiveStore --> AssetCDN
```

## Applied Systems Theory: Stocks & Flows Dynamics

```mermaid
flowchart LR
    classDef stock fill:#1e293b,stroke:#38bdf8,stroke-width:3px,color:#f8fafc;
    classDef flow fill:#0f172a,stroke:#a855f7,stroke-width:2px,color:#f8fafc;
    classDef loop fill:#312e81,stroke:#f59e0b,stroke-width:2px,stroke-dasharray: 5 5,color:#fbbf24;

    SourceEdits((Theme Asset Mutation Event))
    InflowWatch[Inflow: File Watcher Sync Rate]
    StockLocal[Stock: Staged Local Liquid & Asset Modifications]:::stock
    OutflowPush[Outflow: API Theme Upload Velocity]

    StockCloudTheme[Stock: Deployed Remote Theme Asset Tree]:::stock
    OutflowRender[Outflow: Customer Page Render Rate]

    SinkCustomer((Delivered Storefront Experience))

    SourceEdits --> InflowWatch
    InflowWatch --> StockLocal
    StockLocal --> OutflowPush
    OutflowPush --> StockCloudTheme
    StockCloudTheme --> OutflowRender
    OutflowRender --> SinkCustomer

    subgraph Loops["Systems Dynamics & Dev Velocity Loops"]
        LoopB1["Balancing Loop (B1): API Rate-Limit Throttling\n(Frequent Asset Saves -> Batches Asset Uploads)"]:::loop
        LoopR1["Reinforcing Loop (R1): Hot-Reload Feedback Velocity\n(Sub-Second Local Previews -> Accelerates Design Iteration)"]:::loop
    end

    StockLocal -.->|Upload Frequency| LoopB1
    LoopB1 -.->|Batching Factor| OutflowPush

    StockLocal -.->|Instant Visual Feedback| LoopR1
    LoopR1 -.->|Iteration Speed| SourceEdits
```

## Ephemeral Docker Compilation Command

To compile both `.mmd` diagrams into standalone `.svg` vectors locally without host dependencies:

```bash
docker run --rm -v "$(pwd)/projects/23-containerized-ecommerce-design-system/diagrams":/data minlag/mermaid-cli -i /data/architecture.mmd -o /data/architecture.svg
docker run --rm -v "$(pwd)/projects/23-containerized-ecommerce-design-system/diagrams":/data minlag/mermaid-cli -i /data/stocks-and-flows.mmd -o /data/stocks-and-flows.svg
```
