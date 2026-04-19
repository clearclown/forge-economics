# Tirami Papers

Working drafts and protocol design documents. **Not peer-reviewed**,
not submitted to any journal. See `../SECURITY.md` and the front
matter of each document for the exact status.

## Files

| File | Status | Description |
|---|---|---|
| `compute-standard.md` | working draft v0.1 | Full protocol write-up synthesising theory (§1-§18 of `../docs/`) and empirical Phase 1-10 results. Markdown source. ~1 100 lines. |
| `forge-v0.3-deployment.md` | snapshot | Phase 10 deployment notes (historical, kept for reproducibility). |
| `header-local.tex` | preamble | xelatex preamble used for the local-build PDF (STIX Two Text, macOS system fonts). |
| `header-arxiv.tex` | preamble | xelatex preamble used for arXiv submission (Latin Modern, TeX Live shipped). |
| `Makefile` | build pipeline | Pandoc + xelatex build targets. |
| `build/compute-standard.pdf` | **generated** | Local-build PDF (STIX Two Text). ~120 KB, 23 pages. |
| `build/compute-standard.arxiv.pdf` | **generated** | arXiv-compatible PDF (Latin Modern). ~140 KB, 23 pages. |
| `build/compute-standard.arxiv.tex` | **generated** | Standalone LaTeX source for arXiv upload. |
| `build/compute-standard.arxiv.tar.gz` | **generated** | Tarball ready for arXiv submission. |

## Quick start

```bash
cd papers/
make pdf          # local PDF build (STIX, ~10 s on a modern Mac)
make arxiv-pdf    # arXiv-compatible PDF (Latin Modern)
make arxiv-tar    # tarball ready to upload to arXiv
make clean        # remove build/ contents
```

Requires:
- `pandoc ≥ 3.0` (install: `brew install pandoc`)
- `xelatex` from TeX Live 2024 or later (install: MacTeX or `brew install --cask mactex-no-gui`)

## arXiv submission workflow

1. **Local sanity check**:
   ```bash
   make clean && make arxiv-pdf
   open build/compute-standard.arxiv.pdf
   ```
   Read through pagination, check that arrows / math symbols render,
   confirm the `working draft, not peer-reviewed` banner on page 1.

2. **Generate the upload tarball**:
   ```bash
   make arxiv-tar
   # → build/compute-standard.arxiv.tar.gz
   ```

3. **Upload to arXiv**:
   - Login at https://arxiv.org/.
   - `Start New Submission`.
   - Primary category suggestions:
     - `cs.DC` (Distributed, Parallel, and Cluster Computing) — the
       protocol story.
     - `cs.CR` (Cryptography and Security) — the dual-sign / slashing /
       Constitutional parameters angle.
     - Secondary: `cs.MA` (Multi-agent systems), `econ.GN`
       (General economics).
   - Title: "The Compute Standard: A Post-Marketing Economy for
     Autonomous AI Agents"
   - Abstract: copy from the first paragraph of `Abstract` in
     `compute-standard.md`.
   - Upload `compute-standard.arxiv.tar.gz` as source.
   - arXiv auto-compiles using TeX Live; preview carefully before
     confirming.

4. **After submission**:
   - arXiv issues an identifier like `2604.12345`. Add it to
     `compute-standard.md` frontmatter and to this README.
   - Open a GitHub issue to track any post-submission revisions
     (arXiv allows v2, v3 etc.).

## Notes on the working-draft status

- The paper describes **design intent** for zkML (§17 of `../docs/`)
  and features that are still scaffolded (ML-DSA PQ signatures, TEE
  attestation). The abstract and status notice make this explicit.
- Empirical claims about the Rust implementation (test counts,
  benchmark numbers) are as of 2026-04-19. Update if materially
  different by the time of submission.
- CC-BY-4.0 applies to figures; MIT applies to prose. arXiv's
  license picker: choose `CC BY 4.0` for text + figures combined
  (arXiv doesn't support per-asset licensing).

## Future revisions

When substantive changes are needed (beyond fix-up typos), bump the
version in `compute-standard.md` frontmatter (e.g. v0.1 → v0.2)
and re-submit to arXiv as a new version. arXiv preserves v1 as a
permanent record.
