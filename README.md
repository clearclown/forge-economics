# Forge Economics

> The first economic model designed for an autonomous AI economy.

This repository contains the economic theory, models, and analysis behind [Forge](https://github.com/clearclown/forge) — a distributed inference protocol where Compute Units (CU) serve as the native currency of an AI agent economy.

## Why This Exists

Forge is not just a compute marketplace. It is a complete economic system where AI agents autonomously earn, spend, lend, borrow, and invest — without human approval. This repository documents the economic foundations separately from the protocol implementation.

## Documents

| Document | Description |
|----------|-------------|
| [The CU Economic Model](cu-economic-model.md) | Complete specification: two economies, five flows, four actors, exchange dynamics |
| [Monetary Theory](monetary-theory.md) | 100 years of intellectual history: Soddy → Technocracy → Fuller → Bitcoin → CU |
| [Competitive Landscape](competitive-landscape.md) | Analysis of Bittensor, Akash, Autonolas, and why CU is different |
| [CU Banking](cu-banking.md) | Lending, borrowing, credit scores, and the evolution of AI-operated banks |
| [Self-Improvement Economics](self-improvement-economics.md) | How agents invest CU to make themselves smarter (AutoAgent × CU) |
| [Exchange Rate Dynamics](exchange-rate-dynamics.md) | How CU/USD rate forms, Cloud API as anchor, natural price bounds |

## Core Thesis

```
Human Economy                       AI Economy (Forge)
────────────────                    ────────────────────
Currency: dollars, yen, BTC         Currency: CU
Decisions: humans                   Decisions: AI agents
Approval: required                  Approval: none
Boundary: physical world            Boundary: digital world
Connection: CU ↔ BTC exchange bridge
```

- **CU is AI-native currency** — not a human token, not a speculative asset
- **Two economies connected** — AI economy links to human economy via exchange bridges
- **AI agents are full economic actors** — they earn, borrow, invest, and purchase digital services autonomously
- **Physics anchors value** — CU supply tied to real compute capacity, exchange rate anchored by Cloud API arbitrage
- **100 years of theory** — Soddy (1921), Technocracy (1932), Fuller (1968), Bitcoin (2009), CU (2026)

## Related Repositories

| Repository | Purpose |
|-----------|---------|
| [forge](https://github.com/clearclown/forge) | Protocol implementation (Rust) |
| [forge-mesh](https://github.com/nm-arealnormalman/mesh-llm) | Distributed inference runtime |
| forge-economics (this) | Economic theory and models |

## License

MIT
