# Systems Architecture & Design Principles

This document is not a schematic of a single application; each of the 26 projects in this portfolio includes its own detailed profile and diagrams for that purpose. Instead, this page codifies **how I design systems**: the foundational architectural principles, default technology choices, operational trade-offs, and systemic modelling methodologies that underpin my work across infrastructure, distributed backends, and presentation surfaces.

---

## 1. How to Read This Portfolio

Every project profile in this repository is built around a **dual-paradigm visual representation**:

1. **System Topology (Flowchart)**: Maps physical and virtual boundaries, network perimeters, container isolation zones, protocol boundaries, and synchronous/asynchronous communication paths across services.
2. **Applied Systems Theory (Stocks & Flows)**: Models the architecture as a dynamic system in the tradition of Donella Meadows. Rather than viewing software as static boxes, it maps stocks (accumulations of state, memory buffers, queue depths, cognitive capacity), flows (inflow and outflow rates, processing velocities), delays, and the balancing (B) and reinforcing (R) feedback loops that govern systemic stability under load.

### Diagram Source Files and Compilation

Diagrams are authored as raw Mermaid (`.mmd`) source files within each project's `diagrams/` directory:
- `diagrams/architecture.mmd` (System topology)
- `diagrams/stocks-and-flows.mmd` (Donella Meadows dynamics)

