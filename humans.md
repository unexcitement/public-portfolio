# humans.md

/* 
 * Sovereign Systems Engineering & Human-in-the-Loop Architecture.
 * This repository documents an engineering philosophy rooted in first-principles data sovereignty, 
 * resilient systems dynamics, and verifiable defense-in-depth.
 */

## /* THE ARCHITECT */
**Name:** Cameron Elliott  
**Role:** Founder, Principal Systems Architect & Cross-Discipline Systems Engineer  
**Location:** North East, UK  
**Cognitive Architecture:** AuDHD (A bottom-up cognitive processing style favoring structured decomposition, rapid pattern recognition, and systematic rigor)  
**Methodology:** Applied Systems Theory (Donella Meadows' dynamics) augmented by deterministic AI orchestration  
**Collaboration & Inquiries:** Open to high-leverage architectural advisory, technical leadership, and sovereign systems design. Reachable via asynchronous communication and verified channels.

## /* THE COGNITIVE AUGMENTATION FRAMEWORK */
*Rather than ad-hoc prompting, we codify decision heuristics into structured, machine-executable YAML schemas. Automated agents act as specialized advisors, ensuring every operational decision aligns with architectural integrity, strategic focus, and disciplined execution.*

**Name:** Ethics Advisor (`ethics-advisor.yaml`)  
**Focus:** Integrity & Principles. Ensures engineering choices adhere to uncompromising quality, honesty, and sustainable long-term standards over short-term appeasement.

**Name:** Goals Advisor (`goals-advisor.yaml`)  
**Focus:** Strategic Capital & Leverage. Aligns engineering workflows with high-leverage business objectives, resilient value creation, and generational asset building.

**Name:** Scope-Guard Advisor (`scope-creep-advisor.yaml`)  
**Focus:** Architectural Discipline. Systematically evaluates feature requests against core requirements, eliminating unneeded complexity and preserving developer velocity.

## /* CORE PRINCIPLES & SYSTEMIC PHILOSOPHY */

### 1. Data Sovereignty by Architecture, Not Policy
True data sovereignty cannot depend solely on third-party policy agreements; it must be guaranteed by system architecture. Where sensitive intelligence and proprietary models are concerned, we enforce physical and kernel-level isolation. Workloads run inside unprivileged, isolated system containers with network egress explicitly gated or physically severed, ensuring organizational intellectual property remains strictly sovereign.

### 2. Capital Efficiency & Self-Sustaining Infrastructure
We leverage open-source foundations to build resilient, cost-effective computational pipelines. By treating foundational tools (vLLM, Ollama, containerized engines) as integrated Stocks and Flows, we design resource cascades where system outputs cleanly feed downstream processes. Prioritizing dedicated local compute and private hosting preserves margins, minimizes recurring OpEx, and keeps critical capabilities in-house.

### 3. Verification-First Release Engineering (Human-in-the-Loop)
Deployment pipelines are critical boundaries between development intent and production reality. We prioritize deterministic validation over hasty automation. Autonomous agents are empowered to propose changes and draft solutions, but production mutations require structured telemetry debriefs and explicit Human-in-the-Loop (HITL) validation, ensuring stability and operational accountability.

### 4. Defense-in-Depth & Assume-Breach Security
Modern security requires moving beyond perimeter checklists to assume-breach engineering. We implement defense-in-depth across every tier: compartmentalizing workloads through kernel privilege separation, domain-scoped RBAC, zero-trust network namespaces, and immutable audit logging. Systems are engineered so that the compromise of any single component cannot cascade into wider operational failure.

### 5. Neurodiversity as Systems Insight
Neurodivergent processing (AuDHD) serves as cognitive middleware. By intuitively perceiving complex environments as interconnected Donella Meadows dynamics—Stocks, Flows, and Balancing/Reinforcing Feedback Loops—we systematically identify root causes rather than symptoms. We engineer environments that absorb operational friction, dampen context switching, and translate non-linear insights into clear, deterministic architecture.

## /* TECHNICAL FOUNDATIONS */
*   **Virtualization & Isolation:** OpenTofu, LXC/LXD, Docker, Kernel Namespaces, Network Egress Rules
*   **Storage & Resilience:** ZFS (NVMe pools), Restic, Rclone, Tailscale Mesh (Multi-Tier Deduplicated Backups)
*   **High-Throughput Middleware:** Go (Golang) Non-Blocking TCP & Event Proxies
*   **Presentation & Command Surfaces:** Nuxt 3, Vue 3, Server-Sent Events (SSE), SQLite WAL Event Ledgers, Zod Runtime Contracts
*   **Dedicated Local Compute:** Hardware GPU Passthrough, vLLM, Ollama, Local Inference Engines

---
*"If you don't map your systems, your systems will map you."* — Donella Meadows