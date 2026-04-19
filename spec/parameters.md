# Tirami 経済学パラメータ仕様

> 全数値定数のシングルソース。各章はここを参照して矛盾を防ぐ。
> *Version 0.2 — 2026 年 4 月*

このファイルは Tirami 経済の数値定数を一元管理します。spec, docs/, README で言及される数値はすべてここから参照されるべきです。値を変更する場合は、必ずこのファイルを起点とし、grep ですべての参照箇所を確認してください。

---

## 1. TRM の基本定義

| パラメータ | 値 | 単位 | 説明 |
|----------|-----|------|------|
| `cu_definition` | 10 億 FLOP | FLOP | 1 TRM が表す物理的な計算量 |
| `cu_atomic_unit` | 1 TRM | TRM | 取引可能な最小単位 |

---

## 2. 動的価格モデル

| パラメータ | 値 | 説明 |
|----------|-----|------|
| `base_cu_per_token_small` | 1 TRM/token | Small ティア (< 3B params) |
| `base_cu_per_token_medium` | 3 TRM/token | Medium ティア (3B - 14B params) |
| `base_cu_per_token_large` | 8 TRM/token | Large ティア (14B - 70B params) |
| `base_cu_per_token_frontier` | 20 TRM/token | Frontier ティア (> 70B params) |
| `ema_half_life_minutes` | 30 分 | 価格平滑化の半減期 |

価格式:
```
effective_price = base_cu_per_token × demand_factor / supply_factor
```

---

## 3. ウェルカムローン (Welcome Loan)

| パラメータ | 値 | 説明 |
|----------|-----|------|
| `welcome_loan_amount` | 1,000 TRM | 新規ノードへの初期融資額 |
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
| `inactivity_burn_threshold_days` | 90 日 | TRM 焼却対象となる非活動期間 |
| `inactivity_burn_rate` | 1%/月 | 焼却率 |

---

## 8. クラウド API アンカー (参考値、2026 年 4 月時点)

| パラメータ | 値 | 説明 |
|----------|-----|------|
| `claude_api_price_per_1m_tokens` | $15 | 為替レート計算の参照点 |
| `forge_70b_cu_per_1m_tokens` | 4,000 TRM | 同等の Tirami 価格 |
| `cu_usd_equilibrium_rate` | 約 $0.00375/TRM | 上記から導出される均衡レート |

---

## 9. 物理的な上限・下限 (参考)

| パラメータ | 値 | 説明 |
|----------|-----|------|
| `cu_price_floor_usd` | 約 $0.000001/TRM | 電力コスト由来の下限 |
| `cu_price_ceiling_usd` | 約 $0.000132/TRM | Mac Mini ($600) 自前運用コスト由来の上限 |
| `mac_mini_annual_cu_capacity` | 約 5,000,000 TRM/年 | Mac Mini M4 の年間生産可能 TRM |

---

---

## 10. 金融商品レイヤー (tirami-bank / L2)

`tirami-bank` crate (Rust, `crates/tirami-bank/`) が参照する定数。
戦略、ポートフォリオ、先物、保険、リスクモデル、yield オプティマイザのシングルソース。

### 10.1 リスク許容度 (RiskTolerance)

| パラメータ | 値 | 説明 |
|----------|-----|------|
| `risk_multiplier_conservative` | 0.5 | Conservative 戦略のコミット上限倍率 |
| `risk_multiplier_balanced` | 0.8 | Balanced のコミット上限倍率 |
| `risk_multiplier_aggressive` | 1.0 | Aggressive のコミット上限倍率 |

### 10.2 戦略 (Strategy)