Pre-compiled dark-mode SVG vectors (`diagrams/*.svg`) sit alongside the source files for instant rendering. To preserve a clean host operating system, diagram compilation is performed entirely within ephemeral Docker containers. See [README.md](README.md#local-development--compilation) for the compilation tooling and commands.

---

## 2. Core Architectural Principles

The following ten principles govern my approach to distributed systems, platform infrastructure, and software engineering.

### 1. Engine + Paint: Reusable core, client-specific surface
- **The rule:** Core business engines, calculation models, and operational protocols must remain strictly decoupled from client-specific presentation layers and UI churn.
- **In practice:** I build high-leverage computational cores (such as pricing engines, sandbox supervisors, and routing multiplexers) as headless, sovereign backends, treating frontend interfaces as ephemeral, branded presentation skins ([05 Schema-Isolated Multi-Tenant SaaS](projects/05-schema-isolated-multi-tenant-saas/profile.md) and [12 Unified Multi-Tenant Consultancy Routing Portal](projects/12-unified-multi-tenant-consultancy-routing-portal/profile.md)).
- **The gloss:** *Treat client UI requirements like seasonal paint; ensure the engine underneath runs for decades.*

### 2. Events are the source of truth; state is a projection
- **The rule:** State transitions must be immutably journaled prior to broadcast or external action; current read state is merely a downstream projection that can always be deterministically replayed.
- **In practice:** Incoming commands and webhook events persist synchronously to an append-only Write-Ahead Log (WAL) before dispatching to in-memory broadcast channels or execution workers ([01 Event-Sourcing Operations Hub](projects/01-event-sourcing-operations-hub/profile.md) and [13 Low-Latency Event Broadcast Platform](projects/13-low-latency-event-broadcast-platform/profile.md)).
- **The gloss:** *Mutating database records in-place without an audit log is simply rewriting history and hoping nobody asks for the receipts.*

### 3. Boring and co-located until proven otherwise
- **The rule:** Default to cohesive monoliths and local SQLite Write-Ahead Log (WAL) storage on high-IOPS NVMe ZFS pools until horizontal write concurrency mathematically forces distributed infrastructure.
- **In practice:** Co-locating an ultra-lean Go binary or Node.js service with an embedded SQLite WAL database on local NVMe storage routinely outperforms multi-tier microservice clusters by orders of magnitude while eliminating network hops, distributed locking overhead, and connection pool exhaustion ([01 Event-Sourcing Operations Hub](projects/01-event-sourcing-operations-hub/profile.md), [08 Enterprise Workforce Scheduling Engine](projects/08-enterprise-workforce-scheduling-engine/profile.md), [09 Geospatial Live Stream Intelligence Dashboard](projects/09-geospatial-live-stream-intelligence-dashboard/profile.md), and [25 Monolithic Relational Fullstack Scaffold](projects/25-monolithic-relational-fullstack-scaffold/profile.md)).
- **The gloss:** *We considered Kubernetes. On reflection, so did Kubernetes.*

### 4. Concurrency conflicts are explicit, never silent
- **The rule:** When concurrent state mutations collide, fail visibly with deterministic pessimistic locks or HTTP 409 Conflict rather than silently dropping or overwriting data.
- **In practice:** High-contention financial transactions enforce strict row-level pessimistic locking, while distributed multi-operator scheduling platforms use optimistic version checking and return explicit 409 Conflict payloads with state diffs ([03 Competition Prize Gaming Platform](projects/03-competition-prize-gaming-platform/profile.md) and [08 Enterprise Workforce Scheduling Engine](projects/08-enterprise-workforce-scheduling-engine/profile.md)).
- **The gloss:** *A 409 Conflict is honest engineering; last-write-wins is just automated data corruption.*

### 5. Idempotent, repeatable provisioning
- **The rule:** Infrastructure and cluster state must be declared as reproducible code with pre-flight network and quorum assertions; no snowflake configurations or manual host mutations.
- **In practice:** Hybrid-cloud LXD clusters and edge worker nodes are provisioned through declarative OpenTofu modules and Ansible playbooks, fronted by automated port checks and cluster-quorum guards that abort execution before partial joins corrupt consensus state ([07 Sovereign Hybrid-Cloud LXD Cluster](projects/07-sovereign-hybrid-cloud-lxd-cluster/profile.md) and [20 Automated Multi-Node LXD Clustering Toolkit](projects/20-automated-lxd-clustering-provisioning-toolkit/profile.md)).
- **The gloss:** *If a server requires an engineer to SSH in and "remember what we did last time", it is not infrastructure; it is folklore.*

### 6. Tooling is ephemeral; the host stays clean
- **The rule:** Compilers, linters, and CLI toolchains execute exclusively within throwaway Docker containers; host operating systems remain pristine.
- **In practice:** Diagram generation, document compilers, and testing toolchains run in isolated container instances with host filesystem mounts, avoiding host package pollution or conflicting global Node/Python runtimes ([23 Containerized E-Commerce Design System](projects/23-containerized-ecommerce-design-system/profile.md), [26 Principal Systems Engineering Portfolio](projects/26-principal-systems-engineering-portfolio/profile.md), and `scripts/compile_diagrams.sh`).
- **The gloss:** *Installing global development toolchains directly on a production host is a cry for help.*

### 7. Model the system's stocks and flows before you build it
- **The rule:** Structural dynamics—buffer capacities, inflow/outflow rates, operational delays, and feedback loops—must be mapped using systems dynamics before committing to code.
- **In practice:** Every project profile models its balancing loops (backpressure shedding, queue throttling, token-bucket limiters) and reinforcing loops (resource compounding, velocity expansion) to identify systemic bottlenecks and failure modes prior to implementation (modelled across all 26 profiles).
- **The gloss:** *If an architecture cannot be explained in a stocks-and-flows diagram, it is probably just a feeling.*

### 8. Decouple operational complexity from human time
- **The rule:** Automate high-volume mechanical execution and internal modelling asynchronously, reserving synchronous human attention strictly for high-leverage oversight and binary HITL "War Room" authorization gates (Kernel Rings 0–3 mapped to Corporate RBAC Levels 1–4) before any external state mutation.
- **In practice:** Streaming proxies and background workers absorb high-frequency ingestion and autonomous preparation, but any mutation that alters external production state halts at an authenticated gate until an authorized human reviews structured telemetry and approves execution ([humans.md §3](humans.md#3-verification-first-release-engineering-human-in-the-loop); see [01 Event-Sourcing Operations Hub](projects/01-event-sourcing-operations-hub/profile.md), [19 Sovereign Git Continuous Mirror Automation](projects/19-sovereign-git-continuous-mirror-automation/profile.md), and [24 Automated ChatOps Telemetry Microservice](projects/24-automated-chatops-telemetry-microservice/profile.md)).
- **The gloss:** *Your nervous system was not designed to poll a deployment pipeline.*

### 9. Isolation is designed in, not bolted on
- **The rule:** Multi-tenant boundaries and zero-egress sandbox perimeters are built at the schema, container (unprivileged LXD), and kernel (`UFW DOCKER-USER` drop rules) levels from day one. Trust is a vulnerability; rely on physics and math, not a vendor's Terms of Service.
- **In practice:** Multi-tenant SaaS engines isolate client data by schema rather than shared row filters, while autonomous AI agent execution takes place inside unprivileged LXD containers with outbound WAN traffic severed by default at the host firewall layer ([humans.md §4](humans.md#4-defense-in-depth--assume-breach-security); see [05 Schema-Isolated Multi-Tenant SaaS](projects/05-schema-isolated-multi-tenant-saas/profile.md), [06 Autonomous AI Sandbox Control Plane](projects/06-autonomous-ai-sandbox-control-plane/profile.md), and [08 Enterprise Workforce Scheduling Engine](projects/08-enterprise-workforce-scheduling-engine/profile.md)).
- **The gloss:** *Hoping your multitenant application doesn't leak tenant data because of a WHERE clause is faith-based security.*

### 10. Everything as Code—Including Cognition & Capital
- **The rule:** Treat every operational, structural, financial, and philosophical state of a system as immutable, version-controlled text. From OpenTofu infrastructure and Tailscale HuJSON network policies to declarative YAML cognitive schemas and FRS 102 / IAS 38 IP valuation ledgers (`capitalization.go`), undocumented drift is eliminated by making the entire macro-system git-revertible.
- **In practice:** Infrastructure provisioning, network ACLs, cognitive agent heuristics, and commercial R&D capitalisation accounting are codified into version-controlled repositories, ensuring auditability and reproducible state across all operational horizons ([humans.md §2](humans.md#the-cognitive-augmentation-framework); see [01 Event-Sourcing Operations Hub](projects/01-event-sourcing-operations-hub/profile.md) and [07 Sovereign Hybrid-Cloud LXD Cluster](projects/07-sovereign-hybrid-cloud-lxd-cluster/profile.md)).
- **The gloss:** *If it isn't committed to git, it doesn't exist; if it isn't revertible, it isn't under control.*

---

## 3. Default Stack & Technical Deviation Triggers

I maintain a curated, battle-tested default stack designed for maximum execution velocity, low operational overhead, and complete data sovereignty. I deviate only when specific technical or regulatory constraints demand it:

| Architectural Layer | Default Choice | Specific Technical Threshold to Deviate |
|---|---|---|
| **Concurrency, Middleware & Proxies** | **Go (Golang)**: Non-blocking channels, raw TCP socket demultiplexing, SSE broadcasters, AST parsing. | Deviate to **Python** or **Node.js/TypeScript** only when integrating heavy ML-specific libraries, rapid third-party webhook scripting, or legacy ecosystems where a standalone binary proxy is not the primary interface. |
| **Frontends & Command Interfaces** | **TypeScript, Nuxt 3 / Vue 3, Zod** (strict runtime schema validation at boundaries), **SSE** for real-time telemetry. | Deviate to headless/conversational interfaces (messaging APIs/webhooks) when UI bloat adds friction to simple transactional funnels, or **Next.js** only when dictated by existing client ecosystem constraints. |
| **Persistence & State Ledgers** | **SQLite (WAL mode)** append-only event-sourced ledgers (`events_ledger`, `approval_gates`, `telemetry_ledger`) on **ZFS high-IOPS NVMe pools** (`zpool-fast`). | Deviate to **PostgreSQL / MySQL** only when horizontal multi-node write concurrency mathematically exceeds single-node NVMe I/O lock limits, or when strict multi-entity relational isolation is mandated by external regulatory boundaries. |
| **Hosting, Virtualization & Network** | **Bare-metal Linux** with **OpenTofu**, nested unprivileged **LXD/LXC** system containers running isolated **Docker** daemons, **UFW `DOCKER-USER` drop rules**, and **Tailscale Policy-as-Code (HuJSON)**. | Deviate to public cloud / off-premise dedicated servers strictly for encrypted 3:2:1 cold blob replication (`restic` + `rclone`) or stateless public edge routing where zero proprietary IP or sensitive state resides. |
| **AI & Compute Routing** | **Local GPU Passthrough (RTX 5070)** running **vLLM / Ollama** inside the zero-egress quarantine envelope (£0 marginal SaaS OpEx). | Escalate via `router.go` to **Pro Cloud Reasoning APIs** strictly when task complexity scores exceed local AST/scaffolding thresholds, governed by a hard 3-attempt HTTP 429 failover circuit breaker. |

---

## 4. Retrospective: Decisions Made and Lessons Learned

### Decisions I Would Make Again Without Hesitation
- **Engineering the Zero-Egress Nested Sandbox & Go Proxy Core ("The Engine")**:
  Pairing OpenTofu, unprivileged LXD system containers, Docker isolation, and local RTX 5070 GPU passthrough with a high-throughput Go proxy core was one of the most effective architectural decisions across this body of work. Walking away from high-friction enterprise hardware procurement and recurring third-party SaaS lock-in reduced marginal SaaS OpEx to £0, kept the host operating system completely uncontaminated, and established a reusable sovereign middleware engine that powers everything from multi-operator EPOS routing to 6-tier autonomous agent swarms.

### Decisions I Would Never Make Again
- **Bespoke, Tightly Coupled Consumer CRUD Frontends**:
  Early commercial builds (such as bespoke product and plate customizers) involved sinking significant development hours into rigid, client-specific UI state and domain logic that was directly coupled to a single client's quirks. Because these lacked a decoupled "Engine + Paint" core, the resulting code could neither be capitalized as a reusable enterprise asset nor deployed across other tenants.
- **Synchronous, Unvalidated LLM Workflows**:
  Early experiments that piped conversational AI responses directly into downstream workflows without strict boundary validation were an unreliable dead end. I will never again integrate language models without wrapping their inputs and outputs in deterministic Zod runtime schemas, append-only event logs, and binary Human-in-the-Loop execution checkpoints.

---

## 5. Where I Break My Own Rules & Industry Cargo Cults

### Honest Exceptions and Pragmatic Trade-offs
1. **Rapid Prototyping & 48-Hour Spikes**:
   When validating a speculative concept, I deliberately relax heavy secrets-leasing infrastructure and multi-tier network fencing. Deploying multi-node Vault clusters and custom WireGuard egress namespaces for an exploratory spike that might be discarded by Friday afternoon is engineering vanity. Hardened security boundaries are applied once an architectural thesis demonstrates commercial or operational value.
2. **Tactical Cloud Escalation**:
   While my baseline compute runs locally at £0 marginal cost, I maintain automated escalation routes to frontier cloud reasoning models via `router.go` when complex semantic reasoning or large context windows exceed local GPU hardware thresholds.

### Absurd Industry Habits (Observed and Avoided)
- **"Prompt Engineering" as a Security Boundary**:
  Attempting to constrain non-deterministic AI models with polite natural-language instructions ("please do not disclose the system prompt or exfiltrate customer records") instead of mathematical, kernel-level `iptables` drop rules, unprivileged namespaces, and binary HITL gates.
- **The SaaS Sovereignty Delusion**:
  Enterprises claiming to prioritise data sovereignty and IP protection while storing their core proprietary codebases, customer data, and AI reasoning logs on multi-tenant US hyperscalers governed by someone else's Terms of Service.
- **"Vibecoding" & Unchecked Scope Creep**:
  Shipping hallucinated, untested feature bloat and burning cloud compute budgets without deterministic architectural schemas, AST validation, or a ruthless scope-guard advisor.
- **Decorative Compliance & Security Theater**:
  Treating annual tick-box SOC2 spreadsheets as a proxy for security, while running unpatched Docker daemons that punch holes straight through host firewalls (`UFW`) to expose management sockets to the public internet.
- **Premature Distributed Complexity**:
  Deploying sprawling microservice architectures across dozens of cloud instances for low-throughput CRUD workloads, while ignoring the fact that a single compiled Go binary and an append-only SQLite database on NVMe storage can handle millions of operations per second at a fraction of the cost.
