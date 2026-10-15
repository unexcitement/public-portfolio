# Nutritional Logistics & Assisted Meal Delivery Platform

## Executive Summary
This municipal logistics and meal delivery platform coordinates hot food distribution and nutritional fulfillment for vulnerable, elderly, and mobility-impaired residents. Developed using Node.js, Express, EJS, and MariaDB, the platform schedules complex recurring dietary matrices (offering over 50 monthly meal variations and multi-option daily menus), verifies dietary restrictions, and organizes driver dispatch routes. By structuring the handover lifecycle into auditable state transitions, the system ensures timely social care delivery across distributed urban catchments.

## Core Architectural Paradigms
- **Complex Dietary Matrix Scheduling**: Supports dynamic rotating menus and individual allergen exclusions, matching recipient medical requirements against daily kitchen batch outputs.
- **Route-Constrained Delivery Dispatches**: Clusters delivery addresses into geographically constrained route manifests to ensure hot meals arrive within strict thermal holding windows.
- **Lightweight Low-Bandwidth Interface**: Built with server-side rendered EJS templates to ensure rapid loading on low-power mobile devices used by volunteer drivers in the field.
- **Auditable Care Verification**: Maintains historical delivery ledgers and recipient contact notes to support social care compliance audits and safeguarding oversight.

## Systems Architecture Diagram

```mermaid
flowchart TB
    subgraph RecipientLayer["Client & Community Interface"]
        Caregiver["Caregivers / Municipal Case Workers"]
        Recipient["Vulnerable Citizens / Phone-in Coordinators"]
        WebPortal["Web Portal & Menu Selection UI (EJS / Bootstrap)"]
    end

    subgraph LogisticsCore["Express Logistics Engine (:3000)"]
        Router["Express Dispatch Controller"]
        Validator["Dietary & Order Validator"]
        
        subgraph Subsystems["Fulfillment Subsystems"]
            MenuMatrix["Rotating Menu Scheduler (50+ Monthly Dietary Rules)"]
            DriverRouter["Driver Route & Zone Dispatch Coordinator"]
        end

        subgraph LocalStore["Relational Persistence"]
            DB[("MariaDB Datastore\n(Orders, Client Dietary Profiles, Route Manifests)")]
        end
    end

    subgraph PhysicalExecution["Field Execution Perimeter"]
        KitchenStation["Central Preparation Kitchens"]
        MobileDrivers["Volunteer & Dedicated Driver Fleet"]
        Doorstep["End Recipient Handover Verification"]
    end

    Caregiver --> WebPortal
    Recipient --> WebPortal
    WebPortal --> Router
    Router --> Validator
    Validator --> MenuMatrix
    MenuMatrix --> DB
    
    MenuMatrix --> KitchenStation
    Router --> DriverRouter
    DriverRouter --> MobileDrivers
    KitchenStation --> MobileDrivers
    MobileDrivers --> Doorstep
    Doorstep -.->|Proof of Delivery Telemetry| Router
```

## Applied Systems Theory: Stocks & Flows Dynamics

```mermaid
flowchart LR
    classDef stock fill:#1e293b,stroke:#38bdf8,stroke-width:3px,color:#f8fafc;
    classDef flow fill:#0f172a,stroke:#a855f7,stroke-width:2px,color:#f8fafc;
    classDef loop fill:#312e81,stroke:#f59e0b,stroke-width:2px,stroke-dasharray: 5 5,color:#fbbf24;

    SourceResidents((Vulnerable Citizen Meal Requests))
    InflowOrders[Inflow: Order Intake Velocity]
    StockOrders[Stock: Pending Daily Meal Orders]:::stock
    OutflowPrep[Outflow: Kitchen Meal Preparation Rate]

    StockHotMeals[Stock: Prepared Hot Meals Ready for Dispatch]:::stock
    OutflowTransit[Outflow: Driver Route Dispatch Velocity]

    StockInTransit[Stock: In-Transit Meals on Road]:::stock
    OutflowHandover[Outflow: Doorstep Delivery Handover Rate]

    SinkDelivered((Nourished Citizen Welfare State))

    SourceResidents --> InflowOrders
    InflowOrders --> StockOrders
    StockOrders --> OutflowPrep
    OutflowPrep --> StockHotMeals
    StockHotMeals --> OutflowTransit
    OutflowTransit --> StockInTransit
    StockInTransit --> OutflowHandover
    OutflowHandover --> SinkDelivered

    subgraph Loops["Systems Dynamics & Logistics Resilience Loops"]
        LoopB1["Balancing Loop (B1): Kitchen Thermal Holding Capacity\n(Hot Meals Stock High -> Throttles Outflow from Kitchen Batch)"]:::loop
        LoopB2["Balancing Loop (B2): Delivery Transit Time Ceiling\n(Hot Food Cold-Drop Watchdog -> Limits Max Driver Route Stops)"]:::loop
        LoopR1["Reinforcing Loop (R1): Municipal Service Dependability\n(Timely Nutritional Delivery -> Expands Community Welfare Outcomes)"]:::loop
    end

    StockHotMeals -.->|Holding Heat Window| LoopB1
    LoopB1 -.->|Pacing Signal| OutflowPrep

    StockInTransit -.->|Elapsed Route Time| LoopB2
    LoopB2 -.->|Route Cap| OutflowTransit

    SinkDelivered -.->|Welfare Stability| LoopR1
    LoopR1 -.->|Program Expansion| SourceResidents
```

## Ephemeral Docker Compilation Command

To compile both `.mmd` diagrams into standalone `.svg` vectors locally without host dependencies:

```bash
docker run --rm -v "$(pwd)/projects/21-nutritional-logistics-assisted-delivery-platform/diagrams":/data minlag/mermaid-cli -i /data/architecture.mmd -o /data/architecture.svg
docker run --rm -v "$(pwd)/projects/21-nutritional-logistics-assisted-delivery-platform/diagrams":/data minlag/mermaid-cli -i /data/stocks-and-flows.mmd -o /data/stocks-and-flows.svg
```
