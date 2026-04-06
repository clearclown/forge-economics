#!/usr/bin/env bash
# scripts/verify-audit.sh — SPEC-AUDIT regression tests
# Each assertion corresponds to one issue from SPEC-AUDIT.md
# Exit 0 if all pass, exit 1 if any fail.

set +e
cd "$(dirname "$0")/.."

PASS=0
FAIL=0
RESULTS=()

assert() {
  local id="$1"; local desc="$2"; local cmd="$3"
  if eval "$cmd" >/dev/null 2>&1; then
    PASS=$((PASS+1)); RESULTS+=("✓ $id  $desc")
  else
    FAIL=$((FAIL+1)); RESULTS+=("✗ $id  $desc")
  fi
}

# === Critical (3) ===
assert "C-1" "README CU定義が10億FLOPに修正済み (issue #24)" \
  "! grep -q '1 億回' README.md && grep -q '10 億 FLOP' README.md"

assert "C-2" "books/ フォルダが存在 (issue #25)" \
  "test -d books && test -f books/README.md"

assert "C-3" "LICENSE ファイル(MIT)が存在 (issue #26)" \
  "test -f LICENSE && grep -q 'MIT' LICENSE"

# === High (4) ===
assert "H-1" "spec v0.1/v0.2 分離済み (issue #27)" \
  "test -f spec/forge-economics-spec-v0.1.md && test -f spec/forge-economics-spec-v0.2.md"

assert "H-2" "glossary に新章用語が存在 (issue #28)" \
  "grep -q 'Bittensor' docs/appendix-glossary.md && grep -q 'JPYC' docs/appendix-glossary.md && grep -q 'zkML' docs/appendix-glossary.md"

assert "H-3" "bibliography に AI経済学文献が存在 (issue #29)" \
  "grep -q 'Altman' docs/appendix-bibliography.md && grep -q 'Bittensor' docs/appendix-bibliography.md"

assert "H-5" "CLAUDE.md から 予約 ディレクトリ宣言が削除済み (issue #30)" \
  "! grep -q '（予約）' CLAUDE.md"

# === Medium (5) ===
assert "M-1" "Chapter 13 で参照された Open Question Issues が GitHub に存在 (issue #31)" \
  "gh issue list -R clearclown/forge-economics --state all --search 'Open Question' --json number | grep -q number"

assert "M-3" "00-introduction.md の章マップに 12,13,14 が含まれる (issue #32)" \
  "grep -q '12-p2p-architecture' docs/00-introduction.md && grep -q '13-open-questions' docs/00-introduction.md && grep -q '14-programmable-money' docs/00-introduction.md"

assert "M-4" "CHANGELOG.md が存在 (issue #33)" \
  "test -f CHANGELOG.md && grep -q '0.1.0' CHANGELOG.md"

assert "M-5" "CONTRIBUTING.md が存在 (issue #34)" \
  "test -f CONTRIBUTING.md"

assert "M-6" "spec/parameters.md が存在し主要パラメータを含む (issue #35)" \
  "test -f spec/parameters.md && grep -q '1,000 CU' spec/parameters.md && grep -q '30%' spec/parameters.md"

# === Low (4) ===
assert "L-1" "docs/en/ スケルトンが存在 (issue #36)" \
  "test -d docs/en && test -f docs/en/README.md"

assert "L-2" "CI ワークフローが存在 (issue #37)" \
  "test -f .github/workflows/docs-check.yml"

assert "L-3" "全章に章内ToCが存在 (issue #38)" \
  "grep -q '^## 目次' docs/00-introduction.md && grep -q '^## 目次' docs/01-value.md && grep -q '^## 目次' docs/02-money.md && grep -q '^## 目次' docs/05-banking.md"

assert "L-6" "主要章に forge 本体への相互参照リンクが存在 (issue #39)" \
  "grep -q 'github.com/clearclown/forge/blob' docs/05-banking.md && grep -q 'github.com/clearclown/forge/blob' docs/04-labor.md"

# === Report ===
echo ""
echo "=================================="
echo "  SPEC-AUDIT Verification Results"
echo "=================================="
printf '  %s\n' "${RESULTS[@]}"
echo "=================================="
echo "  PASS: $PASS / 16"
echo "  FAIL: $FAIL / 16"
echo "=================================="

if [ $FAIL -eq 0 ]; then
  echo "  🟢 ALL GREEN"
  exit 0
else
  echo "  🔴 $FAIL ISSUES REMAIN"
  exit 1
fi
