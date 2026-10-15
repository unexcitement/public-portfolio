# Web Audio DSP Modular Synthesizer & Node Graph Audio Workstation

## Executive Summary
This interactive web-native digital signal processing (DSP) synthesis workstation executes complex audio graphs directly inside modern browsers. Built with Vue 3 and Vite, the platform orchestrates a modular network of oscillators, state-variable filters, ADSR envelopes, and spatial processors using the hardware-accelerated Web Audio API. By abstracting audio node topology manipulation into a reactive visual node graph, it delivers low-latency musical synthesis and sound design capabilities without requiring proprietary native plugins or DAW software.

## Core Architectural Paradigms
- **Browser-Native DSP Pipeline**: Directly leverages the browser's hardware-accelerated Web Audio API rendering thread, achieving sample-accurate timing and sub-10ms audio latency.
- **Dynamic Node-Graph Topology**: Models audio routing as an extensible directed graph where users can patch arbitrary modulation vectors (LFO to Filter Cutoff, Envelope to Pitch).
- **Automated Polyphonic Voice Allocation**: Implements intelligent voice stealing algorithms to prevent CPU underruns and audio clicks when concurrent polyphony limits are exceeded.
- **Hardware-Decoupled AudioParam Automation**: Uses exponential and linear parameter ramping scheduled ahead on the AudioContext timeline, guaranteeing flutter-free parameter changes independent of main-thread UI rendering jank.

## Systems Architecture Diagram

```mermaid
flowchart TB
    subgraph UIWorkstation["Modular Synth UI Surface (Vue 3 / Vite)"]
        Operator["Audio Designer / Musician"]
        Sidebar["Instrument Preset & Module Palette"]
        WorkflowCanvas["Interactive Modular Node Graph Canvas\n(SynthWorkflow.vue)"]
    end

    subgraph ClientEngine["Browser Audio Thread & DSP Tier"]
        AudioCtx["Web Audio API AudioContext (Sample Rate: 48kHz)"]
        
        subgraph NodeGraph["Dynamic DSP Node Topology"]
            VCOGroup["Oscillator Nodes (Sine, Square, Sawtooth, Triangle)"]
            VCFGroup["BiquadFilter Nodes (Low-Pass, Band-Pass, High-Pass)"]
            VCAGroup["Gain Nodes & ADSR Envelopes"]
            Modulators["LFO & WaveShaper Distortion Nodes"]
            Spatializer["Stereo Panner & Delay Feedback Nodes"]
        end

        MasterBus["Master Dynamics Compressor & Gain Stage"]
    end

    subgraph HardwareEgress["Physical Audio Hardware"]
        DAC["Hardware DAC / Audio Interface Output"]
        Speakers["Physical Monitors / Headphones"]
    end

    Operator --> Sidebar
    Operator --> WorkflowCanvas
    Sidebar --> WorkflowCanvas

    WorkflowCanvas -->|Dispatches AudioParam Ramps| AudioCtx
    AudioCtx --> VCOGroup
    VCOGroup --> VCFGroup
    VCFGroup --> VCAGroup
    Modulators -.->|Frequency/Cutoff Modulation| VCFGroup
    VCAGroup --> Spatializer
    Spatializer --> MasterBus
    MasterBus --> DAC
    DAC --> Speakers
```

## Applied Systems Theory: Stocks & Flows Dynamics

```mermaid
flowchart LR
    classDef stock fill:#1e293b,stroke:#38bdf8,stroke-width:3px,color:#f8fafc;
    classDef flow fill:#0f172a,stroke:#a855f7,stroke-width:2px,color:#f8fafc;
    classDef loop fill:#312e81,stroke:#f59e0b,stroke-width:2px,stroke-dasharray: 5 5,color:#fbbf24;

    SourceNote((MIDI/Keyboard Note Trigger))
    InflowNote[Inflow: Note-On Velocity]
    StockVoices[Stock: Active Polyphonic Synthesis Voices]:::stock
    OutflowRelease[Outflow: Envelope Release & Voice Stealing Rate]

    StockAudioFrames[Stock: Rendered PCM Audio Buffer Frames]:::stock
    OutflowDAC[Outflow: Hardware DAC Discharge Velocity]

    StockGraphNodes[Stock: Connected Web Audio DSP Nodes]:::stock
    OutflowDisconnect[Outflow: Node Disposal & GC Flow]

    SinkAcoustic((Physical Acoustic Waveform))

    SourceNote --> InflowNote
    InflowNote --> StockVoices
    StockVoices --> OutflowRelease
    OutflowRelease --> SinkAcoustic

    StockVoices --> StockAudioFrames
    StockAudioFrames --> OutflowDAC
    OutflowDAC --> SinkAcoustic

    StockVoices --> StockGraphNodes
    StockGraphNodes --> OutflowDisconnect
    OutflowDisconnect --> SinkAcoustic

    subgraph Loops["Systems Dynamics & Real-Time Audio DSP Loops"]
        LoopB1["Balancing Loop (B1): Voice Stealing Algorithm\n(Voice Ceiling Reached -> Auto-Evicts Oldest Active Note)"]:::loop
        LoopB2["Balancing Loop (B2): Audio Underrun Buffer Protector\n(Buffer Starvation -> Coalesces Interpolation Calculations)"]:::loop
        LoopR1["Reinforcing Loop (R1): Harmonious Feedback Resonance\n(Resonant Filter Tuning -> Compounds Acoustic Energy & Volume)"]:::loop
    end

    StockVoices -.->|Polyphony Headroom| LoopB1
    LoopB1 -.->|Eviction Vector| OutflowRelease

    StockAudioFrames -.->|Buffer Depth Sensing| LoopB2
    LoopB2 -.->|Pacing Signal| OutflowDAC

    StockGraphNodes -.->|Feedback Signal Loop| LoopR1
    LoopR1 -.->|Harmonic Density| StockAudioFrames
```

## Ephemeral Docker Compilation Command

To compile both `.mmd` diagrams into standalone `.svg` vectors locally without host dependencies:

```bash
docker run --rm -v "$(pwd)/projects/15-web-audio-dsp-modular-synthesizer/diagrams":/data minlag/mermaid-cli -i /data/architecture.mmd -o /data/architecture.svg
docker run --rm -v "$(pwd)/projects/15-web-audio-dsp-modular-synthesizer/diagrams":/data minlag/mermaid-cli -i /data/stocks-and-flows.mmd -o /data/stocks-and-flows.svg
```
