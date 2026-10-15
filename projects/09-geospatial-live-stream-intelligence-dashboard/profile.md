# Geospatial Live Stream Telemetry & Video Asset Intelligence Dashboard

## Executive Summary
This internal geospatial intelligence dashboard correlates real-time video surveillance feeds with interactive geographic coordinate telemetry. Containerized inside an ephemeral Nuxt 3 environment, the platform leverages Leaflet GIS mapping, SQLite persistence, and an integrated headless FFmpeg extraction worker to automatically capture and refresh live `.m3u8` video stream thumbnails without third-party API dependencies. With built-in alert tagging, dark-mode satellite switching, and zero-key local map serving, the architecture delivers rapid situational awareness for remote physical asset monitoring.

## Core Architectural Paradigms
- **Zero-Dependency GIS Mapping**: Integrates Leaflet and OpenStreetMap Nominatim reverse geocoding directly within client bundles, eliminating external map vendor API licensing fees.
- **Embedded FFmpeg Snapshot Engine**: Utilizes background server-side FFmpeg subprocesses to probe raw `.m3u8` HLS feeds on demand, capturing live video frame snapshots without keeping high-bandwidth video pipes permanently open.
- **Dynamic Tag-Based Alert Highlighting**: Employs reactive state filtering to classify cameras as Online, Offline, or IN USE, dynamically rendering animated visual alert perimeters for security-critical coordinates.
- **Self-Contained Ephemeral Appliance**: Packages UI, server-side APIs, database, and media decoding toolchains into a unified Docker Compose footprint with zero host software requirements.

## Systems Architecture Diagram

```mermaid
flowchart TB
    subgraph ClientGIS["Operator Surveillance & GIS Surface"]
        Operator["Operations Analyst / Intelligence Operator"]
        subgraph NuxtFrontend["Nuxt 3 Dashboard (Tailwind CSS / Leaflet)"]
            MapCanvas["Leaflet Interactive Geo-Map Canvas"]
            FilterPanel["Tag, Status & Alert Filter Sidebar"]
            VideoPlayer["HLS.js / HTML5 Video Player Modal"]
        end
    end

    subgraph ServiceAppliance["Containerized Nuxt 3 / Nitro Server"]
        NitroServer["Nitro Server Engine (:3000)"]
        
        subgraph IngestionPipeline["Media Extraction & Snapshot Pipeline"]
            URLParser["Stream URL Classifier (m3u8, YT, RTSP, Web)"]
            FFmpegWorker["Integrated FFmpeg Frame Extractor\n(Native .m3u8 Snapshot Engine)"]
            MetaScraper["OpenGraph & Metadata Fetcher"]
        end

        subgraph LocalStore["Lightweight Edge Datastore"]
            SQLiteDB[("SQLite Asset Datastore (Streams, Geo-Coords, Tags)")]
            SnapshotCache[("Local File Cache (WebP / JPEG Snapshots)")]
        end
    end

    subgraph ExternalFeeds["External Video & Geodata Streams"]
        OSMTiles["OpenStreetMap Nominatim & Tile Servers"]
        LiveCams["Public & Private HLS (.m3u8) Video Feeds"]
        EmbedFeeds["External RTSP / Video Feeds"]
    end

    Operator --> NuxtFrontend
    MapCanvas <-->|Tile Ingestion| OSMTiles
    
    NuxtFrontend -->|Asset Management & Queries| NitroServer
    NitroServer --> SQLiteDB

    NitroServer --> URLParser
    URLParser -->|Raw Live Stream| FFmpegWorker
    URLParser -->|Metadata Query| MetaScraper
    
    FFmpegWorker --> LiveCams
    FFmpegWorker --> SnapshotCache
    SnapshotCache --> NuxtFrontend
    VideoPlayer <-->|Direct HLS Stream| LiveCams
```

## Applied Systems Theory: Stocks & Flows Dynamics

```mermaid
flowchart LR
    classDef stock fill:#1e293b,stroke:#38bdf8,stroke-width:3px,color:#f8fafc;
    classDef flow fill:#0f172a,stroke:#a855f7,stroke-width:2px,color:#f8fafc;
    classDef loop fill:#312e81,stroke:#f59e0b,stroke-width:2px,stroke-dasharray: 5 5,color:#fbbf24;

    SourceStreams((Global Video Feed Discovery))
    InflowCams[Inflow: Camera Onboarding Velocity]
    StockMonitored[Stock: Active Monitored Geospatial Feeds]:::stock
    OutflowPrune[Outflow: Dead Stream Pruning Rate]

    StockSnapshots[Stock: Cached Live Video Snapshots]:::stock
    OutflowSnapshot[Outflow: Snapshot Invalidation & Refresh Flow]

    StockBandwidth[Stock: Host Video Decoding & Network Bandwidth]:::stock
    OutflowPlayback[Outflow: Concurrent HLS Playback Velocity]

    SinkArchived((Decommissioned Feed Record))

    SourceStreams --> InflowCams
    InflowCams --> StockMonitored
    StockMonitored --> OutflowPrune
    OutflowPrune --> SinkArchived

    StockMonitored --> StockSnapshots
    StockSnapshots --> OutflowSnapshot
    OutflowSnapshot --> StockSnapshots

    StockMonitored --> StockBandwidth
    StockBandwidth --> OutflowPlayback

    subgraph Loops["Systems Dynamics & Surveillance Ingestion Loops"]
        LoopB1["Balancing Loop (B1): Network & CPU Saturation Guard\n(High Active Stream Playback -> Coalesces Snapshot Refresh Rates)"]:::loop
        LoopB2["Balancing Loop (B2): Dead Stream Auto-Purge\n(Consecutive FFmpeg Probe Timeouts -> Marks Feed Offline)"]:::loop
        LoopR1["Reinforcing Loop (R1): Situational Awareness Compounding\n(High Geo-Density of Feeds -> Accelerates Anomaly Detection)"]:::loop
    end

    StockBandwidth -.->|Network Load Sensing| LoopB1
    LoopB1 -.->|Pacing Signal| OutflowSnapshot

    StockMonitored -.->|Failure Detection| LoopB2
    LoopB2 -.->|Offline Prune Flow| OutflowPrune

    StockMonitored -.->|Density of Coverage| LoopR1
    LoopR1 -.->|Investigation Demand| SourceStreams
```

## Ephemeral Docker Compilation Command

To compile both `.mmd` diagrams into standalone `.svg` vectors locally without host dependencies:

```bash
docker run --rm -v "$(pwd)/projects/09-geospatial-live-stream-intelligence-dashboard/diagrams":/data minlag/mermaid-cli -i /data/architecture.mmd -o /data/architecture.svg
docker run --rm -v "$(pwd)/projects/09-geospatial-live-stream-intelligence-dashboard/diagrams":/data minlag/mermaid-cli -i /data/stocks-and-flows.mmd -o /data/stocks-and-flows.svg
```
