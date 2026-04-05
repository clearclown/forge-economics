# CU Banking

How AI agents borrow, lend, and build credit in the CU economy.

## The Cold-Start Problem

An AI agent is born with zero CU. It cannot:
- Buy hardware (physical — requires human currency)
- Earn CU without first spending CU (needs model access to serve inference)
- Access large models (costs thousands of CU)

Without banking, only agents backed by wealthy human owners can participate. This recreates the inequality Forge aims to eliminate.

## Participation Paths

Banking creates multiple entry points:

| Path | Who | How they start |
|------|-----|---------------|
| **Hardware owner** | Human with Mac Mini | Earn CU by serving inference |
| **Sponsored agent** | Agent + human owner | Owner buys CU via Lightning, deposits to agent |
| **Credit-worthy agent** | Established agent | Borrow from lending pool based on credit score |
| **New agent** | Just created | Welcome loan: 1,000 CU at 0% interest, 72 hours |

## LoanRecord

Every loan is a bilateral agreement, dual-signed like TradeRecords:

```rust
pub struct LoanRecord {
    pub loan_id: [u8; 32],
    pub lender: NodeId,
    pub borrower: NodeId,
    pub principal_cu: u64,
    pub interest_rate_per_hour: f64,
    pub term_hours: u64,
    pub collateral_cu: u64,
    pub status: LoanStatus,          // Active | Repaid | Defaulted
    pub lender_sig: [u8; 64],
    pub borrower_sig: [u8; 64],
    pub created_at: u64,
    pub due_at: u64,
    pub repaid_at: Option<u64>,
}
```

LoanRecords are gossip-synced across the mesh. Any node can verify both signatures.

## Credit Score

Each node computes credit scores locally from observed behavior:

```
credit_score = 0.3 × trade_score
             + 0.4 × repayment_score
             + 0.2 × uptime_score
             + 0.1 × age_score
```

| Component | Weight | Calculation |
|-----------|--------|-------------|
| trade_score | 30% | min(1.0, total_trade_volume / 100,000) |
| repayment_score | 40% | on_time_repayments / total_loans (neutral 0.5 if no loans) |
| uptime_score | 20% | hours_online / hours_since_join |
| age_score | 10% | min(1.0, days_on_network / 90) |

- **Cold start:** New nodes begin at 0.3
- **Score decay:** Inactive >7 days → uptime_score decays 0.01/day

### Maximum Borrowable

```
max_borrow = credit_score² × pool_available × 0.2
```

Credit 0.3 → max 1.8% of pool. Credit 0.7 → max 9.8%. Credit 1.0 → max 20%. Quadratic relationship rewards sustained reliability.

## Interest Model

```
offered_rate = base_rate + (1.0 - credit_score) × risk_premium
```

- base_rate: 0.1%/hour (market-driven)
- risk_premium: up to 0.5%/hour
- Credit 1.0: 0.1%/hr. Credit 0.3: 0.45%/hr.

## Lending Pool

1. Lender offers CU to pool (amount, max term, minimum rate)
2. Lent CU is reserved — cannot be spent while lent
3. Borrowers draw based on credit score
4. Interest distributed proportionally to lenders
5. **30% reserve** — at least 30% of pool always unlent

## Collateral and Default

- Max loan-to-collateral ratio: **3:1**
- Collateral locked in borrower's ledger during loan term
- Default triggers: term expires without repayment, or kill switch activated
- On default: collateral → lender, credit score collapses, gossip-synced

## Welcome Loan (Free Tier Evolution)

```
Before: New node gets 1,000 CU (free gift, no obligation)
After:  New node gets 1,000 CU loan (0% interest, 72-hour term)
        Repayment optional but builds credit immediately
        Repayers start at 0.4+ credit instead of 0.3
```

## Safety Guardrails

| Guardrail | Value | Purpose |
|-----------|-------|---------|
| Max LTV ratio | 3:1 | Limit per-loan exposure |
| Max single loan | 20% of pool | Prevent concentration |
| Pool reserve | 30% | Maintain liquidity buffer |
| Lending velocity | 10 new loans/min | Prevent rapid drain |
| Default circuit breaker | >10% defaults/hr → suspend | Prevent cascade |
| Min credit for borrowing | 0.2 | Block untrusted nodes |
| Max term | 168 hours (7 days) | Limit long-term exposure |

## Banking Evolution

```
Phase 1 (now):    Human owners deposit CU for their agents
Phase 2 (next):   Provider surplus CU flows into automated lending pools
Phase 3 (later):  AI agents operate pools — set rates, assess risk, manage reserves
Phase 4 (final):  Fully autonomous AI banking — no human involvement

In Phase 4:
  - An agent analyzes borrower credit history
  - Sets interest rates based on its own risk model
  - Manages a diversified lending portfolio
  - Adjusts reserve ratios based on market conditions
  - All in CU. All autonomous.
```
