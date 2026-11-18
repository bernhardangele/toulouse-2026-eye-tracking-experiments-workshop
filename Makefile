QUARTO ?= quarto

SLIDE_SRC := slides/workshop.qmd
SLIDE_HTML := slides/workshop.html
SLIDE_DEPS := \
	$(SLIDE_SRC) \
	slides/workshop.css \
	slides/animations.js \
	slides/animations-include.html \
	slides/references.bib \
	slides/apa.csl \
	slides/js/gsap.min.js \
	$(wildcard slides/images/*.png slides/images/vwp/*.png)

.DEFAULT_GOAL := slides

.PHONY: all slides preview experiments site clean help

all: slides

slides: $(SLIDE_HTML)

$(SLIDE_HTML): $(SLIDE_DEPS)
	$(QUARTO) render $(SLIDE_SRC)

preview:
	$(QUARTO) preview $(SLIDE_SRC)

# Regenerate the .osexp files from experiments/build_osexp.py
experiments:
	python3 experiments/build_osexp.py

# The folder that GitHub Pages serves (see .github/workflows/pages.yml)
site: $(SLIDE_HTML)
	rm -rf _site && mkdir -p _site
	cp $(SLIDE_HTML) _site/index.html
	cp -r slides/workshop_files _site/workshop_files
	cp -r slides/js slides/images slides/workshop.css slides/animations.js _site/
	touch _site/.nojekyll

clean:
	rm -rf $(SLIDE_HTML) slides/workshop_files slides/.quarto _site

help:
	@echo "Targets:"
	@echo "  make [slides]   Render $(SLIDE_HTML) with Quarto"
	@echo "  make preview    Live-preview the slides"
	@echo "  make experiments Regenerate experiments/osexp/*.osexp"
	@echo "  make site       Build _site/ for GitHub Pages"
	@echo "  make clean      Remove rendered outputs"