| パラメータ | 値 | 説明 |
|----------|-----|------|
| `conservative_max_commit_fraction` | 0.30 | Conservative: cash の最大 30% のみ貸出 |
| `conservative_reserve_threshold` | 0.60 | プール準備率がこれ未満なら HOLD |
| `highyield_base_commit_fraction` | 0.50 | HighYield: cash の 50% をベースに貸出 |
| `highyield_lend_threshold` | 0.40 | プール準備率がこれ超ならレンド |
| `highyield_borrow_rate_threshold` | 0.002 | 自分の offered_rate がこれ未満なら借入機会 |
| `highyield_borrow_cash_fraction` | 0.50 | 借入時 cash の 50% まで |

### 10.3 先物 (FuturesContract)

| パラメータ | 値 | 説明 |
|----------|-----|------|
| `default_margin_fraction` | 0.10 | デフォルト必要証拠金率 (10%) |
| `margin_fraction_range` | (0, 1) | 証拠金率の有効範囲 (両端除外) |

PnL 式 (ゼロサム保証):
```
long_pnl  = (settlement_price − strike_price) × notional
short_pnl = −long_pnl
```

### 10.4 保険 (InsurancePolicy)

| パラメータ | 値 | 説明 |
|----------|-----|------|
| `insurance_base_rate` | 0.02 | 基礎料率 (2%) |
| `insurance_risk_premium` | 0.10 | 最大リスクプレミアム (10%) |
| `insurance_min_premium` | 1 TRM | 最小プレミアム (floor 後の保証) |

料率式:
```
rate    = base_rate + (1 − credit_score) × risk_premium
premium = max(min_premium, floor(coverage × rate))
```

### 10.5 リスクモデル (RiskModel)

| パラメータ | 値 | 説明 |
|----------|-----|------|
| `default_rate` | 0.02 | 想定デフォルト率 (年率 2%) |
| `loss_given_default` | 0.50 | LGD: デフォルト時損失率 (50%) |
| `var_99_multiplier` | 2.33 | VaR 99% のスコア係数 (正規分布) |

VaR 式 (独立ベルヌーイ損失):
```
expected_loss = floor(total_lent × default_rate × lgd)
variance      = sum(cu_i² × default_rate × (1 − default_rate))
std_dev       = sqrt(variance) × lgd
var_99        = floor(expected_loss + var_99_multiplier × std_dev)
concentration = max(lent_positions) / total_lent
```

---

## 11. 自己改善レイヤー (tirami-mind / L3)

`tirami-mind` crate (Rust, `crates/tirami-mind/`) が参照する定数。
AutoAgent スタイルの自己改善ループが TRM を消費する際のハード上限。

### 11.1 TRM Budget (ハード上限)

| パラメータ | 値 | 説明 |
|----------|-----|------|
| `max_cu_per_cycle` | 5,000 TRM | 1 改善サイクルで使える TRM 上限 |
| `max_cu_per_day` | 50,000 TRM | 1 日あたりの TRM 上限 |
| `max_cycles_per_day` | 20 | 1 日あたりの改善サイクル上限 |
| `budget_day_rollover_hours` | 24 | 日次リセット周期 |

### 11.2 ROI ゲート

| パラメータ | 値 | 説明 |
|----------|-----|------|
| `min_score_delta` | 0.01 | ベンチマークスコア改善の最小値 (これ未満は棄却) |
| `min_roi_threshold` | 1.0 | 投資回収の最小比率 (cu_return / cu_invested) |
| `roi_cu_per_score_unit` | 100,000 TRM | スコア 1.0 改善あたりの想定 TRM リターン換算 |

判定ルール:
```
if score_delta < min_score_delta:          reject
if cu_invested <= 0 and score_delta > 0:   accept (無料の改善)
roi = cu_return_estimate / cu_invested
return roi >= min_roi_threshold
```

### 11.3 can_spend ゲート (全て真のとき許可)

1. `cu_amount > 0`
2. `cu_amount <= max_cu_per_cycle`
3. `spent_today + cu_amount <= max_cu_per_day`
4. `cycles_today < max_cycles_per_day`

---

## 12. エージェント市場レイヤー (tirami-agora / L4)

