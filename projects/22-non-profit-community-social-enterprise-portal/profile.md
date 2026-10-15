# Non-Profit Community Social Enterprise & Outreach Distribution Portal

## Executive Summary
This community operations and public advocacy platform coordinates subsidized food relief, supported internships, and volunteer engagement for a regional Community Interest Company (CIC). Engineered with Node.js, Express, and MariaDB, the system provides transparent tracking across grant-funded meal delivery programs (distributing hundreds of tailored meals to vulnerable families) and structured employment coaching for supported interns. By providing verifiable audit trails of community outcomes, the portal enables sustainable self-funding and institutional stakeholder alignment.

## Core Architectural Paradigms
- **Outcome-Driven Resource Ledgering**: Tracks meal allocations, coaching hours, and community placement completions against specific grant envelopes, satisfying statutory CIC reporting requirements.
- **Multi-Stakeholder Portal Navigation**: Integrates distinct workflow surfaces for volunteers, partner educational institutions, municipal grant managers, and program beneficiaries.
- **Zero-Friction In-House Hosting**: Deployed on low-overhead containerized infrastructure to minimize non-profit hosting expenditures and guarantee local data sovereignty.
- **Scalable Program Diversification**: Structured modular controllers allow rapid onboarding of new social enterprise initiatives (e.g., day care services, catering ventures) without codebase refactoring.

## Systems Architecture Diagram

```mermaid
flowchart TB
    subgraph CommunityTouchpoints["Community Stakeholders & Beneficiaries"]
        Beneficiary["Local Families / Supported Interns"]
        Volunteer["Volunteers & Job Coaches"]
        Donor["Council / Grant Funding Bodies"]
        WebPortal["Enterprise Outreach Portal (EJS / CSS)"]
    end

    subgraph ServiceEngine["Node.js Application Layer (:3000)"]
        Router["Express Application Controller"]
        
        subgraph FunctionalModules["Core Social Enterprise Modules"]
            MealDistribution["Food Program & Meal Delivery Dispatcher"]
            InternshipHub["Supported Internship Coaching & Hours Tracker"]
            ProjectGallery["Community Initiatives & Activity Showcase"]
            InquiryGateway["Beneficiary Intake & Volunteer Application Router"]
        end

        subgraph LocalStore["Relational Store"]
            DB[("MariaDB Datastore\n(Placements, Volunteer Logs, Meal Distribution Ledger)")]
        end
    end

    subgraph PartnerPerimeter["Partner Ecosystem (Colleges / Housing Trusts)"]
        PartnerHousing["Local Housing Trust (Funding Partner)"]
        PartnerCollege["Regional College (Internship Provider)"]
    end

    Beneficiary --> WebPortal
    Volunteer --> WebPortal
    Donor --> WebPortal
    WebPortal --> Router

    Router --> MealDistribution
    Router --> InternshipHub
    Router --> ProjectGallery
    Router --> InquiryGateway

    MealDistribution --> DB
    InternshipHub --> DB
    InquiryGateway --> DB

    PartnerHousing <-->|Grant Audit Telemetry| WebPortal
    PartnerCollege <-->|Internship Verification| InternshipHub
```

## Applied Systems Theory: Stocks & Flows Dynamics

```mermaid
flowchart LR
    classDef stock fill:#1e293b,stroke:#38bdf8,stroke-width:3px,color:#f8fafc;
    classDef flow fill:#0f172a,stroke:#a855f7,stroke-width:2px,color:#f8fafc;
    classDef loop fill:#312e81,stroke:#f59e0b,stroke-width:2px,stroke-dasharray: 5 5,color:#fbbf24;

    SourceFunding((Grant & Municipal Funding Influx))
    InflowGrants[Inflow: Grant Allocation Flow]
    StockCapital[Stock: Operational Social Enterprise Capital]:::stock
    OutflowOperations[Outflow: Community Service Expenditure Rate]

    StockInterns[Stock: Enrolled Supported Interns]:::stock
    OutflowPlacement[Outflow: Work Placement Graduation Velocity]

    StockMeals[Stock: Subsidized Food Distribution Capacity]:::stock
    OutflowDistribution[Outflow: Family Meal Provisioning Rate]

    SinkImpact((Empowered Community Well-Being))

    SourceFunding --> InflowGrants
    InflowGrants --> StockCapital
    StockCapital --> OutflowOperations
    OutflowOperations --> StockMeals
    OutflowOperations --> StockInterns

    StockMeals --> OutflowDistribution
    StockInterns --> OutflowPlacement
    OutflowDistribution --> SinkImpact
    OutflowPlacement --> SinkImpact

    subgraph Loops["Systems Dynamics & Social Enterprise Feedback Loops"]
        LoopB1["Balancing Loop (B1): Grant Depletion Throttle\n(Capital Reserves Dip -> Paces New Placement Commitments)"]:::loop
        LoopR1["Reinforcing Loop (R1): Social Impact Multiplier\n(High Graduation & Meal Delivery -> Secures Follow-on Municipal Grants)"]:::loop
    end

    StockCapital -.->|Reserves Margin| LoopB1
    LoopB1 -.->|Pacing Signal| OutflowOperations

    SinkImpact -.->|Verified Social ROI| LoopR1
    LoopR1 -.->|Grant Renewal Acceleration| InflowGrants
```

## Ephemeral Docker Compilation Command

To compile both `.mmd` diagrams into standalone `.svg` vectors locally without host dependencies:

```bash
docker run --rm -v "$(pwd)/projects/22-non-profit-community-social-enterprise-portal/diagrams":/data minlag/mermaid-cli -i /data/architecture.mmd -o /data/architecture.svg
docker run --rm -v "$(pwd)/projects/22-non-profit-community-social-enterprise-portal/diagrams":/data minlag/mermaid-cli -i /data/stocks-and-flows.mmd -o /data/stocks-and-flows.svg
```
