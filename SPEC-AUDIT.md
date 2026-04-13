# Tirami Economics — 仕様書監査レポート

> 現在のリポジトリ状態と「あるべき姿」の差分監査
> 監査日: 2026-04-07

このドキュメントは、`tirami-economics` リポジトリの現状と、宣言された仕様 (`spec/forge-economics-spec.md` v0.1) および README の主張との間にある乖離を網羅的に列挙します。各項目には対応する GitHub Issue 番号が紐付けられます。

---

## 1. 監査の範囲

| 対象 | 内容 |
|------|------|
| `README.md` | プロジェクト概要、目次、参考文献の主張 |
| `spec/forge-economics-spec.md` | v0.1 仕様書（凍結を主張） |
| `docs/00-introduction.md` 〜 `docs/14-programmable-money.md` | 本編 15 章 |
| `docs/appendix-glossary.md`, `docs/appendix-bibliography.md` | 付録 |
| `CLAUDE.md` | リポジトリ開発ガイド |
| 必須メタファイル群 (`LICENSE`, `CONTRIBUTING.md`, `CHANGELOG.md`) | リポジトリインフラ |

---

## 2. 重大度別の発見事項

### 🔴 Critical — 即時修正が必要

| ID | 問題 | 詳細 |
|----|------|------|
| C-1 | **TRM 定義の数値矛盾** | `README.md:21` は `1 TRM = 1 億回の検証済み推論演算` と記述。一方 `spec/forge-economics-spec.md:57`、`docs/01-value.md`、`docs/02-money.md` 等すべての他ドキュメントは `1 TRM = 10 億 FLOP` と記述。**100 倍の差**があり、TRM 経済の根本数値が矛盾している。 |
| C-2 | **`books/` フォルダが存在しない** | `README.md:58-60` と `CLAUDE.md:25-27` が `books/ミクロ経済学.pdf`, `books/マクロ経済学.pdf`, `books/賃金価格および利潤.pdf` を参照しているが、`books/` フォルダ自体が存在しない。リンクが完全に切れている。 |
| C-3 | **`LICENSE` ファイルが存在しない** | `README.md:138` が `MIT` ライセンスを宣言しているが、`LICENSE` ファイルが実在しない。OSS として法的に欠陥状態。 |

### 🟠 High — 仕様書とドキュメントの整合性

| ID | 問題 | 詳細 |
|----|------|------|
| H-1 | **spec が docs より古い** | `spec/forge-economics-spec.md` は Part 1〜10 のみ。しかし `docs/` には Chapter 11, 12, 13, 14 が存在する。README は「凍結された v0.1 仕様書（docs/ の各章はここから展開）」と主張するが、docs の方が拡張されており逆転している。 |
| H-2 | **glossary が新章をカバーしていない** | `docs/appendix-glossary.md` は Chapter 1〜10 までのリンクのみで、Chapter 11 (競合分析), 12 (P2P アーキテクチャ), 13 (残された課題), 14 (プログラマブルマネー) で導入された用語（zkML, gossipsub, JPYC, CBDC, ハイブリッド L2 等）を含まない。 |
| H-3 | **bibliography が 2013 で停止** | `docs/appendix-bibliography.md` の系譜図は Piketty (2013) で終わり、2008 Bitcoin 以降の AI 経済学・分散コンピュート関連文献（Bittensor 論文、Akash 設計、AutoAgent 論文、Sam Altman の公開記事等）が一切ない。 |
| H-4 | **glossary に TRM 定義の不整合を含むリスク** | `docs/appendix-glossary.md:71` は正しく `1 TRM = 10 億 FLOP` だが、README の C-1 と整合させるための監査と対策が必要。 |
| H-5 | **CLAUDE.md の構成宣言と実態の乖離** | `CLAUDE.md:35-64` が `books/`, `docs/books/` を含むディレクトリ構成を宣言。実態と一致しない。`spec/` を「凍結」と書きつつ実際は更新が必要。 |

### 🟡 Medium — 内部整合性

