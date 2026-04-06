# Forge 経済学パラメータ仕様

> 全数値定数のシングルソース。各章はここを参照して矛盾を防ぐ。
> *Version 0.2 — 2026 年 4 月*

このファイルは Forge 経済の数値定数を一元管理します。spec, docs/, README で言及される数値はすべてここから参照されるべきです。値を変更する場合は、必ずこのファイルを起点とし、grep ですべての参照箇所を確認してください。

---

## 1. CU の基本定義

| パラメータ | 値 | 単位 | 説明 |
|----------|-----|------|------|
| `cu_definition` | 10 億 FLOP | FLOP | 1 CU が表す物理的な計算量 |
| `cu_atomic_unit` | 1 CU | CU | 取引可能な最小単位 |

---

## 2. 動的価格モデル

| パラメータ | 値 | 説明 |
|----------|-----|------|
| `base_cu_per_token_small` | 1 CU/token | Small ティア (< 3B params) |
| `base_cu_per_token_medium` | 3 CU/token | Medium ティア (3B - 14B params) |
| `base_cu_per_token_large` | 8 CU/token | Large ティア (14B - 70B params) |
| `base_cu_per_token_frontier` | 20 CU/token | Frontier ティア (> 70B params) |
| `ema_half_life_minutes` | 30 分 | 価格平滑化の半減期 |

価格式:
```
effective_price = base_cu_per_token × demand_factor / supply_factor
```

---

## 3. ウェルカムローン (Welcome Loan)

| パラメータ | 値 | 説明 |
|----------|-----|------|
| `welcome_loan_amount` | 1,000 CU | 新規ノードへの初期融資額 |
| `welcome_loan_interest` | 0% | 金利 |
| `welcome_loan_term_hours` | 72 時間 | 返済期限 |
| `welcome_loan_sybil_threshold` | 100 nodes | これを超える未認証ノードからの申請は拒否 |
| `welcome_loan_credit_bonus` | +0.1 | 期限内返済時の信用スコアボーナス (0.3 → 0.4) |

---

## 4. 信用スコア (Credit Score)

| 重み | 値 | 構成要素 |
|------|-----|---------|
| `weight_trade` | 0.3 (30%) | 過去の取引実績 |
| `weight_repayment` | 0.4 (40%) | ローン返済実績 |
| `weight_uptime` | 0.2 (20%) | ネットワーク稼働時間 |
| `weight_age` | 0.1 (10%) | アカウント年齢 |

| 閾値 | 値 | 説明 |
|------|-----|------|
| `min_credit_for_borrowing` | 0.2 | 借入申請の最低信用スコア |
| `cold_start_credit` | 0.3 | 新規ノードの初期信用スコア |
| `target_credit_after_repay` | 0.4 | ウェルカムローン返済後の目標スコア |

---

## 5. レンディングプール

| パラメータ | 値 | 説明 |
|----------|-----|------|
| `min_reserve_ratio` | 30% | 最低準備率 (これ以上は貸し出せない) |
| `max_ltv_ratio` | 3:1 | 最大 Loan-to-Value 比 |
| `max_single_loan_pool_pct` | 20% | 単一融資のプール内最大割合 |
| `max_loan_term_hours` | 168 時間 (7 日) | 最大融資期間 |
| `max_lending_velocity` | 10 件/分 | 新規融資の速度上限 |

---

## 6. デフォルト・サーキットブレーカー

| パラメータ | 値 | 説明 |
|----------|-----|------|
| `default_circuit_breaker_threshold` | 10%/時 | この割合のデフォルトで全融資を一時停止 |
| `collateral_burn_on_default` | 10% | デフォルト時に焼却される担保の割合 |
| `velocity_circuit_breaker_window` | 1 時間 | 速度監視ウィンドウ |
| `velocity_circuit_breaker_threshold` | 50% プール残高/時 | 全融資が一時停止される閾値 |

---

## 7. レピュテーションと yield

| パラメータ | 値 | 説明 |
|----------|-----|------|
| `default_reputation` | 0.5 | 新規ノードの初期レピュテーション |
| `availability_yield_rate` | 0.1%/時 × reputation | 可用性に対する yield 率 |
| `inactivity_decay_threshold_days` | 7 日 | 非活動とみなされる閾値 |
| `inactivity_decay_rate` | 0.01/日 | uptime_score の減衰率 |
| `inactivity_burn_threshold_days` | 90 日 | CU 焼却対象となる非活動期間 |
| `inactivity_burn_rate` | 1%/月 | 焼却率 |

---

## 8. クラウド API アンカー (参考値、2026 年 4 月時点)

| パラメータ | 値 | 説明 |
|----------|-----|------|
| `claude_api_price_per_1m_tokens` | $15 | 為替レート計算の参照点 |
| `forge_70b_cu_per_1m_tokens` | 4,000 CU | 同等の Forge 価格 |
| `cu_usd_equilibrium_rate` | 約 $0.00375/CU | 上記から導出される均衡レート |

---

## 9. 物理的な上限・下限 (参考)

| パラメータ | 値 | 説明 |
|----------|-----|------|
| `cu_price_floor_usd` | 約 $0.000001/CU | 電力コスト由来の下限 |
| `cu_price_ceiling_usd` | 約 $0.000132/CU | Mac Mini ($600) 自前運用コスト由来の上限 |
| `mac_mini_annual_cu_capacity` | 約 5,000,000 CU/年 | Mac Mini M4 の年間生産可能 CU |

---

## 変更履歴

- v0.1 (2026-04): 初版作成 (M-6)
- v0.2 (TBD): spec v0.2 への統合

---

## 参照先

このファイルを参照する文書:
- spec/forge-economics-spec-v0.1.md
- spec/forge-economics-spec-v0.2.md (planned)
- docs/02-money.md (CU 供給量)
- docs/03-supply-demand.md (動的価格)
- docs/05-banking.md (レンディング全般)
- docs/06-exchange.md (為替)
- docs/07-growth.md (収穫逓減 yield)