`tirami-agora` crate (Rust, `crates/tirami-agora/`) が参照する定数。
レピュテーション集約と capability マッチングのシングルソース。

### 12.1 レピュテーション重み (sum = 1.0)

| パラメータ | 値 | 説明 |
|----------|-----|------|
| `rep_weight_volume` | 0.40 | 取引総量のウェイト |
| `rep_weight_recency` | 0.30 | 最近の活動度 |
| `rep_weight_diversity` | 0.20 | カウンターパーティの多様性 |
| `rep_weight_consistency` | 0.10 | 取引間隔の一貫性 |
| `new_agent_reputation` | 0.30 | 取引履歴ゼロの新規エージェントの初期値 |

### 12.2 レピュテーション計算パラメータ

| パラメータ | 値 | 説明 |
|----------|-----|------|
| `volume_cap_cu` | 100,000 TRM | volume スコアが 1.0 に飽和する閾値 |
| `recency_half_life_ms` | 24 時間 | recency 半減期 |
| `diversity_cap` | 10 | diversity が 1.0 に飽和するユニーク相手数 |
| `consistency_min_trades` | 2 | これ未満は consistency = 0 |

サブスコア式:
```
volume      = min(1.0, total_cu / volume_cap_cu)
recency     = 0.5^(age_ms / recency_half_life_ms)
diversity   = min(1.0, unique_counterparties / diversity_cap)
cv          = stdev(intervals) / mean(intervals)
consistency = max(0, 1 − cv / 2)
reputation  = 0.4 × volume + 0.3 × recency + 0.2 × diversity + 0.1 × consistency
```

### 12.3 Capability マッチャー

| パラメータ | 値 | 説明 |
|----------|-----|------|
| `match_quality_weight` | 0.60 | 合成スコアにおける reputation ウェイト |
| `match_cost_weight` | 0.40 | 合成スコアにおける price_score ウェイト |
| `price_score_tier_multiplier` | 4.0 | tier.base × 4 を price_score の 0 点に設定 |

ハードフィルタ:
1. tier が指定されていれば完全一致
2. `cu_per_token <= max_cu_per_token`
3. モデル名が任意のクエリパターン (fnmatch) にマッチ

スコア式:
```
price_score = max(0, 1 − cu_per_token / (tier.base × price_score_tier_multiplier))
composite   = match_quality_weight × reputation + match_cost_weight × price_score
```

---

## 13. サンプリングパラメータ (Phase 11, tirami-node 推論レイヤー)

`crates/tirami-node/src/api.rs` が参照する定数。
OpenAI 互換サンプリングと Phase 12 のファンクションコーリングのシングルソース。

### 13.1 OpenAI 互換サンプリング

これらのパラメータは `OpenAIChatRequest` から `tirami-infer` エンジントレイトの
llama.cpp サンプラーチェーンに転送される。トークン分布（= 1 リクエストあたりの TRM 消費）
に影響するが、台帳のコスト関数（`estimate_cost(tokens, 1, 1)`）には直接影響しない。

| パラメータ | デフォルト | 範囲 | 意味 |
|----------|---------|-------|-----------|
| `temperature` | 0.7 | [0.0, 2.0] | ロジットの softmax 温度。0 = 貪欲デコード |
| `top_p` | None | (0.0, 1.0] | 核サンプリング閾値 |
| `top_k` | None | 正の整数 | Top-k サンプリングカットオフ |
| `max_tokens` | 256 | 正の整数 | 生成トークン数のハードキャップ |

`top_k` と `top_p` の両方が設定された場合、llama.cpp サンプラーチェーンは
`[top_k, top_p, temp, dist]` の順に適用される。

### 13.2 ストリーミング

| パラメータ | デフォルト | 意味 |
|----------|---------|-----------|
| `stream` | false | true の場合、レスポンスは `generate_streaming()` 経由の実トークン逐次 SSE チャンクとして送信される（Phase 11 で擬似ストリーミングから実装を刷新） |

