# High-Throughput EPOS TCP Proxy Middleware

## Executive Summary
This enterprise edge proxy intercepts raw ESC/POS binary print streams across multi-till point-of-sale installations to perform zero-latency protocol manipulation and dynamic valuation. By rasterizing raw ESC/POS bit-images in memory and feeding them through an embedded OCR pipeline, the middleware extracts line-item records on the fly, applies promotional bundle pricing, and emits formatted itemized receipts alongside unaltered kitchen orders. This creates high-margin promotional agility for legacy hospitality infrastructure without modifying proprietary point-of-sale firmware or incurring vendor re-certification expenses.

## Core Architectural Paradigms
- **Zero-Copy Byte-Level Demultiplexing**: Implements concurrent non-blocking TCP listeners in Go, multiplexing high-throughput print payloads across concurrent till connections without intermediate disk writes.
- **In-Memory Rasterization & Optical Character Recognition**: Decodes ESC * double-density and GS v 0 raster streams directly into memory-backed monochrome image structures, piping pixel data to an optimized Tesseract OCR engine.
- **Deterministic Token-Bucket Flow Control**: Manages hardware printer memory backpressure via a rate-limited dispatch queue, preventing serial buffer overflows and printer disconnects during peak service rushes.
- **Fail-Open Hardware Pass-Through**: If OCR or bundle rule evaluation fails, the raw original ticket payload is guaranteed pass-through transmission to ensure operational continuity on the restaurant floor.

## Systems Architecture Diagram

```mermaid
flowchart TB
    subgraph EdgeNetwork["Physical EPOS Hardware Network (Private LAN segment)"]
        Till1["EPOS Till 1 (Fixed Station)"]
        Till2["EPOS Till 2 (Mobile Tablet / Bar)"]
        TillN["EPOS Till N"]
    end

    subgraph ProxyGateway["Go EPOS TCP Proxy Appliance"]
        direction TB
        subgraph ListenerGroup["Multi-Port TCP Demultiplexer"]
            Port9101["TCP Listener (:9101)"]
            Port9102["TCP Listener (:9102)"]
            Port910N["TCP Listener (:910N)"]
        end

        subgraph ProtocolPipeline["Zero-Copy Protocol Pipeline"]
            ByteParser["ESC/POS Byte Stream Streamer"]
            BitmapDecoder["ESC/POS Bit-Image Rasterizer (ESC * / GS v 0)"]
            OCRPipeline["In-Memory Tesseract OCR Extraction Engine"]
            OfferRules["Promotional Bundle Evaluation Engine (menu.json)"]
            BillCompiler["Itemised ESC/POS Receipt Formatter"]
        end

        subgraph QueueManager["Rate-Limited Hardware Dispatcher"]
            AsyncQueue["Buffered Channel Print Queue"]
            FlowController["TCP Token-Bucket Rate Controller"]
        end
    end

    subgraph PhysicalEgress["Hardware Output Perimeter"]
        ThermalPrinter["Industrial ESC/POS Thermal Printer (private LAN, raw print port 9100)"]
        KitchenStation["Kitchen Order Display / Kitchen Thermal Printer"]
    end

    Till1 -->|Raw ESC/POS Stream| Port9101
    Till2 -->|Raw ESC/POS Stream| Port9102
    TillN -->|Raw ESC/POS Stream| Port910N

    Port9101 --> ByteParser
    Port9102 --> ByteParser
    Port910N --> ByteParser

    ByteParser -->|Pass-through Stream| AsyncQueue
    ByteParser -->|Binary Graphics Stream| BitmapDecoder
    BitmapDecoder -->|In-Memory Monochrome Image| OCRPipeline
    OCRPipeline -->|Extracted Structured Items| OfferRules
    OfferRules -->|Discount Adjustments| BillCompiler
    BillCompiler -->|Formatted Print Job| AsyncQueue

    AsyncQueue --> FlowController
    FlowController -->|Rate-Limited TCP Dispatch| ThermalPrinter
    FlowController -->|Raw Kitchen Ticket Dispatch| KitchenStation
```

## Applied Systems Theory: Stocks & Flows Dynamics

```mermaid
flowchart LR
    classDef stock fill:#1e293b,stroke:#38bdf8,stroke-width:3px,color:#f8fafc;
    classDef flow fill:#0f172a,stroke:#a855f7,stroke-width:2px,color:#f8fafc;
    classDef loop fill:#312e81,stroke:#f59e0b,stroke-width:2px,stroke-dasharray: 5 5,color:#fbbf24;

    SourceTills((POS Order Generation))
    InflowTCP[Inflow: EPOS Print Ingress Rate]
    StockTCPQueue[Stock: Concurrent TCP Stream Buffer]:::stock
    OutflowDecode[Outflow: Bit-Image Extraction Velocity]

    StockBitmaps[Stock: In-Memory Raster Bitmaps]:::stock
    OutflowOCR[Outflow: OCR Analysis Throughput]

    StockOrderItems[Stock: Structured Order Inventory]:::stock
    OutflowRules[Outflow: Bundle Pricing Computation Flow]

    StockPrintJobs[Stock: Compiled Print Dispatch Queue]:::stock
    OutflowPrint[Outflow: Hardware Buffer Discharge Rate]
    
    SinkPrinter((Thermal Receipt Head Discharge))

    SourceTills --> InflowTCP
    InflowTCP --> StockTCPQueue
    StockTCPQueue --> OutflowDecode
    OutflowDecode --> StockBitmaps
    StockBitmaps --> OutflowOCR
    OutflowOCR --> StockOrderItems
    StockOrderItems --> OutflowRules
    OutflowRules --> StockPrintJobs
    StockPrintJobs --> OutflowPrint
    OutflowPrint --> SinkPrinter

    subgraph Loops["Systemic Feedback Loops & Boundary Controls"]
        LoopB1["Balancing Loop (B1): Hardware Memory Overflow Protection\n(Printer Buffer Full -> Sleep TCP Read Sockets)"]:::loop
        LoopB2["Balancing Loop (B2): OCR CPU Throttling\n(High OCR Queue -> Coalesce Graphics Buffers)"]:::loop
        LoopR1["Reinforcing Loop (R1): Promotional Revenue Acceleration\n(Transparent Bundle Pricing -> Increased Item Velocity)"]:::loop
    end

    StockPrintJobs -.->|Buffer Depth Telemetry| LoopB1
    LoopB1 -.->|TCP Pause Signal| InflowTCP

    StockBitmaps -.->|Queue Pressure| LoopB2
    LoopB2 -.->|Pacing Signal| OutflowDecode

    OutflowRules -.->|Promotional Lift| LoopR1
    LoopR1 -.->|Order Volume Growth| InflowTCP
```

## Ephemeral Docker Compilation Command

To compile both `.mmd` diagrams into standalone `.svg` vectors locally without host dependencies:

```bash
docker run --rm -v "$(pwd)/projects/02-epos-tcp-proxy-middleware/diagrams":/data minlag/mermaid-cli -i /data/architecture.mmd -o /data/architecture.svg
docker run --rm -v "$(pwd)/projects/02-epos-tcp-proxy-middleware/diagrams":/data minlag/mermaid-cli -i /data/stocks-and-flows.mmd -o /data/stocks-and-flows.svg
```
