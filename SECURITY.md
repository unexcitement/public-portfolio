# Security & Disclosure Policy

In a running software product, a security policy explains how to report an exploitable vulnerability. In a portfolio constructed from sanitized commercial and enterprise systems, security governs two distinct areas: the architectural security principles I use to design resilient systems, and the redaction policy that protects commercial confidentiality, intellectual property, and client privacy.

---

## 1. Core Security Principles

The following principles reflect how I approach defense-in-depth, boundary enforcement, and threat mitigation across physical, virtual, and application tiers.

### 1. Sovereignty by architecture, not policy
- **The rule:** Data sovereignty and intellectual property protection cannot rely on third-party policy agreements; they must be guaranteed by system architecture.
- **In practice:** Where sensitive intelligence, client data, or proprietary models are concerned, workloads run within kernel-isolated, unprivileged containers with network egress strictly controlled or severed entirely ([humans.md §1](humans.md#1-data-sovereignty-by-architecture-not-policy); see [06 AI Sandbox Control Plane](projects/06-autonomous-ai-sandbox-control-plane/profile.md) and [07 Sovereign Hybrid-Cloud LXD Cluster](projects/07-sovereign-hybrid-cloud-lxd-cluster/profile.md)).
- **The gloss:** *A vendor's privacy policy is an aspiration; a severed egress route is a fact.*

### 2. Assume breach and contain the blast radius
- **The rule:** Systems must be designed so that the catastrophic compromise of any single component or tenant cannot cascade across tenants or hosts.
- **In practice:** Multi-tenant databases isolate tenant data by schema rather than shared row flags, and untrusted execution environments enforce kernel privilege separation and cgroup limits ([humans.md §4](humans.md#4-defense-in-depth--assume-breach-security); see [05 Schema-Isolated Multi-Tenant SaaS](projects/05-schema-isolated-multi-tenant-saas/profile.md) and [06 AI Sandbox Control Plane](projects/06-autonomous-ai-sandbox-control-plane/profile.md)).
- **The gloss:** *Security through optimism is not a control.*

### 3. Egress is a privilege, not a default
- **The rule:** Execution sandboxes and worker workloads must have outbound WAN traffic dropped at the kernel layer unless routed through explicit, audited egress gateways.
- **In practice:** Host-level firewall rules drop outbound traffic by default (DEFCON 0), while approved external API calls are routed through dedicated, isolated network namespaces running WireGuard or Tailscale tunnels (see [06 AI Sandbox Control Plane](projects/06-autonomous-ai-sandbox-control-plane/profile.md) and [07 Sovereign Hybrid-Cloud LXD Cluster](projects/07-sovereign-hybrid-cloud-lxd-cluster/profile.md)).
- **The gloss:** *If an autonomous agent has no business phoning home to the internet, make it physically incapable of dialing.*

### 4. Secrets live in a secrets manager, never in config or URLs
- **The rule:** Credentials, private keys, and tokens must be dynamically injected as short-lived leases and never committed to version control, static configuration files, or command arguments.
- **In practice:** Centralized secret brokers inject dynamic leases directly into runtime memory without writing persistent plaintext keys to disk or environment variables (see [06 AI Sandbox Control Plane](projects/06-autonomous-ai-sandbox-control-plane/profile.md) and [07 Sovereign Hybrid-Cloud LXD Cluster](projects/07-sovereign-hybrid-cloud-lxd-cluster/profile.md)).
- **The gloss:** *The only thing harder to rotate than a hardcoded credential is an apology.*

### 5. Humans approve production mutations
- **The rule:** Autonomous systems and streaming ingestion pipelines may process high-volume operational telemetry and propose actions, but irreversible state mutations require deterministic Human-in-the-Loop consensus.
- **In practice:** Critical execution paths pause at an authenticated approval gateway (War Room) where operators must explicitly validate changes before execution workers spawn ([humans.md §3](humans.md#3-verification-first-release-engineering-human-in-the-loop); see [01 Event-Sourcing Operations Hub](projects/01-event-sourcing-operations-hub/profile.md)).
- **The gloss:** *Automation is great for multiplying velocity; manual verification is great for not multiplying catastrophe.*

### 6. Append-only audit trails
- **The rule:** System events and state transitions must be immutably journaled prior to broadcast or execution so that forensic state is never rewritable.
- **In practice:** Incoming commands persist synchronously to an append-only Write-Ahead Log (WAL) before downstream processing, financial ledgers record immutable double-entry adjustments, and operational events retain unbroken historical sequences (see [01 Event-Sourcing Operations Hub](projects/01-event-sourcing-operations-hub/profile.md), [03 Competition Prize Gaming Platform](projects/03-competition-prize-gaming-platform/profile.md), and [22 Non-Profit Community Social Enterprise Portal](projects/22-non-profit-community-social-enterprise-portal/profile.md)).
- **The gloss:** *You cannot negotiate with a Write-Ahead Log after the event.*

### 7. Admin ports never face the internet
- **The rule:** Raw administrative protocols and hardware management sockets must never be directly exposed to public interfaces.
- **In practice:** Remote console and hardware protocols (such as game server RCON or thermal printer TCP sockets) are wrapped behind authenticated, rate-limited HTTP proxies and edge gateways (see [02 EPOS TCP Proxy Middleware](projects/02-epos-tcp-proxy-middleware/profile.md) and [18 Dedicated Game Server RCON Orchestrator](projects/18-dedicated-game-server-rcon-orchestrator/profile.md)).
- **The gloss:** *Shodan finds exposed administration sockets faster than your monitoring alerts you to them.*

### 8. Identity at the edge, before the app
- **The rule:** Unauthenticated traffic must be challenged and validated at edge ingress before reaching downstream application logic or internal container interfaces.
- **In practice:** Ingress proxies enforce forward authentication against an OpenID Connect (OIDC) identity provider, shedding unauthenticated connections before application middleware consumes compute resources (see [07 Sovereign Hybrid-Cloud LXD Cluster](projects/07-sovereign-hybrid-cloud-lxd-cluster/profile.md)).
- **The gloss:** *An application framework's auth middleware should not be the frontline perimeter defense against the open internet.*

### 9. Redact before you publish
- **The rule:** Architectural blueprints and technical documentation must pass through deterministic hazard filtering before publication, stripping operational topology while preserving conceptual depth.
- **In practice:** Sanitization pipelines replace commercial client names, private IP addressing, and internal hostnames with descriptive system roles prior to committing to public repositories (see [26 Principal Systems Engineering Portfolio](projects/26-principal-systems-engineering-portfolio/profile.md)).
- **The gloss:** *Explaining how a drawbridge was engineered does not require handing out the combination to the castle gate.*

---

## 2. Abridged Threat Model

I design architectures around realistic operational failure modes and boundary violations rather than compliance checklists.

### In Scope
- **Accidental secret disclosure:** Preventing API tokens, SSH keys, or connection strings from leaking through debug outputs, logs, or source commits.
- **Uncontained agent execution:** Preventing untrusted autonomous models or third-party scripts from escaping container namespaces or pivoting into internal host networks.
- **Supply chain and dependency poisoning:** Containing untrusted library execution within throwaway unprivileged sandboxes with severed egress.
- **Cascading operational failures:** Isolating failure domains so an outage or exploit in a single service cannot take down clustered peers or compromise other tenants.
- **Unauthenticated edge ingress:** Dropping port scanners, credential stuffing, and unauthenticated traffic at the edge proxy layer.

### Out of Scope (Satirical but Defensible)
- **Nation states with an urgent strategic interest in my community rota software:** If a tier-one intelligence agency is deploying directed zero-days against a non-profit volunteer portal, the problem has escalated beyond system architecture.
- **Acoustic cryptanalysis against local thermal printers:** The EPOS proxy defends against TCP buffer overflows and print floods, not laser microphones pointed at receipt paper rolls.
- **Rogue container escapes against ephemeral sandboxes that self-destruct in 90 seconds:** Escaping an unprivileged container into an ephemeral ZFS volume with no egress is an impressive feat, but the volume is unmounted and demolished before anything can be exfiltrated.

---

## 3. Where I Break My Own Rules

Dogmatism in security leads to paralyzed engineering. In practice, I knowingly accept deliberate trade-offs:

1. **Rapid prototyping and exploratory spikes:** When proving out a speculative architectural concept, I trade granular KMS secret leasing and rigid multi-layer network fencing for development velocity. Setting up multi-node Vault clusters and custom egress namespaces for an experiment that might be deleted within 48 hours is premature optimization. Security boundaries are hardened once an architecture proves viable.
2. **Single-node SQLite over premature distributed clusters:** For moderate-throughput internal services, a single-node SQLite database running in WAL mode with local automated backups is vastly simpler, faster, and more reliable than a multi-node distributed database cluster. Distributed consensus brings operational surface area; I introduce distributed databases only when write contention demands it.
3. **Anecdotes and case histories:** `✍️ To fill in: case studies from content pipeline`

---

## 4. Redaction Policy

Every profile in this portfolio passes through **Hazard Filtering** (see [project 26](projects/26-principal-systems-engineering-portfolio/profile.md)) before publication. The intent is that this repository never contains:

- Client, employer, or partner names, brands, or trademarks, unless the work is my own.
- Proprietary commercial source code, algorithms, or private business logic.
- Credentials, private keys, API tokens, or production connection strings.
- Public IP addresses, public domain names, or identifiers resolving to live commercial systems.
- Personal data about end users, staff, beneficiaries, or individuals.

### What is intentionally kept

To ensure technical and architectural clarity, profiles deliberately show:

- Descriptive system roles and generic component identifiers (for example `primary-host`, `edge-mini`, or `ingress-proxy`).
- Open-source software and public infrastructure tools used as building blocks.
- Standard protocols and well-known default ports (such as 3000, 8080, 8443, and 9100).
- Generalised network topologies (such as private `/24` subnets and isolated bridge interfaces).

---

## 5. Reporting a Suspected Disclosure

If you believe any content in this repository identifies a confidential client, exposes a live system, or includes information that should remain private:

1. **Do not** open a public issue or pull request that quotes or repeats the sensitive material.
2. Contact me privately at `✍️ To fill in` (verified asynchronous channels).
3. Specify the exact file path and line number, along with a brief explanation of why the item is sensitive.

I aim to acknowledge reports within `✍️ To fill in` and will promptly sanitize confirmed disclosures, including rewriting repository history where necessary.

---

## 6. Scope

This policy covers the contents of this repository (`unexcitement/public-portfolio`). Tooling and helper scripts located under `scripts/` are intended solely for building and compiling portfolio assets and are not designed to execute against external environments.
