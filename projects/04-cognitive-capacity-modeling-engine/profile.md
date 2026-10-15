# Neurodevelopmental Cognitive Systems & Capacity Modeling Engine

## Executive Summary
This multidimensional assessment and human capacity modeling platform evaluates cognitive traits, workplace synergy, and longitudinal behavioral telemetry. Leveraging a graph-relational hierarchy in Prisma with tier-based RBAC, it transforms complex psychometric questionnaire telemetry into actionable systemic intervention vectors while strictly enforcing tenant organizational boundaries. The architecture provides clinical supervisors and organizational leadership with real-time feedback loops to mitigate cognitive overload and optimize collaborative output.

## Core Architectural Paradigms
- **Hierarchical Graph Modeling**: Employs a self-referential Senior/Junior relational graph to map organizational reporting structures and clinical supervisory oversight dynamically.
- **Longitudinal Telemetry Aggregation**: Tracks granular, time-series psychometric responses and mood fluctuations, allowing statistical trend modeling and early warning detection of cognitive depletion.
- **Multi-Tenant Schema Segmentation**: Implements virtual host routing coupled with organizational scoping to ensure absolute tenant data sovereignty and compliance with sensitive health data standards.
- **Cryptographic Tokenized Access**: Utilizes single-use magic link authentication tokens and sliding session security to minimize authentication friction for neurodivergent participants.

## Systems Architecture Diagram

```mermaid
flowchart TB
    subgraph ClientPerimeter["Client & Identity Boundary"]
        AssessmentTaker["Clinicians / Neurodivergent Users (Assessment Interface)"]
        OrgAdmin["Clinical Supervisors / Enterprise Leads (Admin Analytics)"]
        EdgeAuth["OIDC / Magic-Link Token Authenticator"]
    end

    subgraph ServicePerimeter["Containerized Node.js Application Tier"]
        ExpressApp["Express MVC Application Core (:3000)"]
        subgraph Controllers["Domain Controller Cluster"]
            SurveyCtrl["Synergy Questionnaire Engine"]
            HierarchyCtrl["Senior/Junior DAG Hierarchy Engine"]
            AnalyticsCtrl["Capacity & Mood Telemetry Aggregator"]
            LicenseCtrl["Enterprise License & Quota Enforcer"]
        end
        subgraph SessionLayer["State & Session Middleware"]
            PrismaSessionStore["Prisma Distributed Session Store"]
            VHostRouter["Virtual Host Tenant Router"]
        end
    end

    subgraph DataPerimeter["Relational Persistence Tier"]
        PrismaORM["Prisma Client ORM (Type-Safe Query Compiler)"]
        subgraph DatabaseTables["MySQL 8.0 Normalized Schema"]
            OrgTable[("Orgs & Multi-Tenant Entities")]
            UserTable[("Users & Tiered Usergroups")]
            HierarchyTable[("Self-Referential Senior/Junior DAG")]
            TelemetryTable[("Synergy Responses & Mood Tracker Logs")]
            LicenseTable[("Enterprise Seats & Licenses")]
        end
    end

    AssessmentTaker --> EdgeAuth
    OrgAdmin --> EdgeAuth
    EdgeAuth --> VHostRouter
    VHostRouter --> ExpressApp

    ExpressApp --> SurveyCtrl
    ExpressApp --> HierarchyCtrl
    ExpressApp --> AnalyticsCtrl
    ExpressApp --> LicenseCtrl

    SurveyCtrl --> PrismaORM
    HierarchyCtrl --> PrismaORM
    AnalyticsCtrl --> PrismaORM
    LicenseCtrl --> PrismaORM
    PrismaSessionStore --> PrismaORM

    PrismaORM --> OrgTable
    PrismaORM --> UserTable
    PrismaORM --> HierarchyTable
    PrismaORM --> TelemetryTable
    PrismaORM --> LicenseTable
```

## Applied Systems Theory: Stocks & Flows Dynamics

```mermaid
flowchart LR
    classDef stock fill:#1e293b,stroke:#38bdf8,stroke-width:3px,color:#f8fafc;
    classDef flow fill:#0f172a,stroke:#a855f7,stroke-width:2px,color:#f8fafc;
    classDef loop fill:#312e81,stroke:#f59e0b,stroke-width:2px,stroke-dasharray: 5 5,color:#fbbf24;

    SourceCognitive((Environmental Task Load))
    InflowLoad[Inflow: Cognitive Demand Influx]
    StockBandwidth[Stock: Available Cognitive Capacity & Resilience]:::stock
    OutflowBurnout[Outflow: Cognitive Exhaustion Rate]

    StockTelemetry[Stock: Longitudinal Mood & Synergy Telemetry]:::stock
    OutflowAnalysis[Outflow: Clinical Synthesis Velocity]

    StockInterventions[Stock: Targeted Environmental Accommodations]:::stock
    OutflowApplication[Outflow: Remediation Adoption Rate]

    SinkEquilibrium((Adaptive Organizational Equilibrium))

    SourceCognitive --> InflowLoad
    InflowLoad --> StockBandwidth
    StockBandwidth --> OutflowBurnout
    StockBandwidth --> StockTelemetry
    StockTelemetry --> OutflowAnalysis
    OutflowAnalysis --> StockInterventions
    StockInterventions --> OutflowApplication
    OutflowApplication --> SinkEquilibrium

    subgraph Loops["Systems Dynamics & Metacognitive Homeostasis"]
        LoopB1["Balancing Loop (B1): Adaptive Workload Regulation\n(Depleted Cognitive Bandwidth -> Triggers Workload Shedding)"]:::loop
        LoopB2["Balancing Loop (B2): Supervisory Hierarchy Escalation\n(High Distress Telemetry -> Senior Intervention Allocation)"]:::loop
        LoopR1["Reinforcing Loop (R1): Synergy Compounding\n(Tailored Accommodations -> Expands Longitudinal Cognitive Bandwidth)"]:::loop
    end

    StockBandwidth -.->|Capacity Depletion Telemetry| LoopB1
    LoopB1 -.->|Pacing Adjustment| InflowLoad

    StockTelemetry -.->|Threshold Trigger| LoopB2
    LoopB2 -.->|Supervisory Flow| OutflowAnalysis

    OutflowApplication -.->|Capacity Reconstitution| LoopR1
    LoopR1 -.->|Capacity Boost| StockBandwidth
```

## Ephemeral Docker Compilation Command

To compile both `.mmd` diagrams into standalone `.svg` vectors locally without host dependencies:

```bash
docker run --rm -v "$(pwd)/projects/04-cognitive-capacity-modeling-engine/diagrams":/data minlag/mermaid-cli -i /data/architecture.mmd -o /data/architecture.svg
docker run --rm -v "$(pwd)/projects/04-cognitive-capacity-modeling-engine/diagrams":/data minlag/mermaid-cli -i /data/stocks-and-flows.mmd -o /data/stocks-and-flows.svg
```
