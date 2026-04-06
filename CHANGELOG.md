# Changelog

このプロジェクトの変更履歴。フォーマットは [Keep a Changelog](https://keepachangelog.com/ja/1.0.0/) に準拠し、バージョニングは [Semantic Versioning](https://semver.org/lang/ja/) を採用しています。

## [Unreleased]

### Added
- SPEC-AUDIT.md (現状監査レポート)
- scripts/verify-audit.sh (TDD 形式の回帰テスト)
- LICENSE (MIT)
- CONTRIBUTING.md
- CHANGELOG.md (このファイル)
- spec/parameters.md (数値定数のシングルソース)
- books/README.md (参考文献の外部リンク化)
- docs/en/ ディレクトリ (英訳プロジェクトのスケルトン)
- .github/workflows/docs-check.yml (CI 検証)
- spec/forge-economics-spec-v0.2.md (Chapter 11-14 を含む拡張版)

### Changed
- README.md: CU 定義を「1 億回」から「10 億 FLOP」に修正 (#24)
- spec/forge-economics-spec.md → spec/forge-economics-spec-v0.1.md (rename)
- docs/appendix-glossary.md: Chapter 11-14 由来の新用語を追加
- docs/appendix-bibliography.md: 2008 年以降の AI 経済学文献を追加
- docs/00-introduction.md: 章マップに Chapter 12, 13, 14 を追加
- CLAUDE.md: ディレクトリ宣言を実態に合わせ、`docs/books/（予約）` を削除
- 主要章 (3, 4, 5, 6) に forge 本体への相互参照リンクを追加

## [0.1.0] - 2026-04-XX

### Added
- spec/forge-economics-spec.md v0.1 (Part 1-10)
- docs/00-introduction.md (序章)
- docs/01-value.md (第1章: 価値とは何か)
- docs/02-money.md (第2章: 貨幣とは何か)
- docs/03-supply-demand.md (第3章: 需要と供給)
- docs/04-labor.md (第4章: 労働と剰余価値)
- docs/05-banking.md (第5章: 銀行と信用)
- docs/06-exchange.md (第6章: 為替と二つの経済圏)
- docs/07-growth.md (第7章: 経済成長と自己改善)
- docs/08-market-failures.md (第8章: 市場の失敗と Forge の解決)
- docs/09-actors.md (第9章: 四つの経済主体)
- docs/10-principles.md (第10章: Forge 経済学の五つの原理)
- docs/11-competitive-landscape.md (第11章: 競合分析)
- docs/12-p2p-architecture.md (第12章: P2P アーキテクチャ)
- docs/13-open-questions.md (第13章: 残された課題)
- docs/14-programmable-money.md (第14章: プログラマブルマネー)
- docs/appendix-glossary.md (付録A: 用語対応表)
- docs/appendix-bibliography.md (付録B: 参考文献の系譜)
- README.md
- CLAUDE.md
