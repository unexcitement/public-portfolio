# Project Index

A fast navigational guide across all 26 projects in this portfolio, indexed by role, concept, technology and industry sector.

**Jump to:** [By Role](#by-role) · [By Concept](#by-concept) · [By Technology](#by-technology) · [By Sector](#by-sector)

---

## By Role

### Platform Operations & SRE

For hiring managers and engineers looking for infrastructure, platform, DevOps or site reliability experience.

| Project | Why it matters for this role |
|---|---|
| [07 Sovereign LXD Cluster](projects/07-sovereign-hybrid-cloud-lxd-cluster/profile.md) | A multi-node LXD cluster with Raft quorum, OIDC, secret management, isolated egress and full observability. |
| [06 AI Sandbox Control Plane](projects/06-autonomous-ai-sandbox-control-plane/profile.md) | Kernel-level sandboxing for untrusted workloads: zero-egress firewalling, ZFS copy-on-write and GPU fencing. |
| [20 LXD Clustering Toolkit](projects/20-automated-lxd-clustering-provisioning-toolkit/profile.md) | Idempotent bootstrapping that federates mixed hardware into one cluster without hand-copied certificates. |
| [19 Git Mirror Automation](projects/19-sovereign-git-continuous-mirror-automation/profile.md) | Continuous pull-mirroring of source code onto self-hosted Gitea for supply-chain independence. |
| [24 ChatOps Telemetry Microservice](projects/24-automated-chatops-telemetry-microservice/profile.md) | A small, stateless container that turns telemetry into ChatOps alerts with rate-limit backoff. |
| [01 Event-Sourcing Operations Hub](projects/01-event-sourcing-operations-hub/profile.md) | Infrastructure as code provisioning of the sandboxes behind an event-driven control surface. |

**Also relevant:** [02 EPOS TCP Proxy Middleware](projects/02-epos-tcp-proxy-middleware/profile.md), [05 OASIS Multi-Tenant SaaS](projects/05-schema-isolated-multi-tenant-saas/profile.md), [08 Workforce Scheduling Engine](projects/08-enterprise-workforce-scheduling-engine/profile.md), [09 Geospatial Stream Dashboard](projects/09-geospatial-live-stream-intelligence-dashboard/profile.md), [10 Network Recon Pipeline](projects/10-high-throughput-network-recon-pipeline/profile.md), [11 Headless Scraping Cluster](projects/11-distributed-headless-scraping-cluster/profile.md), [12 Consultancy Routing Portal](projects/12-unified-multi-tenant-consultancy-routing-portal/profile.md), [18 Game Server RCON Orchestrator](projects/18-dedicated-game-server-rcon-orchestrator/profile.md), [22 Social Enterprise Portal](projects/22-non-profit-community-social-enterprise-portal/profile.md), [23 Shopify Storefront Engine](projects/23-containerized-ecommerce-design-system/profile.md), [26 Portfolio Engine](projects/26-principal-systems-engineering-portfolio/profile.md)

Detailed role guide and terms: **[Platform Operations & SRE Guide](docs/roles/platform-operations.md)**

---

### Software Engineering (Backend & Distributed Systems)

For engineering leads assessing backend, concurrency, data modelling and distributed systems depth.

| Project | Why it matters for this role |
|---|---|
| [01 Event-Sourcing Operations Hub](projects/01-event-sourcing-operations-hub/profile.md) | Go ingress proxy, append-only SQLite WAL ledger and SSE fan-out with human approval gates. |
| [02 EPOS TCP Proxy Middleware](projects/02-epos-tcp-proxy-middleware/profile.md) | Binary protocol reverse-engineering: concurrent TCP proxying, in-memory raster decoding and OCR, failing open. |
| [03 Competition & Prize Platform](projects/03-competition-prize-gaming-platform/profile.md) | Pessimistic locking, Redis reservations and BullMQ settlement to survive flash-sale spikes without double allocation. |
| [05 OASIS Multi-Tenant SaaS](projects/05-schema-isolated-multi-tenant-saas/profile.md) | Schema-per-tenant PostgreSQL with transaction-scoped search_path and distributed RBAC. |
| [08 Workforce Scheduling Engine](projects/08-enterprise-workforce-scheduling-engine/profile.md) | Optimistic concurrency with HTTP 409/428, dual-database isolation and an integer time grid. |
| [10 Network Recon Pipeline](projects/10-high-throughput-network-recon-pipeline/profile.md) | Goroutine worker pools and staged pruning across very large address spaces. |

**Also relevant:** [04 Capacity Modeling Engine](projects/04-cognitive-capacity-modeling-engine/profile.md), [06 AI Sandbox Control Plane](projects/06-autonomous-ai-sandbox-control-plane/profile.md), [07 Sovereign LXD Cluster](projects/07-sovereign-hybrid-cloud-lxd-cluster/profile.md), [09 Geospatial Stream Dashboard](projects/09-geospatial-live-stream-intelligence-dashboard/profile.md), [11 Headless Scraping Cluster](projects/11-distributed-headless-scraping-cluster/profile.md), [12 Consultancy Routing Portal](projects/12-unified-multi-tenant-consultancy-routing-portal/profile.md), [13 Livestreaming Platform](projects/13-low-latency-event-broadcast-platform/profile.md), [14 Web3 Notary Gateway](projects/14-decentralized-notary-web3-auth-gateway/profile.md), [16 Expression Complexity Engine](projects/16-algorithmic-expression-complexity-engine/profile.md), [17 DB Introspection Console](projects/17-dynamic-relational-db-introspection-console/profile.md), [18 Game Server RCON Orchestrator](projects/18-dedicated-game-server-rcon-orchestrator/profile.md), [19 Git Mirror Automation](projects/19-sovereign-git-continuous-mirror-automation/profile.md), [21 Assisted Meal Delivery Platform](projects/21-nutritional-logistics-assisted-delivery-platform/profile.md), [22 Social Enterprise Portal](projects/22-non-profit-community-social-enterprise-portal/profile.md), [24 ChatOps Telemetry Microservice](projects/24-automated-chatops-telemetry-microservice/profile.md), [25 MEEN Full-Stack Scaffold](projects/25-monolithic-relational-fullstack-scaffold/profile.md)

Detailed role guide and terms: **[Software Engineering Guide](docs/roles/software-engineering.md)**

---

### Security Engineering

For security teams and CISOs looking for isolation, identity, secrets and audit design.

| Project | Why it matters for this role |
|---|---|
| [06 AI Sandbox Control Plane](projects/06-autonomous-ai-sandbox-control-plane/profile.md) | Zero-egress containment, CoW sandboxes and short-lived secrets for untrusted AI agents. |
| [05 OASIS Multi-Tenant SaaS](projects/05-schema-isolated-multi-tenant-saas/profile.md) | Tenant isolation enforced at the database layer rather than in application WHERE clauses. |
| [07 Sovereign LXD Cluster](projects/07-sovereign-hybrid-cloud-lxd-cluster/profile.md) | Zero-trust identity with Authentik OIDC and OpenBao, plus namespace-isolated egress. |
| [14 Web3 Notary Gateway](projects/14-decentralized-notary-web3-auth-gateway/profile.md) | Non-custodial key management and Merkle-batched on-chain notarisation. |
| [18 Game Server RCON Orchestrator](projects/18-dedicated-game-server-rcon-orchestrator/profile.md) | Keeping game-server admin ports off the internet behind an authenticated, audited bridge. |
| [26 Portfolio Engine](projects/26-principal-systems-engineering-portfolio/profile.md) | Hazard Filtering: the redaction process used to publish this portfolio. |

**Also relevant:** [01 Event-Sourcing Operations Hub](projects/01-event-sourcing-operations-hub/profile.md), [03 Competition & Prize Platform](projects/03-competition-prize-gaming-platform/profile.md), [04 Capacity Modeling Engine](projects/04-cognitive-capacity-modeling-engine/profile.md), [08 Workforce Scheduling Engine](projects/08-enterprise-workforce-scheduling-engine/profile.md), [12 Consultancy Routing Portal](projects/12-unified-multi-tenant-consultancy-routing-portal/profile.md), [16 Expression Complexity Engine](projects/16-algorithmic-expression-complexity-engine/profile.md), [19 Git Mirror Automation](projects/19-sovereign-git-continuous-mirror-automation/profile.md), [20 LXD Clustering Toolkit](projects/20-automated-lxd-clustering-provisioning-toolkit/profile.md), [21 Assisted Meal Delivery Platform](projects/21-nutritional-logistics-assisted-delivery-platform/profile.md), [22 Social Enterprise Portal](projects/22-non-profit-community-social-enterprise-portal/profile.md)

Detailed role guide and terms: **[Security Engineering Guide](docs/roles/security-engineering.md)**

---

### Frontend & Product Engineering

For product teams looking for user-facing, real-time and interactive application work.

| Project | Why it matters for this role |
|---|---|
| [15 Web Audio Synthesizer](projects/15-web-audio-dsp-modular-synthesizer/profile.md) | A modular synthesizer on the Web Audio API with voice stealing and sample-accurate automation. |
| [09 Geospatial Stream Dashboard](projects/09-geospatial-live-stream-intelligence-dashboard/profile.md) | Leaflet GIS with live HLS thumbnails and alert states, packaged as a self-contained appliance. |
| [12 Consultancy Routing Portal](projects/12-unified-multi-tenant-consultancy-routing-portal/profile.md) | One Nuxt 3 SSR codebase serving several brands by inspecting the Host header. |
| [16 Expression Complexity Engine](projects/16-algorithmic-expression-complexity-engine/profile.md) | AST-driven expression transforms with invariant checks and a branching history timeline. |
| [08 Workforce Scheduling Engine](projects/08-enterprise-workforce-scheduling-engine/profile.md) | A React 19 scheduling UI backed by conflict-safe edits and headless PDF export. |
| [23 Shopify Storefront Engine](projects/23-containerized-ecommerce-design-system/profile.md) | A containerised Shopify theme toolchain with modular Liquid components. |

**Also relevant:** [01 Event-Sourcing Operations Hub](projects/01-event-sourcing-operations-hub/profile.md), [03 Competition & Prize Platform](projects/03-competition-prize-gaming-platform/profile.md), [05 OASIS Multi-Tenant SaaS](projects/05-schema-isolated-multi-tenant-saas/profile.md), [13 Livestreaming Platform](projects/13-low-latency-event-broadcast-platform/profile.md), [21 Assisted Meal Delivery Platform](projects/21-nutritional-logistics-assisted-delivery-platform/profile.md), [24 ChatOps Telemetry Microservice](projects/24-automated-chatops-telemetry-microservice/profile.md), [25 MEEN Full-Stack Scaffold](projects/25-monolithic-relational-fullstack-scaffold/profile.md), [26 Portfolio Engine](projects/26-principal-systems-engineering-portfolio/profile.md)

Detailed role guide and terms: **[Frontend & Product Engineering Guide](docs/roles/frontend-product.md)**

---

### Solutions Architecture & Technical Consulting

For clients, founders and leadership looking for someone to translate business and social outcomes into systems.

| Project | Why it matters for this role |
|---|---|
| [05 OASIS Multi-Tenant SaaS](projects/05-schema-isolated-multi-tenant-saas/profile.md) | OASIS: a reusable SaaS foundation, the 'engine' in the Engine + Paint delivery model. |
| [12 Consultancy Routing Portal](projects/12-unified-multi-tenant-consultancy-routing-portal/profile.md) | A consultancy front door serving several brands and offerings from one footprint. |
| [22 Social Enterprise Portal](projects/22-non-profit-community-social-enterprise-portal/profile.md) | Outcome ledgers that let a Community Interest Company report against grant funding. |
| [21 Assisted Meal Delivery Platform](projects/21-nutritional-logistics-assisted-delivery-platform/profile.md) | Dietary, routing and safeguarding requirements for vulnerable residents turned into an auditable workflow. |
| [04 Capacity Modeling Engine](projects/04-cognitive-capacity-modeling-engine/profile.md) | Modelling cognitive load and capacity across organisations for clinical and leadership use. |
| [26 Portfolio Engine](projects/26-principal-systems-engineering-portfolio/profile.md) | Dual-paradigm documentation: every system explained as topology and as Stocks & Flows. |

**Also relevant:** [01 Event-Sourcing Operations Hub](projects/01-event-sourcing-operations-hub/profile.md), [03 Competition & Prize Platform](projects/03-competition-prize-gaming-platform/profile.md), [06 AI Sandbox Control Plane](projects/06-autonomous-ai-sandbox-control-plane/profile.md), [07 Sovereign LXD Cluster](projects/07-sovereign-hybrid-cloud-lxd-cluster/profile.md), [08 Workforce Scheduling Engine](projects/08-enterprise-workforce-scheduling-engine/profile.md), [18 Game Server RCON Orchestrator](projects/18-dedicated-game-server-rcon-orchestrator/profile.md), [19 Git Mirror Automation](projects/19-sovereign-git-continuous-mirror-automation/profile.md), [25 MEEN Full-Stack Scaffold](projects/25-monolithic-relational-fullstack-scaffold/profile.md)

Detailed role guide and terms: **[Solutions Architecture & Technical Consulting Guide](docs/roles/solutions-architecture.md)**

---

## By Concept

For architectural patterns and concept definitions across all 26 systems, see the **[Glossary](GLOSSARY.md)**.

The glossary defines 62 architectural concepts—including append-only ledgers, backpressure, copy-on-write sandboxes, data sovereignty, DEFCON 0 zero-egress containment, idempotent provisioning, optimistic concurrency control, schema-per-tenant isolation, Stocks & Flows systems dynamics, and zero-trust networking—each cross-referenced with links to the projects that implement them and the relevant job roles.

---

## By Technology

An alphabetical index of core languages, frameworks, datastores and platform tools used across the portfolio:

- **Ansible**: [07 Sovereign LXD Cluster](projects/07-sovereign-hybrid-cloud-lxd-cluster/profile.md)
- **Authentik (OIDC / SSO)**: [07 Sovereign LXD Cluster](projects/07-sovereign-hybrid-cloud-lxd-cluster/profile.md)
- **Bash / Shell Scripting**: [20 LXD Clustering Toolkit](projects/20-automated-lxd-clustering-provisioning-toolkit/profile.md)
- **BullMQ**: [03 Competition & Prize Platform](projects/03-competition-prize-gaming-platform/profile.md)
- **Caddy**: [01 Event-Sourcing Operations Hub](projects/01-event-sourcing-operations-hub/profile.md), [03 Competition & Prize Platform](projects/03-competition-prize-gaming-platform/profile.md), [05 OASIS Multi-Tenant SaaS](projects/05-schema-isolated-multi-tenant-saas/profile.md), [06 AI Sandbox Control Plane](projects/06-autonomous-ai-sandbox-control-plane/profile.md), [08 Workforce Scheduling Engine](projects/08-enterprise-workforce-scheduling-engine/profile.md)
- **Docker & Docker Compose**: [06 AI Sandbox Control Plane](projects/06-autonomous-ai-sandbox-control-plane/profile.md), [08 Workforce Scheduling Engine](projects/08-enterprise-workforce-scheduling-engine/profile.md), [09 Geospatial Stream Dashboard](projects/09-geospatial-live-stream-intelligence-dashboard/profile.md), [11 Headless Scraping Cluster](projects/11-distributed-headless-scraping-cluster/profile.md), [12 Consultancy Routing Portal](projects/12-unified-multi-tenant-consultancy-routing-portal/profile.md), [13 Livestreaming Platform](projects/13-low-latency-event-broadcast-platform/profile.md), [23 Shopify Storefront Engine](projects/23-containerized-ecommerce-design-system/profile.md), [24 ChatOps Telemetry Microservice](projects/24-automated-chatops-telemetry-microservice/profile.md), [26 Portfolio Engine](projects/26-principal-systems-engineering-portfolio/profile.md)
- **Express**: [03 Competition & Prize Platform](projects/03-competition-prize-gaming-platform/profile.md), [04 Capacity Modeling Engine](projects/04-cognitive-capacity-modeling-engine/profile.md), [12 Consultancy Routing Portal](projects/12-unified-multi-tenant-consultancy-routing-portal/profile.md), [13 Livestreaming Platform](projects/13-low-latency-event-broadcast-platform/profile.md), [17 DB Introspection Console](projects/17-dynamic-relational-db-introspection-console/profile.md), [18 Game Server RCON Orchestrator](projects/18-dedicated-game-server-rcon-orchestrator/profile.md), [21 Assisted Meal Delivery Platform](projects/21-nutritional-logistics-assisted-delivery-platform/profile.md), [22 Social Enterprise Portal](projects/22-non-profit-community-social-enterprise-portal/profile.md), [25 MEEN Full-Stack Scaffold](projects/25-monolithic-relational-fullstack-scaffold/profile.md)
- **FastAPI**: [08 Workforce Scheduling Engine](projects/08-enterprise-workforce-scheduling-engine/profile.md)
- **FFmpeg**: [09 Geospatial Stream Dashboard](projects/09-geospatial-live-stream-intelligence-dashboard/profile.md), [13 Livestreaming Platform](projects/13-low-latency-event-broadcast-platform/profile.md)
- **Gitea**: [07 Sovereign LXD Cluster](projects/07-sovereign-hybrid-cloud-lxd-cluster/profile.md), [19 Git Mirror Automation](projects/19-sovereign-git-continuous-mirror-automation/profile.md)
- **Go**: [01 Event-Sourcing Operations Hub](projects/01-event-sourcing-operations-hub/profile.md), [02 EPOS TCP Proxy Middleware](projects/02-epos-tcp-proxy-middleware/profile.md), [05 OASIS Multi-Tenant SaaS](projects/05-schema-isolated-multi-tenant-saas/profile.md), [06 AI Sandbox Control Plane](projects/06-autonomous-ai-sandbox-control-plane/profile.md), [10 Network Recon Pipeline](projects/10-high-throughput-network-recon-pipeline/profile.md), [11 Headless Scraping Cluster](projects/11-distributed-headless-scraping-cluster/profile.md)
- **Hardhat**: [14 Web3 Notary Gateway](projects/14-decentralized-notary-web3-auth-gateway/profile.md)
- **Leaflet**: [09 Geospatial Stream Dashboard](projects/09-geospatial-live-stream-intelligence-dashboard/profile.md)
- **Liquid & Shopify CLI**: [23 Shopify Storefront Engine](projects/23-containerized-ecommerce-design-system/profile.md)
- **LXD System Containers**: [01 Event-Sourcing Operations Hub](projects/01-event-sourcing-operations-hub/profile.md), [06 AI Sandbox Control Plane](projects/06-autonomous-ai-sandbox-control-plane/profile.md), [07 Sovereign LXD Cluster](projects/07-sovereign-hybrid-cloud-lxd-cluster/profile.md), [20 LXD Clustering Toolkit](projects/20-automated-lxd-clustering-provisioning-toolkit/profile.md)
- **MariaDB & MySQL**: [03 Competition & Prize Platform](projects/03-competition-prize-gaming-platform/profile.md), [04 Capacity Modeling Engine](projects/04-cognitive-capacity-modeling-engine/profile.md), [11 Headless Scraping Cluster](projects/11-distributed-headless-scraping-cluster/profile.md), [13 Livestreaming Platform](projects/13-low-latency-event-broadcast-platform/profile.md), [17 DB Introspection Console](projects/17-dynamic-relational-db-introspection-console/profile.md), [18 Game Server RCON Orchestrator](projects/18-dedicated-game-server-rcon-orchestrator/profile.md), [21 Assisted Meal Delivery Platform](projects/21-nutritional-logistics-assisted-delivery-platform/profile.md), [22 Social Enterprise Portal](projects/22-non-profit-community-social-enterprise-portal/profile.md), [25 MEEN Full-Stack Scaffold](projects/25-monolithic-relational-fullstack-scaffold/profile.md)
- **Next.js**: [14 Web3 Notary Gateway](projects/14-decentralized-notary-web3-auth-gateway/profile.md)
- **Nginx**: [07 Sovereign LXD Cluster](projects/07-sovereign-hybrid-cloud-lxd-cluster/profile.md), [11 Headless Scraping Cluster](projects/11-distributed-headless-scraping-cluster/profile.md), [12 Consultancy Routing Portal](projects/12-unified-multi-tenant-consultancy-routing-portal/profile.md)
- **Node.js**: [03 Competition & Prize Platform](projects/03-competition-prize-gaming-platform/profile.md), [04 Capacity Modeling Engine](projects/04-cognitive-capacity-modeling-engine/profile.md), [12 Consultancy Routing Portal](projects/12-unified-multi-tenant-consultancy-routing-portal/profile.md), [13 Livestreaming Platform](projects/13-low-latency-event-broadcast-platform/profile.md), [17 DB Introspection Console](projects/17-dynamic-relational-db-introspection-console/profile.md), [18 Game Server RCON Orchestrator](projects/18-dedicated-game-server-rcon-orchestrator/profile.md), [21 Assisted Meal Delivery Platform](projects/21-nutritional-logistics-assisted-delivery-platform/profile.md), [22 Social Enterprise Portal](projects/22-non-profit-community-social-enterprise-portal/profile.md), [24 ChatOps Telemetry Microservice](projects/24-automated-chatops-telemetry-microservice/profile.md), [25 MEEN Full-Stack Scaffold](projects/25-monolithic-relational-fullstack-scaffold/profile.md)
- **Nuxt 3**: [01 Event-Sourcing Operations Hub](projects/01-event-sourcing-operations-hub/profile.md), [03 Competition & Prize Platform](projects/03-competition-prize-gaming-platform/profile.md), [05 OASIS Multi-Tenant SaaS](projects/05-schema-isolated-multi-tenant-saas/profile.md), [06 AI Sandbox Control Plane](projects/06-autonomous-ai-sandbox-control-plane/profile.md), [09 Geospatial Stream Dashboard](projects/09-geospatial-live-stream-intelligence-dashboard/profile.md), [12 Consultancy Routing Portal](projects/12-unified-multi-tenant-consultancy-routing-portal/profile.md)
- **OpenBao (KMS / Secret Brokerage)**: [06 AI Sandbox Control Plane](projects/06-autonomous-ai-sandbox-control-plane/profile.md), [07 Sovereign LXD Cluster](projects/07-sovereign-hybrid-cloud-lxd-cluster/profile.md)
- **OpenTofu (IaC)**: [01 Event-Sourcing Operations Hub](projects/01-event-sourcing-operations-hub/profile.md), [06 AI Sandbox Control Plane](projects/06-autonomous-ai-sandbox-control-plane/profile.md), [07 Sovereign LXD Cluster](projects/07-sovereign-hybrid-cloud-lxd-cluster/profile.md)
- **Playwright & Headless Chrome**: [08 Workforce Scheduling Engine](projects/08-enterprise-workforce-scheduling-engine/profile.md), [11 Headless Scraping Cluster](projects/11-distributed-headless-scraping-cluster/profile.md)
- **PostgreSQL**: [05 OASIS Multi-Tenant SaaS](projects/05-schema-isolated-multi-tenant-saas/profile.md)
- **Prisma ORM**: [04 Capacity Modeling Engine](projects/04-cognitive-capacity-modeling-engine/profile.md), [14 Web3 Notary Gateway](projects/14-decentralized-notary-web3-auth-gateway/profile.md)
- **Python**: [08 Workforce Scheduling Engine](projects/08-enterprise-workforce-scheduling-engine/profile.md)
- **React 19 & React**: [08 Workforce Scheduling Engine](projects/08-enterprise-workforce-scheduling-engine/profile.md), [14 Web3 Notary Gateway](projects/14-decentralized-notary-web3-auth-gateway/profile.md)
- **Redis**: [03 Competition & Prize Platform](projects/03-competition-prize-gaming-platform/profile.md), [05 OASIS Multi-Tenant SaaS](projects/05-schema-isolated-multi-tenant-saas/profile.md)
- **Solidity & EVM**: [14 Web3 Notary Gateway](projects/14-decentralized-notary-web3-auth-gateway/profile.md)
- **SQLite**: [01 Event-Sourcing Operations Hub](projects/01-event-sourcing-operations-hub/profile.md), [08 Workforce Scheduling Engine](projects/08-enterprise-workforce-scheduling-engine/profile.md), [09 Geospatial Stream Dashboard](projects/09-geospatial-live-stream-intelligence-dashboard/profile.md)
- **Tailscale & WireGuard**: [06 AI Sandbox Control Plane](projects/06-autonomous-ai-sandbox-control-plane/profile.md), [07 Sovereign LXD Cluster](projects/07-sovereign-hybrid-cloud-lxd-cluster/profile.md), [08 Workforce Scheduling Engine](projects/08-enterprise-workforce-scheduling-engine/profile.md), [20 LXD Clustering Toolkit](projects/20-automated-lxd-clustering-provisioning-toolkit/profile.md)
- **TypeScript**: [01 Event-Sourcing Operations Hub](projects/01-event-sourcing-operations-hub/profile.md), [03 Competition & Prize Platform](projects/03-competition-prize-gaming-platform/profile.md), [14 Web3 Notary Gateway](projects/14-decentralized-notary-web3-auth-gateway/profile.md), [16 Expression Complexity Engine](projects/16-algorithmic-expression-complexity-engine/profile.md)
- **Vue 3**: [01 Event-Sourcing Operations Hub](projects/01-event-sourcing-operations-hub/profile.md), [03 Competition & Prize Platform](projects/03-competition-prize-gaming-platform/profile.md), [05 OASIS Multi-Tenant SaaS](projects/05-schema-isolated-multi-tenant-saas/profile.md), [06 AI Sandbox Control Plane](projects/06-autonomous-ai-sandbox-control-plane/profile.md), [09 Geospatial Stream Dashboard](projects/09-geospatial-live-stream-intelligence-dashboard/profile.md), [12 Consultancy Routing Portal](projects/12-unified-multi-tenant-consultancy-routing-portal/profile.md), [15 Web Audio Synthesizer](projects/15-web-audio-dsp-modular-synthesizer/profile.md), [16 Expression Complexity Engine](projects/16-algorithmic-expression-complexity-engine/profile.md)
- **Web Audio API**: [15 Web Audio Synthesizer](projects/15-web-audio-dsp-modular-synthesizer/profile.md)
- **ZFS (CoW)**: [06 AI Sandbox Control Plane](projects/06-autonomous-ai-sandbox-control-plane/profile.md), [20 LXD Clustering Toolkit](projects/20-automated-lxd-clustering-provisioning-toolkit/profile.md)

---

## By Sector

Where projects address specific industry, municipal, or operational domains:

### E-Commerce
- [03 Competition & Prize Platform](projects/03-competition-prize-gaming-platform/profile.md): High-throughput flash competition sales, inventory locking and transactional ticket settlement.
- [23 Shopify Storefront Engine](projects/23-containerized-ecommerce-design-system/profile.md): Containerized Shopify theme toolchain, modular Liquid design system and hot-reloading preview environment.

### Gaming & Simulation
- [03 Competition & Prize Platform](projects/03-competition-prize-gaming-platform/profile.md): Verifiable PRNG draw mechanics, regulatory audit trails and anti-collision ticket allocation.
- [18 Game Server RCON Orchestrator](projects/18-dedicated-game-server-rcon-orchestrator/profile.md): Dedicated multiplayer game server telemetry probing and air-gapped TCP RCON command bridging.

### Hospitality
- [02 EPOS TCP Proxy Middleware](projects/02-epos-tcp-proxy-middleware/profile.md): Intercepting multi-till ESC/POS print streams for in-memory rasterization, OCR and dynamic bundle repricing without modifying POS firmware.
- [08 Workforce Scheduling Engine](projects/08-enterprise-workforce-scheduling-engine/profile.md): Shift scheduling, 15-minute overnight integer time grid, optimistic concurrency conflict guards and PDF generation for high-turnover hospitality environments.

### Media, Audio & Streaming
- [09 Geospatial Stream Dashboard](projects/09-geospatial-live-stream-intelligence-dashboard/profile.md): Real-time video surveillance telemetry, Leaflet GIS mapping and embedded FFmpeg live HLS snapshot extraction.
- [10 Network Recon Pipeline](projects/10-high-throughput-network-recon-pipeline/profile.md): High-throughput network surveying, CIDR decomposition and mass RTSP media stream verification.
- [13 Livestreaming Platform](projects/13-low-latency-event-broadcast-platform/profile.md): Low-latency live event broadcasting, RTMP/HLS transcoding, rolling chunk caches and edge fan-out delivery.
- [15 Web Audio Synthesizer](projects/15-web-audio-dsp-modular-synthesizer/profile.md): In-browser digital signal processing, interactive node-graph audio routing and polyphonic voice allocation.

### Non-Profit & Social Enterprise
- [21 Assisted Meal Delivery Platform](projects/21-nutritional-logistics-assisted-delivery-platform/profile.md): Nutritional logistics, rotating dietary matrix validation and municipal delivery routing for vulnerable citizens.
- [22 Social Enterprise Portal](projects/22-non-profit-community-social-enterprise-portal/profile.md): Community Interest Company (CIC) grant-funded outcome tracking, food distribution ledgering and supported internship management.

### Public Sector & Social Care
- [04 Capacity Modeling Engine](projects/04-cognitive-capacity-modeling-engine/profile.md): Psychometric telemetry, hierarchical reporting graphs and cognitive overload mitigation for clinical supervisors and organizational leadership.
- [21 Assisted Meal Delivery Platform](projects/21-nutritional-logistics-assisted-delivery-platform/profile.md): Statutory social care compliance, safeguarding audit trails and allergen-safe delivery workflows for mobility-impaired residents.
- [22 Social Enterprise Portal](projects/22-non-profit-community-social-enterprise-portal/profile.md): Statutory CIC reporting against local authority and charitable grant allocations with auditable community outcome metrics.
