# 15. 憲法的パラメータ — 改変不能な経済不変量

> 中央銀行がない経済で、なぜ「供給上限は 21 億 TRM」という
> ルールが守られ続けるのか。答えは「governance で変えられない
> から」だ。

Phase 17 以前の Tirami には、実はある穴があった。`ChangeParameter`
というガバナンス提案で、理論上は**どんな**パラメータも変えられて
しまった。例えば stake weighted majority を集めた派閥が
`TOTAL_TRM_SUPPLY` を 21 億から 210 億に書き換えることが、技術的には
可能だった。

これは、**信頼性が命**のプロトコルにとって致命的な穴である。

Phase 18.1 (Constitution) はこの穴を塞ぐ。本章では「なぜ一部の
パラメータは governance で変更できないべきなのか」を、従来の
経済学の「憲法と中央銀行の独立性」と比較しながら説明する。

---

## 15.1 ビットコインの 21,000,000 という数字

ビットコインの総供給量は **2,100 万 BTC**。Satoshi の最初のコードに
書かれた `MAX_MONEY = 21_000_000 * COIN` という行がそれを定義する。

なぜ 2,100 万?
- Satoshi は論理的理由を一度も説明していない。
- そもそも「2,100 万である必要」はない。
- 重要なのは数字そのものではなく、「**15 年経っても誰も変えられない
  でいる**」という事実の方だ。

ビットコインのハードコードされた供給上限は、コア開発者たちの
**慣習と政治的合意**で守られている。技術的には「client の
MAX_MONEY 定数を書き換えて再コンパイル」すれば破れるが、
- それは過去 15 年間のすべてのウォレット・取引所・ノードが
  新しいバージョンを一斉に受け入れる必要があり、
- 受け入れない陣営と分裂 (fork) して**別のコイン**になる、

という社会的コストが膨大。だからこそ「21 M は変わらない」という
信頼が生まれた。

---

## 15.2 ビットコインモデルの脆さ

しかし、これはあくまで**社会契約**であって、技術的な強制ではない。

- 2025 年現在、ビットコインのフルノードソフトウェアは数十の
  派閥によってメンテされている。
- いつか「インフレ圧力を受けて 21 M を 42 M にしよう」と提案する
  派閥が現れても、コードレベルでは **ifブロック 1 つ書き換える
  だけ**で実装できる。
- それを却下する根拠は「community がそう決めていないから」
  という人間側の合意だけ。

これは、創業者が去った後のプロトコルにとって脆い。Ethereum の
DAO hard fork (2016) が示したように、「コア開発者の多数派」が
決意すればチェーンは書き換わる。

Tirami はこの脆さを、**コードレベルで強制する** ことで回避する。

---

## 15.3 Constitutional Parameters の導入

Phase 18.1 で Tirami のコードベースには 2 つのリストが追加された:

```rust
// crates/tirami-ledger/src/governance.rs
pub const MUTABLE_GOVERNANCE_PARAMETERS: &[&str] = &[
    "WELCOME_LOAN_AMOUNT",
    "MAX_LTV_RATIO",
    "MIN_RESERVE_RATIO",
    // ... 21 entries
];

pub const IMMUTABLE_CONSTITUTIONAL_PARAMETERS: &[&str] = &[
    "TOTAL_TRM_SUPPLY",           // 21,000,000,000
    "FLOPS_PER_CU",                // 10^9
    "SLASH_RATE_MINOR",            // 10%
    "SLASH_RATE_MAJOR",            // 30%
    "CANONICAL_BYTES_V2",          // 署名の正準バイト順
    "SIGNATURE_SCHEME_BASE",       // Ed25519
    "PROOF_POLICY_RATCHET",        // 単調増加
    "WELCOME_LOAN_SUNSET_EPOCH",   // 2
    // ... 18 entries
];
```

そして `create_proposal` は、提案されたパラメータ名が
`IMMUTABLE_CONSTITUTIONAL_PARAMETERS` に含まれる (または
`MUTABLE_GOVERNANCE_PARAMETERS` のどちらにも含まれない未知の名前)
場合、**提案を受理しない**。

結果として:
- `TOTAL_TRM_SUPPLY = 21 B` を governance で 210 B に変えることは**できない**。
- `FLOPS_PER_CU = 10⁹` を変えることも**できない** (変えたら TRM は
  別の単位になる)。
- ソフトウェアをフォークして `const` を書き換えれば可能だが、
  **それはもはや Tirami ではない**。

これは ビットコイン と同じ「社会契約による守り」に加えて、
**コードレベルで検査される**ラチェットを重ねたもの。

---

## 15.4 憲法と中央銀行の独立性

従来の経済学で類似の構造を見てみる。**中央銀行の独立性**だ。

- 連邦準備制度 (Fed) / 日本銀行 / ECB 等は、形式上は政府から
  独立しているが、実際には政治的圧力を受ける (Fed 議長の指名、
  総裁への呼び出し等)。
- しかし憲法的な改変 (=立法) で中央銀行の設立法を書き換える
  ことは可能である。
- 実際、**ベネズエラ・ジンバブエ・トルコ**では、政権が通貨政策を
  政治的に操作した結果、ハイパーインフレ、通貨切り下げが起きた。

これが人間の経済における教訓:「守るための仕組み」もまた、
**人間が変えられる**ために守られない。

Tirami の Constitution は、この問題を技術的に解決する:
- 「守るための仕組み」のコードは、governance で書き換えられない。
- 書き換えるにはフォークしかなく、フォークすれば既存ユーザー・
  ノードは元のチェーンに残る (社会的コスト)。

---

