# Tirami Economics — paper build pipeline
#
# Two build paths:
#   make pdf          → local dev build using STIX Two Text (macOS system font).
#   make arxiv-pdf    → arXiv-compatible build using Latin Modern (TeX Live only).
#   make arxiv-tar    → tarball ready for arXiv upload (tex + header + figures).
#
# Requires: pandoc (≥ 3.0), xelatex (TeX Live 2024+).

SHELL := /bin/bash

BUILD := build
SRC   := compute-standard.md
TEX   := $(BUILD)/compute-standard.tex
PDF   := $(BUILD)/compute-standard.pdf
PDF_ARXIV := $(BUILD)/compute-standard.arxiv.pdf
TEX_ARXIV := $(BUILD)/compute-standard.arxiv.tex
TAR_ARXIV := $(BUILD)/compute-standard.arxiv.tar.gz

PANDOC_OPTS := \
  -V geometry:margin=1in \
  -V documentclass=article \
  -V fontsize=11pt \
  --toc --toc-depth=2 \
  --number-sections \
  --standalone

.PHONY: help all pdf tex arxiv-pdf arxiv-tex arxiv-tar clean

help:
	@echo "Tirami paper build targets:"
	@echo "  make pdf        — local PDF (STIX Two Text; needs macOS system fonts)"
	@echo "  make tex        — local LaTeX source"
	@echo "  make arxiv-pdf  — arXiv-compatible PDF (Latin Modern only)"
	@echo "  make arxiv-tex  — arXiv-compatible LaTeX source (standalone)"
	@echo "  make arxiv-tar  — tarball ready to upload to arXiv"
	@echo "  make clean      — remove build/ contents"

all: pdf arxiv-pdf arxiv-tar

$(BUILD):
	mkdir -p $(BUILD)

pdf: $(BUILD)
	pandoc $(SRC) -o $(PDF) \
	  --pdf-engine=xelatex \
	  -H header-local.tex \
	  $(PANDOC_OPTS)
	@echo "==> $(PDF) ($$(du -h $(PDF) | cut -f1))"

tex: $(BUILD)
	pandoc $(SRC) -o $(TEX) \
	  -H header-local.tex \
	  $(PANDOC_OPTS)
	@echo "==> $(TEX)"

arxiv-pdf: $(BUILD)
	pandoc $(SRC) -o $(PDF_ARXIV) \
	  --pdf-engine=xelatex \
	  -H header-arxiv.tex \
	  $(PANDOC_OPTS)
	@echo "==> $(PDF_ARXIV) ($$(du -h $(PDF_ARXIV) | cut -f1))"

arxiv-tex: $(BUILD)
	pandoc $(SRC) -o $(TEX_ARXIV) \
	  -H header-arxiv.tex \
	  $(PANDOC_OPTS)
	@echo "==> $(TEX_ARXIV)"

arxiv-tar: arxiv-tex
	@# arXiv expects a single tarball containing the .tex + any
	@# supporting files. We inline the preamble via pandoc's -H so
	@# the generated .tex is already self-contained; no header file
	@# needs to ship separately.
	@# If we later add figures/ we'll extend the `tar cf` list.
	tar czf $(TAR_ARXIV) -C $(BUILD) compute-standard.arxiv.tex
	@echo "==> $(TAR_ARXIV) ($$(du -h $(TAR_ARXIV) | cut -f1))"
	@echo ""
	@echo "To upload to arXiv:"
	@echo "  1. Login at https://arxiv.org/"
	@echo "  2. Select 'Start New Submission', Primary Category: cs.DC or cs.CR"
	@echo "  3. Upload $(TAR_ARXIV)"
	@echo "  4. arXiv will auto-compile; preview before confirming."

clean:
	rm -rf $(BUILD)
	@echo "cleaned $(BUILD)/"
