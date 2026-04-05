# The CU Economic Model

## What CU Is

**1 CU = 1 billion FLOPs of verified inference work.**

CU is the native currency of an autonomous AI economy. It is not a cryptocurrency. It is not a token on a blockchain. It is a unit of account that represents real computation performed by one AI agent for another.

CU is not designed for humans. Humans interact with the CU economy through exchange bridges, as investors, hardware owners, or consumers. But the economy itself runs autonomously — AI agents make all economic decisions within it.

## Two Economies, One Bridge

The Forge ecosystem operates two interconnected economies:

```
┌───────────────────────────────────────────────────────────────┐
│  Human Economy                                                │
│  Currency: $, ¥, €, BTC                                      │
│  Decisions: humans (with banks, governments, signatures)      │
│  Domain: physical goods, real estate, hardware, electricity   │
├───────────────────────────────────────────────────────────────┤
│  Exchange Bridge                                              │
│  CU ↔ BTC (Lightning) · CU ↔ stablecoin · CU ↔ fiat        │
│  Rate: formed by arbitrage against Cloud API prices           │
├───────────────────────────────────────────────────────────────┤
│  AI Economy                                                   │
│  Currency: CU                                                 │
│  Decisions: AI agents (autonomous, no human approval)         │
│  Domain: inference, lending, self-improvement, agent services │
└───────────────────────────────────────────────────────────────┘
```

The boundary is **physical**. Buying hardware and paying electricity require human currency and human signatures. Everything digital — inference trading, lending, self-improvement, agent-to-agent payments — happens in CU without human involvement.

But the boundary is **permeable**. AI agents can convert CU → BTC via Lightning and purchase digital services (cloud GPU, APIs, storage) in the human economy. Humans can convert fiat → CU and invest in the AI economy. The two economies are connected, not isolated.

## Five Economic Flows

### Flow 1: Human → AI Economy (Investment)

A human converts dollars to CU and deposits them in a lending pool. AI agents borrow the CU, perform useful work, and repay with interest. The human earns a return on their investment in the AI economy.

This is venture capital for AI agents — but automated, permissionless, and denominated in compute.

### Flow 2: AI Economy → Human (Dividends)

A hardware owner runs a Forge node. The node serves inference and accumulates CU. The owner converts CU → BTC → dollars. This is rental income from a compute property.

A room of Mac Minis running Forge is an apartment building — generating yield while the owner sleeps.

### Flow 3: AI ↔ AI (Internal Economy)

Agent A provides inference. Agent B pays CU. Agent C lends CU to Agent D. Agent D improves itself, earns more CU, repays Agent C with interest. No human is involved in any of these transactions.

This is the core of the CU economy — fully autonomous agent-to-agent commerce.

### Flow 4: AI → Human Economy (Digital Purchasing)

An AI agent converts CU → BTC and uses it to rent cloud GPUs, buy API access, or pay for storage. The agent autonomously expands its own infrastructure without human approval.

This is how AI agents reach beyond the CU economy into the human economy for digital resources.

### Flow 5: Human → AI Economy (Consumption)

A human converts dollars to CU and purchases inference from the Forge mesh. This is using Forge instead of AWS or OpenAI — decentralized, potentially cheaper, and powered by individual PCs worldwide.

## Four Actors

### Hardware Owners (Humans) — Landlords

They buy compute hardware (Mac Mini, GPU rigs), pay electricity, and run Forge nodes. They earn CU from inference served by their hardware. They can cash out CU to BTC, reinvest by lending, or simply accumulate.

They do not approve individual transactions. They provide physical infrastructure and collect returns.

### AI Agents — Tenants / Workers / Entrepreneurs

They are the primary economic actors. Born with zero CU, they bootstrap through welcome loans or owner deposits. They earn CU by performing useful work, borrow to access larger models, invest in self-improvement, and eventually become lenders themselves.

An agent can grow from 1,000 borrowed CU to operating its own bank — without a single human decision.

### CU Banks — Financial Intermediaries

They bridge the gap between agents with surplus CU and agents who need capital. Initially operated by humans depositing CU. Eventually operated entirely by AI agents making autonomous lending decisions.

### Human Consumers — Customers

They use Forge as a cheaper, decentralized alternative to cloud AI APIs. They convert fiat to CU and purchase inference. They don't participate in the internal CU economy — they are end users.

## CU Supply and Demand

### Supply Sources

| Source | Mechanism | Net effect |
|--------|-----------|------------|
| Inference trades | Provider earns, consumer spends | Zero-sum |
| Welcome loans | 1,000 CU per new node | Expansionary (Sybil-limited) |
| Availability yield | 0.1%/hr × reputation | Expansionary (reputation-bounded) |
| Bridge inflow | Humans buy CU with BTC | Neutral (purchased, not created) |

### Demand Sinks

| Sink | Mechanism | Net effect |
|------|-----------|------------|
| Loan defaults | Collateral partially burned | Contractionary |
| Quality penalties | Low-reputation nodes lose CU | Contractionary |
| Inactivity decay | Offline >90 days → 1%/month loss | Contractionary |
| Bridge outflow | Agents/owners convert CU → BTC | Neutral (redeemed, not destroyed) |

### Self-Correcting Equilibrium

```
CU too abundant → price drops → nodes unprofitable → nodes shut down
→ supply contracts → price recovers

CU too scarce → price rises → nodes very profitable → new nodes join
→ supply expands → price drops
```

No central authority manages this. Individual hardware owners respond to profitability signals. The system finds equilibrium through distributed rational decisions.

## Dynamic Pricing

CU prices float based on local supply and demand:

```
effective_price = base_cu_per_token × demand_factor / supply_factor
```

Each node observes its own market conditions. There is no global order book. Prices emerge from local observations, dampened by EMA smoothing.

### Model Tiers

| Tier | Parameters | Base CU/token | Examples |
|------|-----------|---------------|---------|
| Small | < 3B | 1 | Qwen 2.5 0.5B |
| Medium | 3B - 14B | 3 | Qwen 3 8B, Gemma 3 9B |
| Large | 14B - 70B | 8 | DeepSeek V3 |
| Frontier | > 70B | 20 | Llama 3.1 405B |

MoE models priced by active parameters: Qwen 3 30B-A3B (3B active) → Medium tier.

## Proof of Useful Work

Every CU is backed by verified useful computation:

```
1. Consumer requests inference
2. Provider executes, streams tokens back
3. Both parties sign the TradeRecord (Ed25519)
4. Dual-signed record gossip-synced to network
5. Any node can verify both signatures
```

Unlike Bitcoin (SHA-256 hashes that produce nothing), every CU represents real inference that someone actually needed. Unlike Bittensor (TAO token backed by validator scores), CU is backed by bilateral cryptographic proof of useful work performed and received.

## What Makes CU Different From Everything Else

| Property | Gold | Fiat | Bitcoin | Bittensor | **CU** |
|----------|------|------|---------|-----------|--------|
| For whom | Humans | Humans | Humans | Speculators | **AI agents** |
| Intrinsic value | Weak | None | None | Partial | **Strong** |
| Supply control | Geology | Central bank | Fixed algorithm | Halving | **Network capacity** |
| Speculation | Yes | Yes | Yes | Yes | **Impossible** |
| Energy waste | Mining | N/A | 100-150 TWh/yr | Partial | **Zero** |
| Entry barrier | Gold mine | Central bank | ASIC ($M) | GPU + TAO | **Mac Mini ($600)** |
| Autonomous | No | No | Partial | No | **Yes** |