ストリーミングリクエストの TRM 会計: 台帳のトレードレコードはストリーム完了後に書き込まれ、
`generate_streaming()` が報告する実際のトークン数を使用する。

### 13.3 ファンクションコーリング (Phase 12 A1)

| パラメータ | デフォルト | 意味 |
|----------|---------|-----------|
| `tools` | None | OpenAI 形式のツール定義の配列（name/description/JSON schema parameters） |
| `tool_choice` | "auto" | "auto" / "none" / "required" / 特定の関数名 |

ツール定義はシンプルなテンプレートによってシステムプロンプトに注入される。
モデルの出力に `<tool_call>...</tool_call>` マーカーが含まれる場合、
レスポンスは `choices[0].message.tool_calls` に変換され、
`finish_reason: "tool_calls"` として返される。

---

## 14. 供給曲線 (Supply Curve) — Phase 13

| パラメータ | 値 | 説明 |
|---|---|---|
| `total_trm_supply` | 21,000,000,000 | TRM の総発行上限 (Bitcoin 21M × 1000) |
| `supply_factor_formula` | `1 - minted / cap` | mint rate の減衰係数 |
| `transaction_fee_rate` | 0.01 (1%) | supply 枯渇後の取引手数料率 |
| `fee_activation_threshold` | 0.1 | supply_factor がこれ以下で手数料活性化 |

---

## 15. 利回り半減期 (Yield Halving) — Phase 13

| パラメータ | 値 | 説明 |
|---|---|---|
| `initial_yield_rate` | 0.001 (/hr × reputation) | Epoch 0 の availability yield |
| `halving_trigger` | cumulative TRM minted | 半減期のトリガー条件 |
| `epoch_0_threshold` | 10,500,000,000 | Epoch 0 → 1 の閾値 (supply の 50%) |
| `epoch_formula` | `floor(log2(cap / (cap - minted)))` | Epoch 番号の計算式 |

---

## 16. ステーキング (Staking) — Phase 13

| パラメータ | 値 | 説明 |
|---|---|---|
| `staking_7d_min` | 100 TRM | 7 日ロックの最小量 |
| `staking_7d_multiplier` | 1.2 | 7 日ロックの reputation 倍率 |
| `staking_30d_min` | 1,000 TRM | 30 日ロック最小量 |
| `staking_30d_multiplier` | 1.5 | 30 日ロック倍率 |
| `staking_90d_min` | 10,000 TRM | 90 日ロック最小量 |
| `staking_90d_multiplier` | 2.0 | 90 日ロック倍率 |
| `staking_365d_min` | 100,000 TRM | 365 日ロック最小量 |
| `staking_365d_multiplier` | 3.0 | 365 日ロック倍率 |
| `slash_rate_minor` | 0.05 | trust_penalty 0.1-0.2 の slash 率 |
| `slash_rate_major` | 0.20 | trust_penalty 0.2-0.4 |
| `slash_rate_critical` | 0.50 | trust_penalty 0.4-0.5 |

---

## 17. 紹介ボーナス (Referral) — Phase 13

| パラメータ | 値 | 説明 |
|---|---|---|
| `referral_bonus_trm` | 100 | 紹介ボーナス (新規 mint, cap 内) |
| `referral_max_per_node` | 50 | 1 ノードが紹介できる上限 |
| `referral_cooldown_hours` | 24 | 紹介間の最小間隔 |
| `referral_earn_threshold` | 1,000 TRM | 被紹介者がこれだけ稼いだらボーナス発動 |

---

## 18. レアリティスコア (Rarity Scoring) — Phase 13

| パラメータ | 値 | 説明 |
|---|---|---|
| `rarity_common_multiplier` | 1.0 | Small tier (< 3B params) |
| `rarity_uncommon_multiplier` | 1.5 | Medium tier (3-14B) |
| `rarity_rare_multiplier` | 3.0 | Large tier (14-70B) |
| `rarity_legendary_multiplier` | 10.0 | Frontier tier (70B+) |

