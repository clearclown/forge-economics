# Tirami Economics — 開発ガイド

## このリポジトリの目的

Tirami の経済理論を、**経済学未履修者でも理解できる形で**再定義・文書化するプロジェクト。

従来の経済学（ミクロ・マクロ・マルクス経済学）の概念を、Tirami の TRM（Compute Unit）経済に写像し直すことで、「経済学とは何か」を AI ネイティブ経済の視点から説明する。

## 基本方針

### 1. 読者は経済学初心者

- 専門用語を使う場合は必ず平易な説明を添える
- 抽象概念は Tirami の具体例で示す（「需要と供給」→「TRM の価格がどう決まるか」）
- 数式は最小限。使う場合は直感的な図解を併記する

### 2. 従来経済学 → Tirami 経済学の対応表を軸にする

すべてのドキュメントは「従来の経済学ではこう説明される → Tirami ではこうなる」の構造を持つ。読者は伝統的な経済学の知識も同時に得られる。

### 3. 三つの源流を参照する

著作権の都合により、参考書の PDF は同梱せず外部リンクで参照する。書誌情報とリンクは [`books/README.md`](books/README.md) を参照すること。

| 源流 | 書籍 | Tirami への接続点 |
|------|------|-----------------|
| ミクロ経済学 | Mankiw / Krugman / OpenStax ほか（[`books/README.md`](books/README.md)） | 需給・価格形成・市場均衡 → TRM 動的価格決定 |
| マクロ経済学 | Mankiw / Krugman / OpenStax ほか（[`books/README.md`](books/README.md)） | 貨幣供給・金融政策・GDP → TRM 供給弾力性・ネットワーク成長 |
| マルクス経済学 | マルクス『賃金・価格および利潤』（[Marxists Internet Archive](https://www.marxists.org/japanese/marx-engels/value-price-profit/)） | 労働価値説・剰余価値 → Proof of Useful Work・TRM yield |

### 4. Tirami プロトコルの正確な反映

経済理論は [tirami](https://github.com/clearclown/tirami) の実装と矛盾してはならない。TRM の定義、取引の仕組み、レンディングのルール等は `tirami/WHITEPAPER.md` および `tirami/CLAUDE.md` を正とする。

## リポジトリ構成

```
tirami-economics/
├── CLAUDE.md                          ← このファイル（開発ガイド）
├── README.md                          ← プロジェクト概要・初心者向け導入
├── CHANGELOG.md                       ← 変更履歴（Keep a Changelog 準拠）
├── CONTRIBUTING.md                    ← コントリビューションガイド
├── LICENSE                            ← ライセンス
├── SPEC-AUDIT.md                      ← 仕様 ⇔ docs ギャップ分析・監査記録
├── spec/
│   ├── forge-economics-spec-v0.1.md   ← 凍結された v0.1 仕様書（変更しない）
│   ├── forge-economics-spec-v0.2.md   ← 現行 v0.2 仕様書（Parts 11–14 を含む）
│   └── parameters.md                  ← 数値定数の単一ソース（SSOT）
├── books/                             ← 参考文献（外部リンク集）
│   └── README.md                      ← 書誌情報・外部リンク（PDF は同梱しない）
├── docs/                              ← 教育コンテンツ（日本語・主要成果物）
│   ├── 00-introduction.md             ← 序章：なぜ経済学を「やり直す」のか
│   ├── 01-value.md                    ← 第1章：価値とは何か
│   ├── 02-money.md                    ← 第2章：貨幣とは何か
│   ├── 03-supply-demand.md            ← 第3章：需要と供給
│   ├── 04-labor.md                    ← 第4章：労働と剰余価値
│   ├── 05-banking.md                  ← 第5章：銀行と信用
│   ├── 06-exchange.md                 ← 第6章：為替と二つの経済圏
│   ├── 07-growth.md                   ← 第7章：経済成長と自己改善
│   ├── 08-market-failures.md          ← 第8章：市場の失敗と Tirami の解決
│   ├── 09-actors.md                   ← 第9章：四つの経済主体
│   ├── 10-principles.md               ← 第10章：Tirami 経済学の五つの原理
│   ├── 11-competitive-landscape.md    ← 第11章：競合分析（Web 3.0 / クラウド対抗含む）
│   ├── 12-p2p-architecture.md         ← 第12章：P2P アーキテクチャ
│   ├── 13-open-questions.md           ← 第13章：残された課題と将来の研究（15問題）
│   ├── 14-programmable-money.md       ← 第14章：プログラマブルマネーとハイブリッド L2 戦略
│   ├── appendix-glossary.md           ← 付録A：用語対応表
│   ├── appendix-bibliography.md       ← 付録B：参考文献の系譜
│   └── en/                            ← 英訳スケルトン（将来の国際版）
│       └── README.md
├── scripts/
│   └── verify-audit.sh                ← TDD 回帰テスト（仕様と docs の整合性チェック）
└── .github/
    └── workflows/
        └── docs-check.yml             ← CI：ドキュメント整合性の自動検証
```

### ディレクトリの役割

- **`spec/`** — 仕様書ディレクトリ。`v0.1` は凍結版（変更しない）、`v0.2` が現行版で Parts 11–14（競合分析・P2P・残課題・プログラマブルマネー）を含む。`parameters.md` は TRM 発行レート・利率・閾値などあらゆる数値定数の **単一ソース（Single Source of Truth）** であり、`docs/` や仕様書本体で値を書く場合は必ずここを参照する。
- **`docs/`** — 生きた教育コンテンツ。仕様書を章ごとに分割し、説明・図解・具体例を追加したもの。継続的に改善する。`docs/en/` は将来の英訳用スケルトン。
- **`books/`** — 参考文献は外部リンクで参照する（著作権の都合で PDF は同梱しない）。`books/README.md` に書誌情報と公式リンクをまとめる。
- **`scripts/verify-audit.sh`** — 仕様書と docs の整合性を機械的に検証する TDD 回帰テスト。CI（`.github/workflows/docs-check.yml`）から自動実行され、ローカルでも `bash scripts/verify-audit.sh` で走らせられる。
- **`SPEC-AUDIT.md`** — 仕様書と docs の差分・未解決項目・改訂履歴を記録するギャップ分析ドキュメント。大きな改訂を行う前に必ず参照する。
- **`CHANGELOG.md` / `CONTRIBUTING.md` / `LICENSE`** — リポジトリ運用の基礎文書。

## ドキュメント執筆規約

### 言語

- 本文: **日本語**（国際版が必要になれば後から英訳する）
- 技術用語・固有名詞: 初出時に英語表記を併記（例: 需要と供給（Supply and Demand））
- コード例・API パス: 英語のまま

### 構造

各章は以下の構造を推奨:

```markdown
## 章タイトル

### 従来の経済学では
（伝統的な説明。教科書レベル。）

### Tirami ではどうなるか
（TRM 経済への写像。具体例とコード/図を含む。）

### なぜ違うのか
（従来モデルとの本質的な差異。Tirami が解決する問題。）
```

### 図解

- ASCII art を積極的に使う（Mermaid も可）
- 対比表（従来 vs Tirami）を多用する
- 数式よりも具体的な数値例を優先する

## 関連リポジトリ

| リポジトリ | 役割 | 参照すべき場面 |
|-----------|------|---------------|
| [tirami](https://github.com/clearclown/tirami) | プロトコル実装（Rust） | TRM 定義、API 仕様、安全機構の正確な仕様確認 |
| [forge-mesh](https://github.com/nm-arealnormalman/mesh-llm) | 分散推論ランタイム | 推論レイヤーの技術的詳細 |
| tirami-economics（ここ） | 経済理論・教育ドキュメント | — |

## コマンド

このリポジトリにビルドやテストはない。ドキュメントのみ。

```bash
# PDF の文字抽出（参考文献の確認用）
pdftotext "books/賃金価格および利潤.pdf" -

# Git 操作
git status
git add -A && git commit -m "メッセージ"
```
