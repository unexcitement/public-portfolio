# Low-Latency Global Livestreaming & Event Broadcast Media Platform

## Executive Summary
This media broadcast and livestreaming platform delivers real-time video coverage of live global events to high-concurrency public audiences. Packaged as an autonomous Dockerized appliance, the architecture integrates a high-throughput RTMP/HLS media ingest pipeline, adaptive segment caching, and an Express/MariaDB session and scheduling layer. By leveraging distributed edge CDN caching coupled with rolling-window segment purges, the system ensures sub-three-second broadcast latency without destabilizing host compute or memory buffers.

## Core Architectural Paradigms
- **Adaptive Bitrate HLS Muxing**: Transmuxes incoming RTMP/SRT streams into chunked HTTP Live Streaming (HLS) representations on the fly, adjusting quality profiles dynamically to client network capacity.
- **Rolling Window Ephemeral Storage**: Manages live media segments within an in-memory buffer and ephemeral disk cache, automatically purging expired video chunks to maintain a deterministic disk footprint.
- **Containerized Modular Media Stack**: Decouples the web presentation tier, relational user and schedule database, and video transcoding pipeline into discrete, horizontally scalable Docker containers.
- **Edge-Optimized Fanout Delivery**: Distributes cached video segments through global edge endpoints, protecting the origin application server from viewer flash crowds during breaking live events.

## Systems Architecture Diagram

```mermaid
flowchart TB
    subgraph BroadcastIngress["Media Ingest & Field Coverage Boundary"]
        FieldBroadcasters["Remote Event Broadcasters / RTMP Encoders"]
        MediaGateway["Edge Media Ingest Server (RTMP / SRT)"]
    end

    subgraph PlatformAppliance["Containerized Broadcast Platform (Docker Compose)"]
        subgraph WebTier["Express Web Application Tier (:3000)"]
            Router["Express MVC Controller & Auth Middleware"]
            SessionManager["bcrypt + express-session Validator"]
            EJSViews["Dynamic EJS Presentation & Player Views"]
        end

        subgraph MediaTranscoder["HLS Transcoder & Segmenter Pipeline"]
            FFmpegMuxer["FFmpeg Live Segmenter (Adaptive Bitrate Muxer)"]
            HLSChunks["Ephemeral HLS Segment Cache (.ts / .m3u8)"]
        end

        subgraph DBTier["Persistence Tier"]
            MariaDB[("MariaDB Relational Store\n(User Accounts, Broadcast Schedules, Logs)")]
            MailNode["Nodemailer Transactional Event Notification"]
        end
    end

    subgraph ViewerPerimeter["Global Viewer Distribution (Edge CDN)"]
        GlobalViewers["Global Viewers / End-User Devices"]
        EdgeDistribution["Edge Caching Network (HLS Stream Fanout)"]
    end

    FieldBroadcasters -->|Raw Stream Ingest| MediaGateway
    MediaGateway --> FFmpegMuxer
    FFmpegMuxer --> HLSChunks

    Router --> SessionManager
    SessionManager --> MariaDB
    Router --> EJSViews
    Router --> MailNode

    HLSChunks --> EdgeDistribution
    EJSViews --> EdgeDistribution
    EdgeDistribution --> GlobalViewers
```

## Applied Systems Theory: Stocks & Flows Dynamics

```mermaid
flowchart LR
    classDef stock fill:#1e293b,stroke:#38bdf8,stroke-width:3px,color:#f8fafc;
    classDef flow fill:#0f172a,stroke:#a855f7,stroke-width:2px,color:#f8fafc;
    classDef loop fill:#312e81,stroke:#f59e0b,stroke-width:2px,stroke-dasharray: 5 5,color:#fbbf24;

    SourceStreamers((Live Field Event Generation))
    InflowIngest[Inflow: RTMP/SRT Media Ingestion Rate]
    StockSegments[Stock: Cached Ephemeral HLS Segments]:::stock
    OutflowPurge[Outflow: Rolling Window Segment Purge Rate]

    StockViewers[Stock: Active Concurrent Stream Viewers]:::stock
    OutflowDisconnect[Outflow: Viewer Session Disconnect Velocity]

    StockBandwidth[Stock: Available Outbound Egress Pipe]:::stock
    OutflowEgress[Outflow: Video Packet Delivery Velocity]

    SinkTerminated((Concluded Broadcast Session))

    SourceStreamers --> InflowIngest
    InflowIngest --> StockSegments
    StockSegments --> OutflowPurge
    OutflowPurge --> SinkTerminated

    StockSegments --> StockViewers
    StockViewers --> OutflowDisconnect
    OutflowDisconnect --> SinkTerminated

    StockBandwidth --> OutflowEgress
    StockViewers --> OutflowEgress

    subgraph Loops["Systems Dynamics & Streaming Equilibrium Loops"]
        LoopB1["Balancing Loop (B1): Transcoder Buffer Backpressure\n(Ingest Lag Detected -> Drops Non-Keyframe Video Chunks)"]:::loop
        LoopB2["Balancing Loop (B2): Adaptive Bitrate Congestion Guard\n(Saturated Egress -> Downshifts Viewer HLS Quality Profile)"]:::loop
        LoopR1["Reinforcing Loop (R1): Live Event Virality\n(Low Latency & High Stability -> Amplifies Social Viewer Influx)"]:::loop
    end

    StockSegments -.->|Buffer Depth Sensing| LoopB1
    LoopB1 -.->|Pacing Signal| InflowIngest

    StockBandwidth -.->|Congestion Monitor| LoopB2
    LoopB2 -.->|Quality Stepdown| OutflowEgress

    StockViewers -.->|Audience Virality| LoopR1
    LoopR1 -.->|Audience Acceleration| StockViewers
```

## Ephemeral Docker Compilation Command

To compile both `.mmd` diagrams into standalone `.svg` vectors locally without host dependencies:

```bash
docker run --rm -v "$(pwd)/projects/13-low-latency-event-broadcast-platform/diagrams":/data minlag/mermaid-cli -i /data/architecture.mmd -o /data/architecture.svg
docker run --rm -v "$(pwd)/projects/13-low-latency-event-broadcast-platform/diagrams":/data minlag/mermaid-cli -i /data/stocks-and-flows.mmd -o /data/stocks-and-flows.svg
```
