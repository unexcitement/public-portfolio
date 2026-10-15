# Algorithmic Expression Deconstruction & Complexity Engine

## Executive Summary
This inverse computation and symbolic expression manipulation engine algorithmically deconstructs arithmetic expressions into recursively complex mathematical equations. Built with Vue 3, TypeScript, and Tailwind CSS v4, the system employs Abstract Syntax Tree (AST) tree expansion and randomized factorization strategies (addition/subtraction splitting, multiplicative factoring, and nested parenthesis injection) to demonstrate progressive complexity generation while verifying mathematical equivalence at each recursive iteration.

## Core Architectural Paradigms
- **Recursive Abstract Syntax Tree Expansion**: Mutates atomic numeric leaves into complex compound subtrees while mathematically preserving the invariant root evaluation.
- **Multiple Deconstruction Strategies**: Dynamically selects between five distinct complication transforms (additive splits, subtractive splits, factor multiplication, chained operations, nested groupings) via weighted probability.
- **Strict Mathematical Invariant Verification**: Runs an internal deterministic algebraic evaluator on every transformed tree before rendering to ensure no calculation drift or rounding artifacts occur.
- **Immutable Session History Graph**: Captures each progressive complication wave into an append-only timeline, allowing instantaneous backtracking and branching exploration.

## Systems Architecture Diagram

```mermaid
flowchart TB
    subgraph UIClient["Client Interaction Surface (Vue 3 / Tailwind v4)"]
        User["User / Evaluator"]
        Keypad["Virtual Numeric & Operator Keypad"]
        Display["Active Expression & History Viewport"]
    end

    subgraph CoreEngine["Algorithmic Complexity Core (TypeScript)"]
        LexerParser["Expression Lexer & AST Parser"]
        
        subgraph ComplicationStrategies["Recursive Mutation Strategies"]
            AddSplit["Addition Splitter: x -> (a + b)"]
            SubSplit["Subtraction Expander: x -> (c - d)"]
            FactorMul["Factor Multiplier: x -> (y * z)"]
            ChainOp["Chained Operator Weaver"]
            ParenthesesNester["Nested Parentheses Injector"]
        end

        HistoryStore["Session History Immutability Store"]
        EvaluationVerifier["Sanity Check: Deterministic Solver (eval == original)"]
    end

    User --> Keypad
    Keypad --> LexerParser
    LexerParser --> EvaluationVerifier
    
    EvaluationVerifier --> ComplicationStrategies
    ComplicationStrategies --> Display
    ComplicationStrategies --> HistoryStore
    HistoryStore --> Display
```

## Applied Systems Theory: Stocks & Flows Dynamics

```mermaid
flowchart LR
    classDef stock fill:#1e293b,stroke:#38bdf8,stroke-width:3px,color:#f8fafc;
    classDef flow fill:#0f172a,stroke:#a855f7,stroke-width:2px,color:#f8fafc;
    classDef loop fill:#312e81,stroke:#f59e0b,stroke-width:2px,stroke-dasharray: 5 5,color:#fbbf24;

    SourceInput((Raw Numerical Input))
    InflowTrigger[Inflow: Operator Equals Action Rate]
    StockAST[Stock: AST Node Complexity & Expression Depth]:::stock
    OutflowClear[Outflow: Clear / Reset Discharge Velocity]

    StockHistory[Stock: Immutable Session History Log]:::stock
    OutflowHistory[Outflow: History Rotation / Eviction Rate]

    SinkSimplified((Zero-State Expression Reset))

    SourceInput --> InflowTrigger
    InflowTrigger --> StockAST
    StockAST --> OutflowClear
    OutflowClear --> SinkSimplified

    StockAST --> StockHistory
    StockHistory --> OutflowHistory
    OutflowHistory --> SinkSimplified

    subgraph Loops["Systems Dynamics & Complexity Escalation Loops"]
        LoopB1["Balancing Loop (B1): Max Recursion / Stack Depth Limiter\n(Depth Ceiling Reached -> Coalesces Operations into Parentheses)"]:::loop
        LoopR1["Reinforcing Loop (R1): Progressive Obfuscation Compounding\n(Successive '=' Press -> Exponentially Multiplies Subtree Count)"]:::loop
    end

    StockAST -.->|Tree Depth Sensing| LoopB1
    LoopB1 -.->|Recursion Pacing Signal| InflowTrigger

    StockAST -.->|Subtree Multiplication Factor| LoopR1
    LoopR1 -.->|Exponential Complexity Vector| StockAST
```

## Ephemeral Docker Compilation Command

To compile both `.mmd` diagrams into standalone `.svg` vectors locally without host dependencies:

```bash
docker run --rm -v "$(pwd)/projects/16-algorithmic-expression-complexity-engine/diagrams":/data minlag/mermaid-cli -i /data/architecture.mmd -o /data/architecture.svg
docker run --rm -v "$(pwd)/projects/16-algorithmic-expression-complexity-engine/diagrams":/data minlag/mermaid-cli -i /data/stocks-and-flows.mmd -o /data/stocks-and-flows.svg
```
