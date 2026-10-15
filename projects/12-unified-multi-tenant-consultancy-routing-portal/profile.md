# Unified Multi-Tenant Engineering Consultancy Portal & Dynamic Routing Engine

## Executive Summary
This enterprise corporate portal and technical showcase serves multiple distinct brand domains and product surfaces from a single, unified codebase and containerized footprint. Built with Nuxt 3 (SSR) and an Express API backend, the architecture dynamically inspects incoming HTTP Host headers to render tailored customer experiences—spanning high-level consultancy offerings, architectural framework specifications, and interactive product sandboxes. This approach minimizes operational hosting overhead while providing a cohesive, centralized identity for multi-faceted enterprise advisory engagements.

## Core Architectural Paradigms
- **Dynamic Hostname Inspection & Multi-Domain Dispatch**: Resolves incoming subdomains and apex domains at the server runtime level, rendering distinct layouts and component trees without requiring separate deployments.
- **Unified Containerized Deployment Topology**: Orchestrates frontend presentation and backend API services within an isolated Docker Compose network, fronted by an SSL-terminating Nginx reverse proxy.
- **Secure Asynchronous Form Processing & SMTP Submission**: Routes client inquiry payloads through validation middleware, dispatching encrypted email notifications via dedicated TLS mail relays without exposing internal network endpoints.
- **Server-Side Rendered (SSR) Performance & SEO Optimization**: Combines Vue 3 hydration with edge rendering to guarantee near-instant First Contentful Paint (FCP) and optimal search crawler indexation across all corporate subdomains.

## Systems Architecture Diagram

```mermaid
flowchart TB
    subgraph WANIngress["Public Multi-Domain Ingress Tier"]
        DomainMain["Primary Enterprise Hub (domain.tld)"]
        DomainConsult["Consulting Surface (consulting.domain.tld)"]
        DomainDocs["Framework Docs (docs.domain.tld)"]
        DomainSandbox["Sandbox Control Surface (sandbox.domain.tld)"]
        
        ReverseProxy["Global Nginx Edge Proxy (shared-web-network)\n(SSL Termination & SNI Forwarding)"]
    end

    subgraph ContainerAppliance["Multi-Tenant Application Footprint (Docker Compose)"]
        subgraph FrontendTier["Nuxt 3 SSR Unified Frontend (:3000)"]
            HostResolver["Hostname Route Resolver Middleware\n(Inspects Host Header on Ingress)"]
            
            subgraph DynamicViews["Dynamic Surface Renderers"]
                ViewHub["Hub & Capability Showcase"]
                ViewConsult["Consultancy Service Catalog"]
                ViewDocs["Technical Framework Specifications"]
                ViewSandbox["Interactive Architecture Walkthroughs"]
            end
        end

        subgraph BackendTier["Node.js / Express API Service (:5000)"]
            APIGateway["Express API Router (/api/**)"]
            ContactHandler["Contact Form & Validation Controller"]
            MailDispatcher["Nodemailer Transactional SMTP Dispatcher"]
        end
    end

    subgraph OutboundComms["Encrypted Outbound Communication"]
        MailRelay["Hardened SMTP Mail Node (Proton / TLS Submission)"]
        LeadInbox["Audited Client Inquiry Mailbox"]
    end

    DomainMain --> ReverseProxy
    DomainConsult --> ReverseProxy
    DomainDocs --> ReverseProxy
    DomainSandbox --> ReverseProxy

    ReverseProxy -->|Internal Proxy Pass| HostResolver
    HostResolver --> ViewHub
    HostResolver --> ViewConsult
    HostResolver --> ViewDocs
    HostResolver --> ViewSandbox

    FrontendTier -->|Internal Nitro Proxy /api/**| APIGateway
    APIGateway --> ContactHandler
    ContactHandler --> MailDispatcher
    MailDispatcher -->|TLS Port 465/587| MailRelay
    MailRelay --> LeadInbox
```

## Applied Systems Theory: Stocks & Flows Dynamics

```mermaid
flowchart LR
    classDef stock fill:#1e293b,stroke:#38bdf8,stroke-width:3px,color:#f8fafc;
    classDef flow fill:#0f172a,stroke:#a855f7,stroke-width:2px,color:#f8fafc;
    classDef loop fill:#312e81,stroke:#f59e0b,stroke-width:2px,stroke-dasharray: 5 5,color:#fbbf24;

    SourceTraffic((Multi-Domain Client Traffic))
    InflowVisits[Inflow: Subdomain Routing Ingress Velocity]
    StockViews[Stock: SSR Cached View Footprint]:::stock
    OutflowBounce[Outflow: Passive Session Drop Flow]

    StockLeads[Stock: Validated Inbound Enterprise Inquiries]:::stock
    OutflowDispatch[Outflow: Encrypted SMTP Dispatch Flow]

    StockPipeline[Stock: Active Engineering Consultancy Pipeline]:::stock
    OutflowClosed[Outflow: Project Commissioning & Delivery]

    SinkArchived((Executed Architectural Mandate))

    SourceTraffic --> InflowVisits
    InflowVisits --> StockViews
    StockViews --> OutflowBounce
    StockViews --> StockLeads
    StockLeads --> OutflowDispatch
    OutflowDispatch --> StockPipeline
    StockPipeline --> OutflowClosed
    OutflowClosed --> SinkArchived

    subgraph Loops["Systems Dynamics & Business Leverage Loops"]
        LoopB1["Balancing Loop (B1): Contact Anti-Spam Throttling\n(Inquiry Spike -> Rate-Limits Ingress SMTP Sockets)"]:::loop
        LoopB2["Balancing Loop (B2): Principal Capacity Limit\n(High Active Pipeline -> Increases Engagement Threshold / Pricing)"]:::loop
        LoopR1["Reinforcing Loop (R1): Multi-Domain Authority Compounding\n(High-Calibre Technical Delivery -> Elevates High-Value Enterprise Inquiries)"]:::loop
    end

    StockLeads -.->|Lead Velocity Telemetry| LoopB1
    LoopB1 -.->|Pacing Signal| InflowVisits

    StockPipeline -.->|Consulting Saturation Sensing| LoopB2
    LoopB2 -.->|Qualification Filter| OutflowDispatch

    OutflowClosed -.->|Case Study Authority| LoopR1
    LoopR1 -.->|Enterprise Lead Growth| SourceTraffic
```

## Ephemeral Docker Compilation Command

To compile both `.mmd` diagrams into standalone `.svg` vectors locally without host dependencies:

```bash
docker run --rm -v "$(pwd)/projects/12-unified-multi-tenant-consultancy-routing-portal/diagrams":/data minlag/mermaid-cli -i /data/architecture.mmd -o /data/architecture.svg
docker run --rm -v "$(pwd)/projects/12-unified-multi-tenant-consultancy-routing-portal/diagrams":/data minlag/mermaid-cli -i /data/stocks-and-flows.mmd -o /data/stocks-and-flows.svg
```
