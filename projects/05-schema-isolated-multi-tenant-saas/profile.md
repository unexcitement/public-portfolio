# Schema-Isolated Multi-Tenant Distributed SaaS Foundation (OASIS)

## Executive Summary
OASIS (Opinionated Architecture for Secure Isolated SaaS) provides a high-leverage software foundation that combines the security of isolated multi-tenancy with the developer ergonomics of single-tenant development. By assigning every customer an independent PostgreSQL schema via automatic `SET LOCAL search_path` transaction scoping and managing fine-grained RBAC with Casbin and Redis, the framework physically prevents cross-tenant data contamination. Coupled with dynamic on-demand TLS termination via Caddy and a unified Nuxt 3 presentation engine, it empowers engineering teams to ship enterprise-grade SaaS products with zero architectural compromises on data sovereignty.

## Core Architectural Paradigms
- **Database Schema Isolation**: Enforces physical boundaries at the database layer with one PostgreSQL schema per tenant, rendering cross-tenant data leakage impossible even in the event of application-level SQL logic bugs.
- **Domain-Scoped Casbin RBAC**: Implements unified Role-Based Access Control synchronizing role changes across distributed nodes in real time via a Redis-watcher pub/sub network.
- **Zero-Friction Single-Tenant Developer Model**: Back-end feature code writes standard ORM queries (Ent) without manually appending `tenant_id` WHERE clauses, drastically reducing developer cognitive load and vulnerability surface area.
- **Dynamic On-Demand Edge Ingress**: Caddy orchestrates automated Let's Encrypt TLS certificate generation and routing for unlimited custom customer CNAME hostnames on the fly.

## Systems Architecture Diagram

```mermaid
flowchart TB
    subgraph EdgePerimeter["Edge Routing & TLS Ingress Tier"]
        TenantA["tenant-a.saasdomain.tld"]
        TenantB["tenant-b.saasdomain.tld"]
        CustomDomain["app.customer.tld (Custom CNAME)"]
        SuperAdmin["admin.saasdomain.tld"]
        
        CaddyIngress["Caddy Reverse Proxy\n(On-Demand TLS + Wildcard Routing)"]
    end

    subgraph AppTier["Application & API Cluster"]
        NuxtApp["Nuxt 3 SSR Application\n(Marketing, Super-Admin & Tenant Surfaces)"]
        
        subgraph GoAPIService["Go API Core Service (oasis-core)"]
            TenantResolver["Tenant Resolution Middleware\n(Host Header -> Tenant UUID)"]
            CasbinRBAC["Casbin v3 RBAC Engine\n(Domain-Scoped Permissions)"]
            TxManager["Tenant Transaction Coordinator\n(SET LOCAL search_path = tenant_UUID)"]
            EntORM["Ent ORM Layer (Type-Safe Schema Querying)"]
        end
    end

    subgraph DataSovereigntyTier["Isolated Persistence & Cache Cluster"]
        RedisCluster[("Redis Cluster\n(Casbin Policy Sync & Redis Watcher)")]
        
        subgraph PostgreSQLCluster["PostgreSQL Multi-Tenant Database"]
            PublicSchema[("public Schema: Tenants, Global Users, Audit Logs")]
            TenantSchemaA[("tenant_a8f9... Schema: Isolated Domain Data")]
            TenantSchemaB[("tenant_c41e... Schema: Isolated Domain Data")]
            TenantSchemaN[("tenant_... Schema: Isolated Domain Data")]
        end
    end

    TenantA --> CaddyIngress
    TenantB --> CaddyIngress
    CustomDomain --> CaddyIngress
    SuperAdmin --> CaddyIngress

    CaddyIngress -->|SSR Web Surface| NuxtApp
    CaddyIngress -->|REST API /api/*| TenantResolver

    TenantResolver --> CasbinRBAC
    CasbinRBAC <-->|Policy Change Pub/Sub| RedisCluster
    CasbinRBAC --> TxManager
    TxManager --> EntORM

    EntORM --> PublicSchema
    EntORM -->|Scoped Isolation| TenantSchemaA
    EntORM -->|Scoped Isolation| TenantSchemaB
    EntORM -->|Scoped Isolation| TenantSchemaN
```

## Applied Systems Theory: Stocks & Flows Dynamics

```mermaid
flowchart LR
    classDef stock fill:#1e293b,stroke:#38bdf8,stroke-width:3px,color:#f8fafc;
    classDef flow fill:#0f172a,stroke:#a855f7,stroke-width:2px,color:#f8fafc;
    classDef loop fill:#312e81,stroke:#f59e0b,stroke-width:2px,stroke-dasharray: 5 5,color:#fbbf24;

    SourceTenants((Enterprise Onboarding Demand))
    InflowProvision[Inflow: Schema Provisioning Rate]
    StockSchemas[Stock: Active Isolated PostgreSQL Schemas]:::stock
    OutflowDecommission[Outflow: Tenant Deprovisioning Flow]

    StockConnections[Stock: PostgreSQL Connection Pool Allocation]:::stock
    OutflowTx[Outflow: Scoped Transaction Discharge Rate]

    StockPolicies[Stock: Synchronized Casbin Policy State]:::stock
    OutflowPolicySync[Outflow: Redis Watcher Invalidation Flow]

    SinkArchived((Clean Zero-Artifact Termination))

    SourceTenants --> InflowProvision
    InflowProvision --> StockSchemas
    StockSchemas --> OutflowDecommission
    OutflowDecommission --> SinkArchived

    StockSchemas --> StockConnections
    StockConnections --> OutflowTx
    OutflowTx --> SinkArchived

    StockPolicies --> OutflowPolicySync
    OutflowPolicySync --> StockPolicies

    subgraph Loops["Systems Dynamics & Multi-Tenant Equilibrium"]
        LoopB1["Balancing Loop (B1): Connection Pool Contention Throttle\n(High Pool Allocation -> Queue Tenant Transaction Ingress)"]:::loop
        LoopB2["Balancing Loop (B2): Schema Migration Pacing\n(Active Transaction Load -> Throttle DDL Migration Waves)"]:::loop
        LoopR1["Reinforcing Loop (R1): Sovereign Trust Compounding\n(Zero Cross-Tenant Leaks -> Increases High-Compliance Adoption)"]:::loop
    end

    StockConnections -.->|Pool Saturation Sensing| LoopB1
    LoopB1 -.->|Pacing Signal| InflowProvision

    StockConnections -.->|Lock Contention Sensing| LoopB2
    LoopB2 -.->|Migration Delay Signal| StockSchemas

    StockSchemas -.->|Compliance Reputation| LoopR1
    LoopR1 -.->|Accelerated Adoption| SourceTenants
```

## Ephemeral Docker Compilation Command

To compile both `.mmd` diagrams into standalone `.svg` vectors locally without host dependencies:

```bash
docker run --rm -v "$(pwd)/projects/05-schema-isolated-multi-tenant-saas/diagrams":/data minlag/mermaid-cli -i /data/architecture.mmd -o /data/architecture.svg
docker run --rm -v "$(pwd)/projects/05-schema-isolated-multi-tenant-saas/diagrams":/data minlag/mermaid-cli -i /data/stocks-and-flows.mmd -o /data/stocks-and-flows.svg
```
