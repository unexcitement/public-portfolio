# Decentralized Notary & Passwordless Web3 Authentication Gateway

## Executive Summary
This enterprise digital notary and decentralized identity gateway bridges frictionless Web2 user onboarding with immutable Web3 cryptographic verification. Built on Next.js, Hardhat, and the Magic Link Dedicated Wallet SDK, the architecture allows non-technical enterprise users to digitally timestamp contracts, notarize legal agreements, and verify identity claims on-chain without holding cryptocurrency or managing raw private key seed phrases. Off-chain metadata is orchestrated via Prisma ORM, while on-chain verification leverages gas-optimized Solidity smart contracts.

## Core Architectural Paradigms
- **Non-Custodial Delegated Key Management**: Integrates Magic Link's Distributed Key Generation (DKG) architecture, generating hardware-enclave protected Ethereum keypairs via email/SMS magic links.
- **Gas-Optimized Merkle Root Timestamping**: Batches high-volume document hashes into Merkle trees to anchor cryptographic proofs on EVM blockchains at minimal gas overhead.
- **Decoupled Off-Chain / On-Chain State Boundary**: Preserves zero-knowledge privacy by storing sensitive document metadata within encrypted off-chain stores while committing only irreversible cryptographic hashes to the public ledger.
- **Automated Hardhat Smart Contract Pipeline**: Features deterministic smart contract compilation, static bytecode analysis, and deployment automation with type-safe ABI bindings.

## Systems Architecture Diagram

```mermaid
flowchart TB
    subgraph ClientLayer["User Surface & Passwordless Onboarding"]
        Signer["Signer / Enterprise Client"]
        NextApp["Next.js Application Core (:3000)\n(TypeScript / Tailwind CSS)"]
        MagicSDK["Magic Link Dedicated Wallet SDK\n(DKG Non-Custodial Key Delegation)"]
    end

    subgraph ServiceLayer["Notary Middleware & Document Engine"]
        APIRouter["Next.js API Routes (/api/*)"]
        Hasher["SHA-256 / Keccak-256 Document Hasher"]
        PrismaService["Prisma Client ORM (Off-Chain Metadata Store)"]
    end

    subgraph BlockchainLayer["EVM Smart Contract & Settlement Tier"]
        HardhatEngine["Hardhat EVM Compilation & Deploy Toolchain"]
        SmartContract["NotaryRegistry.sol Smart Contract\n(Immutable Timestamp & Merkle Root)"]
        EVMNetwork["EVM Blockchain (Ethereum / Polygon / Base)"]
        IPFSStore["Decentralized Metadata Archive (IPFS / Arweave)"]
    end

    Signer --> NextApp
    NextApp --> MagicSDK
    MagicSDK <-->|Hardware-Enclave Passwordless Auth| Signer

    NextApp --> APIRouter
    APIRouter --> Hasher
    APIRouter --> PrismaService

    Hasher -->|Document Digest| SmartContract
    MagicSDK -->|EIP-712 Typed Signature| SmartContract
    HardhatEngine -.->|Contract Compilation & ABI| SmartContract
    SmartContract --> EVMNetwork
    SmartContract --> IPFSStore
```

## Applied Systems Theory: Stocks & Flows Dynamics

```mermaid
flowchart LR
    classDef stock fill:#1e293b,stroke:#38bdf8,stroke-width:3px,color:#f8fafc;
    classDef flow fill:#0f172a,stroke:#a855f7,stroke-width:2px,color:#f8fafc;
    classDef loop fill:#312e81,stroke:#f59e0b,stroke-width:2px,stroke-dasharray: 5 5,color:#fbbf24;

    SourceDocs((Document Ingestion Influx))
    InflowUpload[Inflow: Document Hashing Rate]
    StockPending[Stock: Uncommitted Cryptographic Digests]:::stock
    OutflowBroadcast[Outflow: Smart Contract Inscription Velocity]

    StockMempool[Stock: In-Flight Mempool Transactions]:::stock
    OutflowMine[Outflow: Block Confirmation Velocity]

    StockProofs[Stock: Immutable On-Chain Notary Proofs]:::stock
    OutflowVerify[Outflow: Public Proof Verification Flow]

    SinkVerified((Tamper-Evident Historical Proof))

    SourceDocs --> InflowUpload
    InflowUpload --> StockPending
    StockPending --> OutflowBroadcast
    OutflowBroadcast --> StockMempool
    StockMempool --> OutflowMine
    OutflowMine --> StockProofs
    StockProofs --> OutflowVerify
    OutflowVerify --> SinkVerified

    subgraph Loops["Systems Dynamics & Cryptographic Consensus Loops"]
        LoopB1["Balancing Loop (B1): Gas Price Elasticity Throttle\n(High Gas Volatility -> Batches Document Digests into Merkle Trees)"]:::loop
        LoopB2["Balancing Loop (B2): Blockchain Finality Watchdog\n(Unconfirmed Transactions -> Re-broadcasts with Aggressive Tip)"]:::loop
        LoopR1["Reinforcing Loop (R1): Immutable Trust Network Effect\n(Accumulated Verified Proofs -> Broadens Institutional Reliance)"]:::loop
    end

    StockMempool -.->|Gas Price Sensing| LoopB1
    LoopB1 -.->|Batching Factor| OutflowBroadcast

    StockMempool -.->|In-Flight Latency| LoopB2
    LoopB2 -.->|Gas Escalation| OutflowMine

    StockProofs -.->|Auditable Integrity| LoopR1
    LoopR1 -.->|Enterprise Client Expansion| SourceDocs
```

## Ephemeral Docker Compilation Command

To compile both `.mmd` diagrams into standalone `.svg` vectors locally without host dependencies:

```bash
docker run --rm -v "$(pwd)/projects/14-decentralized-notary-web3-auth-gateway/diagrams":/data minlag/mermaid-cli -i /data/architecture.mmd -o /data/architecture.svg
docker run --rm -v "$(pwd)/projects/14-decentralized-notary-web3-auth-gateway/diagrams":/data minlag/mermaid-cli -i /data/stocks-and-flows.mmd -o /data/stocks-and-flows.svg
```