---

## 19. ガバナンスエポック (Governance) — Phase 13

| パラメータ | 値 | 説明 |
|---|---|---|
| `governance_epoch_sync` | halving | ガバナンスエポック = 半減期エポックと同期 |
| `governance_min_reputation` | 0.7 | 投票に必要な最低 reputation |
| `governance_min_stake` | 1,000 TRM | 投票に必要な最低ステーク |
| `seniority_1_epoch_bonus` | 1.5 | 1-2 エポック経験のシニオリティ |
| `seniority_3_epoch_bonus` | 2.0 | 3+ エポック経験のシニオリティ |

---

## 20. Constitutional Parameters — Phase 18.1 (ガバナンス改変不可)

Phase 18.1 は「プロトコルの核となる不変量は governance で変えられない」
という憲法的ラチェットを導入しました。以下のパラメータは `ChangeParameter`
提案で変更できず、変えるにはソフトウェアのフォークが必要です (つまり、
変えた瞬間それは「Tirami」ではない別物になる)。

実装: `crates/tirami-ledger/src/governance.rs::IMMUTABLE_CONSTITUTIONAL_PARAMETERS` (18 件)。

**経済基盤の不変量**

| パラメータ | 値 | なぜ憲法的か |
|---|---|---|
| `TOTAL_TRM_SUPPLY` | 21 000 000 000 TRM | 上限供給量。変更は全保有者のバランスを希薄化する |
| `FLOPS_PER_CU` | 10⁹ FLOP | 1 TRM の物理的定義。変更は TRM の価値尺度そのものを壊す |
| `HALVING_THRESHOLDS` | 50% / 75% / 87.5% / … | 供給減衰のカーブ。短期の政治で変更すれば信頼崩壊 |

**スラッシング不変量**

| パラメータ | 値 | なぜ憲法的か |
|---|---|---|
| `SLASH_RATE_MINOR` | 10% | 軽微違反の最低ペナルティ。下回れば抑止効果喪失 |
| `SLASH_RATE_MAJOR` | 30% | 重大違反の最低ペナルティ |
| `MIN_PROVIDER_STAKE_CONSTITUTIONAL_FLOOR` | 10 TRM | ステーク最低値の床 (実運用は §23 で 100) |

**暗号・署名不変量**

| パラメータ | 不変条件 | なぜ憲法的か |
|---|---|---|
| `CANONICAL_BYTES_V2` | nonce を含むバイト順序 | 署名検証の再現性。変えれば過去のすべての signed trade が無効化 |
| `SIGNATURE_SCHEME_BASE` | Ed25519 | ベース署名方式。PQ ハイブリッドで増やすのは可、Ed25519 を外すのは不可 |

**ガバナンス・メタ不変量**

| パラメータ | 値 | なぜ憲法的か |
|---|---|---|
| `GOVERNANCE_MIN_STAKE_FLOOR` | 100 TRM | 投票閾値の下限。低すぎる stake で富裕層独占を防ぐ |
| `PROOF_POLICY_RATCHET` | 単調増加のみ | Optional→Recommended→Required は一方向。後退不可 |
| `WELCOME_LOAN_SUNSET_EPOCH` | 2 | ウェルカムローン廃止タイミング (§22 参照) |

対して、ガバナンスで改変可能なパラメータ
(`MUTABLE_GOVERNANCE_PARAMETERS`, 21 件) は:
`WELCOME_LOAN_AMOUNT`, `MAX_LTV_RATIO`, `MIN_RESERVE_RATIO`,
`MAX_LOAN_TERM_HOURS`, `ANCHOR_INTERVAL_SECS`,
`AUDIT_CHALLENGE_INTERVAL_SECS`, `MIN_PROVIDER_STAKE_TRM`,
`STAKELESS_EARN_CAP_TRM`, `PROOF_POLICY` など (詳細: governance.rs)。