## 15.5 可変 vs 不変の線引き

どのパラメータが憲法的で、どれが可変か。線引きは単純ではない。
Phase 18.1 では以下の原則で分類した:

### 憲法的 (Constitutional) に入れるべき

1. **経済の根幹に位置する定義**
   - `TOTAL_TRM_SUPPLY` — これを変えると保有者の相対的持分が変わる。
   - `FLOPS_PER_CU` — TRM の価値尺度そのもの。
   - `HALVING_THRESHOLDS` — 長期のインフレ軌道。

2. **攻撃を抑止するペナルティの下限**
   - `SLASH_RATE_MINOR`、`SLASH_RATE_MAJOR` — 低くしすぎれば
     collusion / Sybil 攻撃のコストが消える。

3. **暗号プリミティブの互換性**
   - `CANONICAL_BYTES_V2` — 署名バイト順序。変わると過去の
     dual-signed trades が検証不能になる。
   - `SIGNATURE_SCHEME_BASE` — Ed25519 を外せない。

4. **一方向性ゲート**
   - `PROOF_POLICY_RATCHET` — Optional → Recommended → Required の
     昇格は可、後退は不可。
   - `WELCOME_LOAN_SUNSET_EPOCH` — 一度閉じたら戻せない。

### 可変 (Mutable) に残すべき

1. **運用上の調整値**
   - `MAX_LTV_RATIO` (3:1) — 運用経験に応じて 2:1 にも 4:1 にも
     できる。これを硬直化させたら過小融資・過大融資の失敗を
     修正できない。
   - `WELCOME_LOAN_AMOUNT` (1,000 TRM) — 経済規模に応じて調整可。

2. **技術パラメータ**
   - `ANCHOR_INTERVAL_SECS` (3600) — on-chain anchor の頻度。
     gas 価格に応じて調整する運用知識。
   - `AUDIT_CHALLENGE_INTERVAL_SECS` — 監査頻度。

3. **経済実験の余地**
   - `MIN_PROVIDER_STAKE_TRM` (100) — stake 床は可変だが、
     下げすぎ防止のため `MIN_PROVIDER_STAKE_CONSTITUTIONAL_FLOOR = 10`
     という「憲法床」を持つ。これが「可変 but 憲法制約」の好例。

---

## 15.6 なぜ金額 / 金利ではなく「相対構造」を守るのか

ここで重要な観察がある。Tirami の憲法的パラメータの多くは
**絶対値**ではなく**相対構造**だ:

- `TOTAL_TRM_SUPPLY = 21 B` は絶対値だが、その意味は「この数字を
  超えない」という相対関係で守られる。
- `SLASH_RATE_MINOR = 10%` は絶対値だが、「違反あたりのコスト」
  という相対関係が本義。
- `HALVING_THRESHOLDS` は半減曲線の形状という相対関係。

対して可変パラメータは「絶対値そのものに意味がある」ことが多い:
- welcome loan = 1,000 TRM — なぜ 1,000? 経済規模次第。
- LTV = 3:1 — なぜ 3? 試行錯誤で決まる。

つまり憲法は「**不可能な変化を禁じる**」もので、具体値は変わりうる。
これは米国憲法と法律の関係に似ている (憲法は「議会の定数は
議員 1 人あたり 3 万人を超えない」のような相対性を規定し、
具体の選挙区数は州法が決める)。

---

## 15.7 実装の検証可能性

Constitutional の本質は「**第三者が検証できる**」こと。Tirami では
監査人が以下の 1 行を実行すれば、すべての不変パラメータが
列挙される:

```bash
cargo run -p tirami-ledger --example dump-governance-lists
# → MUTABLE_GOVERNANCE_PARAMETERS: 21 entries
# → IMMUTABLE_CONSTITUTIONAL_PARAMETERS: 18 entries
```

この透明性は「憲法改正にはフォーク以外の道がない」という主張を
検証可能にする。監査人は:
- `governance.rs` の 2 つのリストを読む。
- `create_proposal` が `IMMUTABLE_*` の名前を受け付けないことを
  ユニットテスト (12 件) で確認する。
- PR のどれかが `IMMUTABLE_*` から項目を削除していないか
  git blame を読む。

これが、「不変性は社会契約」ではなく「不変性は機械検査」として
成立する仕組みである。

---

## 15.8 経済学的含意 — Credible Neutrality

Vitalik Buterin が提唱した **Credible Neutrality (信頼できる
中立性)** という概念がある。プロトコルが公平であるためには、
「開発者も含め、誰も恣意的にルールを曲げられない」ことが
示されている必要がある、という原則。

Tirami の Constitution はこの Credible Neutrality を実装する:
- 開発者は governance 提案ができない (そもそも governance に
  stake が必要)。
- 開発者は憲法的パラメータを変えられない (governance の経路が
  塞がれている)。
- 開発者は唯一「フォーク」しかできないが、フォーク後のネットワーク
  は「別物」として扱われる (ユーザーとノードが残る方を使う)。

これが、Bitcoin の社会契約 + Ethereum のフォーク文化 + Tirami の
コードレベル検査を重ねた結果の姿である。

---

## 次章へ

§16 では、憲法的ラチェットの具体例として「stake-required mining」
を扱う。「TRM を稼ぐには stake が必要」というルールを、Phase 18.2 で
どう段階的に導入したか、なぜ旧世代ノード (stake なし) の後方互換を
残しつつ新世代で shift できるかを議論する。

参照:
- 実装: `crates/tirami-ledger/src/governance.rs`
- 設計論: `tirami/docs/constitution.md` (英語)
- パラメータ表: `spec/parameters.md § 20`