| ID | 問題 | 詳細 |
|----|------|------|
| M-1 | **chapter 13 が存在しない issue を参照** | `docs/13-open-questions.md:49` が `tirami-economics GitHub リポジトリの Issues #4〜#8` を批判の出典として引用。しかし当該リポジトリの issue は本監査で初めて作成されるため、現時点で issue #4〜#8 は存在しない。引用の整合性が崩れている。 |
| M-2 | **README 目次に章 11-14 が新設されたが、仕様書から派生していない** | README は Chapter 0-14 を目次として提示するが、これらは spec から「展開された」ものではない。新章は spec の更新もしくは v0.2 spec 作成が必要。 |
| M-3 | **イントロの目次マップ (00-introduction.md) が古い** | `docs/00-introduction.md:200-203` の章一覧は `00-11` のみ。Chapter 12, 13, 14 が含まれていない。 |
| M-4 | **CHANGELOG.md が存在しない** | spec が `Version 0.1` を名乗り、README も `v0.1` と書くが、変更履歴を追跡する CHANGELOG.md がない。 |
| M-5 | **CONTRIBUTING.md が存在しない** | OSS リポジトリだがコントリビューションガイドがない。経済学の議論やドキュメント校正の方針が不明。 |
| M-6 | **welcome loan の数値が複数箇所で重複定義** | `1,000 TRM, 0% 金利, 72 時間` が spec, glossary, chapter 5, chapter 9 などに散在。シングルソース化されていないため将来の変更時に矛盾を生むリスク。 |

### 🟢 Low — エンハンスメント

| ID | 問題 | 詳細 |
|----|------|------|
| L-1 | **英語版が存在しない** | すべて日本語のみ。国際読者向けに英訳が必要だが、CLAUDE.md は「国際版が必要になれば後から英訳する」と保留中。 |
| L-2 | **CI / 自動検証がない** | リンク切れチェック、用語整合性チェック、Mermaid レンダー検証等の自動化がない。手動監査に依存。 |
| L-3 | **章ごとの個別 ToC がない** | 各章は長文（一部 1,000 行以上）だが、章内ナビゲーションがない。読者体験の改善余地。 |
| L-4 | **Mermaid フォールバック ASCII の保守負担** | `appendix-bibliography.md` は Mermaid と ASCII の二重メンテナンス。GitHub では Mermaid がレンダーされるため、片方のみで十分かを再評価すべき。 |
| L-5 | **読書時間の見積もりが章数に追従していない** | `docs/00-introduction.md:217` は「全 13 ファイル」と書くが、現在は 17 ファイル（chapter 0-14 + 付録 A/B）。読了時間も古い。 |
| L-6 | **tirami 本体への相互参照が薄い** | docs から `tirami` リポジトリの該当 Rust コードへの直リンクがほぼない。「実装と理論の橋渡し」が弱い。 |

---

## 3. 是正方針

### Phase A: Critical fixes（最優先 — 1 セッション内に完了）

1. C-1: README の `1 億回` を `10 億 FLOP` に修正
2. C-3: `LICENSE` ファイル（MIT）を作成
3. C-2: `books/` フォルダを作成し、参考文献の置き場所を明示。書籍 PDF を入れない場合は README の参考文献セクションを「外部リンク参照」形式に変更

### Phase B: Spec 同期（H 系全項目）

4. H-1: `spec/forge-economics-spec.md` を v0.2 に更新するか、`spec/forge-economics-spec-v0.2.md` を作成して Chapter 11-14 の内容を組み込む
5. H-2: `docs/appendix-glossary.md` に Chapter 11-14 の新用語を追加
6. H-3: `docs/appendix-bibliography.md` を Bitcoin 後の AI 経済学文献まで拡張
7. H-5: `CLAUDE.md` のディレクトリ構成宣言を実態に合わせる

### Phase C: Internal consistency（M 系全項目）

8. M-1: Chapter 13 が引用する Issue #4-#8 を実際に作成するか、引用形式を「想定される批判」に書き換える
9. M-3: `docs/00-introduction.md` の章マップに 12, 13, 14 を追加
10. M-4: `CHANGELOG.md` を作成し、v0.1 → 現在までの変更を記録
11. M-5: `CONTRIBUTING.md` を作成
12. M-6: 数値定数を `spec/parameters.md` に集約しシングルソース化

### Phase D: Enhancement（L 系）