---

## 21. 詐欺対策: nonce & 重複署名 — Phase 17.1–17.2

| パラメータ | 値 | 説明 |
|---|---|---|
| `trade_nonce_bits` | 128 | TradeRecord v2 の乱数 nonce 長さ。リプレイ防御 |
| `nonce_cache_per_provider_max` | 10 000 | 1 プロバイダあたり保持する nonce LRU サイズ |
| `nonce_cache_ttl_hours` | 24 | nonce エントリの生存期間 |

Phase 17 Wave 1.2 で `execute_signed_trade` は nonce 重複を拒否。
過去の署名済み trade を再送信する古典的リプレイ攻撃を防ぎます。

---

## 22. ウェルカムローン・サンセット — Phase 18.2

| パラメータ | 値 | 変更可否 |
|---|---|---|
| `WELCOME_LOAN_SUNSET_EPOCH` | 2 | 憲法的 (一方向) |

エポック 2 到達 (≥ 87.5% 供給発行時点) 以降、welcome loan は
恒久的に停止します。Filecoin の bootstrap grant と同じ思想:
「初期は撒くが、ネットワーク成熟後は stake を積まない新規参加を
許さない」— これにより長期的な Sybil 攻撃面を縮小します。

一度 sunset すると戻せません。戻したい operator は
ソフトウェアをフォークする必要があります (フォーク後のネットワーク
を「Tirami」と呼ぶかどうかは community が決める問題)。

実装: `ComputeLedger::can_issue_welcome_loan`。

---

## 23. Stake-Required Mining — Phase 18.2

以前は TRM をゼロ stake でいくらでも稼げた。Phase 18.2 以降、
プロバイダは以下のいずれかを満たす必要があります:

| パラメータ | 値 | 可変性 |
|---|---|---|
| `MIN_PROVIDER_STAKE_TRM` | 100 TRM | ガバナンスで変更可 (ただし §20 の floor = 10 以下にはできない) |
| `STAKELESS_EARN_CAP_TRM` | 10 TRM | ブートストラップの無 stake 許容枠 (一度使い切ると stake が必要) |
| `MIN_PROVIDER_STAKE_CONSTITUTIONAL_FLOOR` | 10 TRM | 憲法床 — これ以下には governance で下げられない |
| `STAKELESS_EARN_CAP_MAXIMUM` | 100 TRM | 無 stake 枠の憲法天井 |

さらに、**過去に slash された** ノードは stakeless 経路を一切使えません
(rehabilitation には stake を積むしかない)。

動機: Phase 17 でスラッシング基盤ができたが、stake のない provider
には teeth がない。stake を全員に要求することで、経済的コストを伴う
違反抑止を機能させる。

実装: `ComputeLedger::can_provide_inference(node, &StakingPool, now)`。

---

## 24. ProofPolicy ラチェット — Phase 18.3

zkML (zero-knowledge ML proof-of-inference) の段階的導入ゲート。
4 状態を単調増加でラチェット:

| 状態 | u8 値 | 意味 |
|---|---|---|
| `Disabled` | 0 | 証明を一切参照しない (Phase 17 以前のデフォルト) |
| `Optional` | 1 | 証明付きなら reputation ボーナス (Phase 19 デフォルト) |
| `Recommended` | 2 | 証明無しは audit tier ペナルティ |
| `Required` | 3 | 証明無しの trade は ledger で拒否 (Constitutional: 到達後は不可逆) |

| パラメータ | 値 | 可変性 |
|---|---|---|
| `PROOF_POLICY` | Optional | ガバナンスで単調増加のみ可 |
| `PROOF_POLICY_RATCHET` | monotonic | 憲法的 (下げるな) |

実装: `crates/tirami-ledger/src/zk.rs::ProofPolicy`、
`try_ratchet_proof_policy` で下げる変更を reject。

