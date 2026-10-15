# Principal Systems Engineering Advisory & Public Portfolio Engine

## Executive Summary
This declassified architectural portfolio and engineering capability engine compiles proprietary enterprise codebases into sanitized, publicly auditable systems documentation. Employing dual-paradigm visualization—traditional network/container topology paired with Donella Meadows' Stocks & Flows dynamics—the engine extracts structural engineering principles while stripping all sensitive client branding and operational identifiers. Using throw-away ephemeral Docker compilation toolchains, it produces reproducible SVG architecture blueprints without requiring local host dependencies.

## Core Architectural Paradigms
- **Absolute Brand Sanitization (Hazard Filtering)**: Strips proprietary identifiers, commercial trademarks, customer names, and internal IP to publish safe, high-level architectural references.
- **Dual-Paradigm Systems Visualization**: Bridges traditional network/container topology with Donella Meadows' systems dynamics (Stocks, Inflows, Outflows, and Balancing/Reinforcing Feedback Loops).
- **Ephemeral Containerized Diagram Compilation**: Generates visual SVG documentation via throw-away Docker containers (`minlag/mermaid-cli`), guaranteeing 100% reproducibility across environments with zero host NPM baggage.
- **Data Sovereignty & Zero-Egress Demonstration**: Highlights architectural patterns that protect intellectual property through localized execution, kernel isolation, and event-sourced persistence.

## Systems Architecture Diagram

```mermaid
flowchart TB
    subgraph PrivateIPPerimeter["Private Enterprise Infrastructure (Air-Gapped / Classified)"]
        SourceRepos["source_repos/ (74 Private Enterprise Codebases & Gitea Mirrors)"]
        ProprietarySpecs["Classified System Architecture Decisions & Brand IP"]
    end

    subgraph HazardFilterEngine["Declassification & Hazard Filtering Engine"]
        HazardFilter["Hazard Filter & Sanitizer\n(Rigorously Redacts Brands, Clients & Hostnames)"]
        ParadigmExtractor["Architectural Paradigm Extractor\n(Zero-Trust, Event Sourcing, Data Sovereignty)"]
        DualParadigmSynthesizer["Dual-Paradigm Systems Modeler\n(Traditional Systems + Meadows Stocks & Flows)"]
    end

    subgraph EphemeralDockerBuild["Ephemeral Container Compilation (Zero Host Dependencies)"]
        MermaidCLI["Dockerized Mermaid CLI (minlag/mermaid-cli)\n(docker run --rm -v $(pwd):/data ...)"]
        VectorAssets["Rendered Standalone SVG Vectors"]
    end

    subgraph PublicShowcase["Public Declassified Portfolio Footprint"]
        PublicGit["public-portfolio Repository (GitHub / Static Web)"]
        ExecutiveCatalog["Curated Executive Architecture Catalog"]
    end

    SourceRepos --> HazardFilter
    ProprietarySpecs --> HazardFilter
    HazardFilter --> ParadigmExtractor
    ParadigmExtractor --> DualParadigmSynthesizer

    DualParadigmSynthesizer -->|Emits .mmd Definitions| MermaidCLI
    MermaidCLI --> VectorAssets
    DualParadigmSynthesizer -->|Compiles Sanitized Profiles| ExecutiveCatalog
    VectorAssets --> PublicGit
    ExecutiveCatalog --> PublicGit
```

## Applied Systems Theory: Stocks & Flows Dynamics

```mermaid
flowchart LR
    classDef stock fill:#1e293b,stroke:#38bdf8,stroke-width:3px,color:#f8fafc;
    classDef flow fill:#0f172a,stroke:#a855f7,stroke-width:2px,color:#f8fafc;
    classDef loop fill:#312e81,stroke:#f59e0b,stroke-width:2px,stroke-dasharray: 5 5,color:#fbbf24;

    SourcePrivate((Private Enterprise Repositories))
    InflowFilter[Inflow: Hazard Filtering & Sanitization Rate]
    StockSanitized[Stock: Declassified System Profiles]:::stock
    OutflowCompile[Outflow: Ephemeral Docker Vector Rendering Flow]

    StockDiagrams[Stock: Compiled High-Fidelity SVG Vectors]:::stock
    OutflowPublish[Outflow: Public Portfolio Publishing Velocity]

    SinkAudited((Public Strategic Architecture Showcase))

    SourcePrivate --> InflowFilter
    InflowFilter --> StockSanitized
    StockSanitized --> OutflowCompile
    OutflowCompile --> StockDiagrams
    StockDiagrams --> OutflowPublish
    OutflowPublish --> SinkAudited

    subgraph Loops["Systems Dynamics & Declassification Loops"]
        LoopB1["Balancing Loop (B1): Hazard Redaction Filter\n(Proprietary Identifier Detected -> Blocks Declassification Flow)"]:::loop
        LoopR1["Reinforcing Loop (R1): Architectural Authority Compounding\n(Transparent Structural Depth -> Elevates High-Leverage Strategic Mandates)"]:::loop
    end

    StockSanitized -.->|Sanitization Assertion| LoopB1
    LoopB1 -.->|Redaction Vector| InflowFilter

    SinkAudited -.->|Market Signal Recognition| LoopR1
    LoopR1 -.->|Executive Consulting Advisory| SourcePrivate
```

## Ephemeral Docker Compilation Command

To compile both `.mmd` diagrams into standalone `.svg` vectors locally without host dependencies:

```bash
docker run --rm -v "$(pwd)/projects/26-principal-systems-engineering-portfolio/diagrams":/data minlag/mermaid-cli -i /data/architecture.mmd -o /data/architecture.svg
docker run --rm -v "$(pwd)/projects/26-principal-systems-engineering-portfolio/diagrams":/data minlag/mermaid-cli -i /data/stocks-and-flows.mmd -o /data/stocks-and-flows.svg
```