13. L-1: 英訳プロジェクトを別途立ち上げ
14. L-2: GitHub Actions で markdown lint, link check, mermaid validation を導入
15. L-3: 章内 ToC を自動生成スクリプトで挿入
16. L-6: `tirami` リポジトリへの相互参照リンクを各章に追加

---

## 4. 影響範囲マトリクス

| ファイル | 修正必要数 | Critical | High | Medium | Low |
|---------|----------|----------|------|--------|-----|
| `README.md` | 3 | C-1, C-3 (リンク追加) | H-3 関連 | M-2 | L-1 |
| `spec/forge-economics-spec.md` | 2 | — | H-1 | M-6 | — |
| `docs/00-introduction.md` | 2 | — | — | M-3, L-5 | — |
| `docs/13-open-questions.md` | 1 | — | — | M-1 | — |
| `docs/appendix-glossary.md` | 1 | — | H-2 | — | — |
| `docs/appendix-bibliography.md` | 1 | — | H-3 | — | L-4 |
| `CLAUDE.md` | 1 | — | H-5 | — | — |
| `LICENSE` (新規) | 1 | C-3 | — | — | — |
| `CHANGELOG.md` (新規) | 1 | — | — | M-4 | — |
| `CONTRIBUTING.md` (新規) | 1 | — | — | M-5 | — |
| `books/` (新規) | 1 | C-2 | — | — | — |

---

## 5. Issue 一覧

各発見事項に対応する GitHub Issue を作成済み。

| ID | Issue | タイトル | ラベル |
|----|-------|--------|-------|
| C-1 | [#24](https://github.com/clearclown/tirami-economics/issues/24) | README の TRM 定義 (1 億 → 10 億) を修正 | critical, documentation, consistency |
| C-2 | [#25](https://github.com/clearclown/tirami-economics/issues/25) | `books/` フォルダを作成、リンク切れを修正 | critical, missing-content, infrastructure |
| C-3 | [#26](https://github.com/clearclown/tirami-economics/issues/26) | `LICENSE` ファイル (MIT) を作成 | critical, infrastructure |
| H-1 | [#27](https://github.com/clearclown/tirami-economics/issues/27) | spec を v0.2 に更新 (Chapter 11-14 を反映) | high, spec-update, consistency |
| H-2 | [#28](https://github.com/clearclown/tirami-economics/issues/28) | glossary に Chapter 11-14 の新用語を追加 | high, documentation, consistency |
| H-3 | [#29](https://github.com/clearclown/tirami-economics/issues/29) | bibliography を AI 経済学時代まで拡張 | high, documentation |
| H-5 | [#30](https://github.com/clearclown/tirami-economics/issues/30) | CLAUDE.md のディレクトリ宣言を実態に合わせる | high, documentation, consistency |
| M-1 | [#31](https://github.com/clearclown/tirami-economics/issues/31) | Chapter 13 の Issue #4-#8 引用を解決 | medium, consistency |
| M-3 | [#32](https://github.com/clearclown/tirami-economics/issues/32) | 序章 (00-introduction) の章マップを更新 | medium, documentation, consistency |
| M-4 | [#33](https://github.com/clearclown/tirami-economics/issues/33) | CHANGELOG.md を作成 | medium, infrastructure |
| M-5 | [#34](https://github.com/clearclown/tirami-economics/issues/34) | CONTRIBUTING.md を作成 | medium, infrastructure |
| M-6 | [#35](https://github.com/clearclown/tirami-economics/issues/35) | 数値定数をシングルソース化 (spec/parameters.md) | medium, spec-update |
| L-1 | [#36](https://github.com/clearclown/tirami-economics/issues/36) | 英語版翻訳プロジェクトの立ち上げ | low, i18n, translation |
| L-2 | [#37](https://github.com/clearclown/tirami-economics/issues/37) | CI による自動検証 (markdown lint, link check) | low, infrastructure |
| L-3 | [#38](https://github.com/clearclown/tirami-economics/issues/38) | 章内 ToC を自動生成 | low, documentation |
| L-6 | [#39](https://github.com/clearclown/tirami-economics/issues/39) | tirami リポジトリへの相互参照を追加 | low, documentation |

---

*この監査は 2026-04-07 時点の repository state に対するものです。修正が進むにつれて随時更新されます。*
