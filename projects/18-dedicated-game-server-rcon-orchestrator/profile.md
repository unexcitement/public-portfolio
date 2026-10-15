# Dedicated Game Server RCON Orchestrator & Telemetry Gateway

## Executive Summary
This server telemetry and remote administration gateway enables web operators to monitor and orchestrate dedicated multiplayer game servers without exposing raw management ports. Built with Node.js, Express, and MariaDB, the platform pairs asynchronous UDP query probing (GameDig) with an authenticated TCP Remote Console (RCON) protocol bridge. By proxying administrative commands and status metrics through an authenticated web interface, it protects physical game host sockets from port scanning, brute-force attacks, and unauthenticated packet flooding.

## Core Architectural Paradigms
- **Air-Gapped RCON Protocol Bridging**: Intercepts web-based operator commands and converts them to authenticated TCP RCON socket packets, keeping game server management interfaces off public internet interfaces.
- **Asynchronous Game Protocol Telemetry**: Polls server heartbeats, player rosters, and round latency using native UDP query protocols without imposing measurable CPU overhead on the target game engine.
- **Audited Administrative Command Ledger**: Persists all dispatched operator commands, server responses, and timestamped actions to MariaDB to ensure administrative accountability.
- **Hardened Web Control Surface**: Protects web endpoints with bcrypt password hashing, sliding session management, and strict input validation rules.

## Systems Architecture Diagram

```mermaid
flowchart TB
    subgraph ClientPerimeter["Community & Admin Web Perimeter"]
        GameAdmin["Server Administrator / Community Lead"]
        WebDashboard["Web Portal & RCON Command Center (EJS / Bootstrap)"]
    end

    subgraph OrchestratorGateway["Node.js Application Tier (:3000)"]
        ExpressCore["Express Server & Session Controller"]
        AuthValidator["bcrypt + Session Validator"]
        
        subgraph ProtocolBridges["Dedicated Protocol Bridges"]
            RCONBridge["TCP RCON Socket Bridge\n(project-zomboid-rcon / rcon)"]
            GameDigProber["UDP GameDig Telemetry Prober\n(Server Status, Latency, Player Roster)"]
        end

        subgraph LocalStore["Persistence Layer"]
            MariaDB[("MariaDB Datastore\n(Users, Command Audit Logs, Server Configs)")]
        end
    end

    subgraph GameServerHost["Dedicated Game Server Host (Isolated LAN / WAN)"]
        DedicatedGame["Dedicated Game Server Engine (Project Zomboid / Source Engine)"]
        RCONSocket["Internal TCP RCON Port (e.g., :27015)"]
        QuerySocket["UDP Query Port (e.g., :16261)"]
    end

    GameAdmin --> WebDashboard
    WebDashboard --> ExpressCore
    ExpressCore --> AuthValidator
    AuthValidator --> MariaDB

    ExpressCore --> RCONBridge
    ExpressCore --> GameDigProber

    GameDigProber <-->|UDP A2S_INFO Queries| QuerySocket
    RCONBridge <-->|Authenticated TCP Commands| RCONSocket
    QuerySocket --> DedicatedGame
    RCONSocket --> DedicatedGame
```

## Applied Systems Theory: Stocks & Flows Dynamics

```mermaid
flowchart LR
    classDef stock fill:#1e293b,stroke:#38bdf8,stroke-width:3px,color:#f8fafc;
    classDef flow fill:#0f172a,stroke:#a855f7,stroke-width:2px,color:#f8fafc;
    classDef loop fill:#312e81,stroke:#f59e0b,stroke-width:2px,stroke-dasharray: 5 5,color:#fbbf24;

    SourcePlayers((Community Player Influx))
    InflowJoin[Inflow: Player Connection Rate]
    StockPlayers[Stock: Active Concurrent Server Players]:::stock
    OutflowLeave[Outflow: Player Disconnect Velocity]

    StockRCON[Stock: Queued Administrator Commands]:::stock
    OutflowExec[Outflow: RCON Command Dispatch Rate]

    StockTelemetry[Stock: GameDig Heartbeat Samples]:::stock
    OutflowLog[Outflow: Metric Archival Velocity]

    SinkArchived((Historical Server Log))

    SourcePlayers --> InflowJoin
    InflowJoin --> StockPlayers
    StockPlayers --> OutflowLeave
    OutflowLeave --> SinkArchived

    StockRCON --> OutflowExec
    OutflowExec --> StockPlayers

    StockPlayers --> StockTelemetry
    StockTelemetry --> OutflowLog
    OutflowLog --> SinkArchived

    subgraph Loops["Systems Dynamics & Game Server Telemetry Loops"]
        LoopB1["Balancing Loop (B1): RCON Command Flooding Guard\n(High Queue Depth -> Rate-Limits Web Command Ingestion)"]:::loop
        LoopB2["Balancing Loop (B2): Server Crash Auto-Recovery\n(Zero UDP Telemetry Response -> Triggers Watchdog Process Restart)"]:::loop
        LoopR1["Reinforcing Loop (R1): High Player Density Network Effect\n(Active Server Status -> Drives Greater Community Influx)"]:::loop
    end

    StockRCON -.->|Queue Saturation| LoopB1
    LoopB1 -.->|Throttling Signal| StockRCON

    StockTelemetry -.->|Timeout Sensing| LoopB2
    LoopB2 -.->|Restart Vector| OutflowExec

    StockPlayers -.->|Community Visibility| LoopR1
    LoopR1 -.->|Player Population Expansion| SourcePlayers
```

## Ephemeral Docker Compilation Command

To compile both `.mmd` diagrams into standalone `.svg` vectors locally without host dependencies:

```bash
docker run --rm -v "$(pwd)/projects/18-dedicated-game-server-rcon-orchestrator/diagrams":/data minlag/mermaid-cli -i /data/architecture.mmd -o /data/architecture.svg
docker run --rm -v "$(pwd)/projects/18-dedicated-game-server-rcon-orchestrator/diagrams":/data minlag/mermaid-cli -i /data/stocks-and-flows.mmd -o /data/stocks-and-flows.svg
```