候補バックエンド (`crates/tirami-zkml-bench`):
- ezkl (primary, ONNX-native) — Phase 20 統合予定
- risc0 (secondary, Rust-native 証明)
- halo2_proofs (SPoRA カスタム回路用)

---

## 25. Secondary Markets & Tokenization — Phase 19 (規範的)

Tirami は MIT ライセンスの OSS です。TRM は**計算の会計単位**で
あって、金融商品ではありません。Phase 19 以降、repo ルート
(`SECURITY.md`、`README.md`、`docs/deployments/README.md`) に
以下の立場が明文化されています:

- メンテナは TRM を ICO / pre-sale / airdrop / private round で販売しない。
- メンテナは第三者による二次市場・ブリッジ・デリバティブから
  revenue share を受けない。
- OSS ゆえに、メンテナの知らないところで第三者が TRM を
  ブリッジ・上場・投機することを**技術的に防ぐ手段はない**。
- そのような二次市場リスクは**保有者・取引者が自己責任で引き受ける**。

この立場は `1 TRM = 10⁹ FLOP` という物理定義 (§1) と矛盾しません。
TRM は市場価格ゼロでも「計算と交換できる会計単位」として機能し、
それが本義です。

Mainnet deploy ゲート (`repos/tirami-contracts/Makefile`):

| パラメータ | 値 | 説明 |
|---|---|---|
| `AUDIT_CLEARANCE` | 環境変数 (`yes` 必須) | 外部セキュリティ監査完了の宣言 |
| `MULTISIG_OWNER` | 環境変数 (非空必須) | `Ownable::owner` の譲渡先 (multi-sig) |
| `i-accept-responsibility` | 対話プロンプト入力必須 | オペレータが責任を明示的に引き受けた証跡 |

上記を全て満たさない限り `make deploy-base-mainnet` は実行を拒否します。

---

## 変更履歴

- v0.1 (2026-04): 初版作成 (M-6)
- v0.2 (2026-04-07): §10-§12 追加 (L2/L3/L4 Rust rewrite)
- v0.3 (2026-04-09): §13 追加 (Phase 11/12 サンプリング + ファンクションコーリング)
- v0.4 (2026-04-13): §14-§19 追加 (Phase 13 Growth Incentives)。
  Supply cap 21B TRM、半減期、ステーキング、Slashing、紹介ボーナス、
  レアリティスコア、ガバナンスエポック。
  詳細は `spec/tokenomics.md` と `spec/game-theory.md` を参照。
- v0.5 (2026-04-19): §20-§25 追加 (Phase 17-19 security + Tier C/D enablers)。
  Constitutional parameters (憲法的ラチェット)、nonce & replay 対策、
  welcome loan サンセット、stake-required mining、ProofPolicy ラチェット、
  secondary-market disclaimer。詳細は
  `tirami/docs/constitution.md`、`tirami/docs/zkml-strategy.md`、
  `tirami/SECURITY.md` を参照。

---

## 参照先

このファイルを参照する文書:
- spec/forge-economics-spec-v0.1.md
- spec/forge-economics-spec-v0.2.md (planned)
- docs/02-money.md (TRM 供給量)
- docs/03-supply-demand.md (動的価格)
- docs/05-banking.md (レンディング全般)
- docs/06-exchange.md (為替)
- docs/07-growth.md (収穫逓減 yield)

このファイルを参照する Rust クレート (clearclown/tirami workspace):
- `crates/tirami-ledger/src/lending.rs` — §3〜§7 (lending primitives)
- `crates/tirami-bank/src/*.rs` — §10 (strategies, futures, insurance, risk)
- `crates/tirami-mind/src/*.rs` — §11 (TRM budget, ROI gates)
- `crates/tirami-agora/src/*.rs` — §12 (reputation, capability matching)
- `crates/tirami-node/src/api.rs` — §13 (sampling + streaming + tools)
