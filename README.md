# Eye-movement experiments with OpenSesame and PyGaze

A workshop for researchers who have used neither OpenSesame nor PyGaze: slides plus four ready-to-run
experiments. The slides are built around three challenges: rebuild a reading study on commas
(Angele, Gutiérrez-Cordero, Perea & Marcet, 2023), a gaze-contingent boundary experiment
(Serrano-Carot & Angele, 2026) and a moving-window experiment, followed by the visual world paradigm.

**Slides:** published with GitHub Pages (Settings → Pages → Source: *GitHub Actions*; the workflow in
`.github/workflows/pages.yml` renders and deploys them on every push to `main`).

## Experiments

All are in `experiments/osexp/` and open in OpenSesame 4. They use PyGaze with the *advanced dummy*
tracker by default (the mouse acts as the eye), so you can try them without hardware. Switch the tracker
in the `pygaze_init` item for a real device.

| File | What it is |
|------|------------|
| `reading.osexp` | Comma study: Spanish sentences with and without commas, two counterbalanced lists |
| `boundary.osexp` | Boundary paradigm: invisible boundary, preview change, three block orders |
| `movingwindow.osexp` | Gaze-contingent moving window (window locked during fixations) |
| `vwp.osexp` | Visual world: four pictures, spoken instruction, mouse click |
| `reading_short.osexp`, `boundary_short.osexp` | Short versions for pilots and demos |

Open one with `opensesame experiments/osexp/reading.osexp`. Items for the EyeLink Host PC
(`eyelink_*`) only act when the tracker is an SR Research EyeLink.

### Materials

- `experiments/comas.csv` – sentences of the comma study
- `experiments/sentences.csv` – Spanish boundary sentences (10 practice + 3 × 70)
- `experiments/movingwindow.csv` – moving-window sentences
- `experiments/vwp_pool/` – pictures, sounds and `stimuli.csv` (target-word onsets)

### Source and checks

- `experiments/build_osexp.py` is the readable source of the `.osexp` files (OpenSesame script plus inline
  Python). Don't edit the `.osexp` files by hand; change the generator and run `make experiments`.
- `experiments/check_interest_areas.py` compares the computed letter and word positions with the rendered
  pixels for every sentence (needs the OpenSesame Python and an X display; ~10 minutes). It should end with
  `CORRECT`. Run it again after changing fonts, layout or materials, and on the lab PC.

## Working in the dev container

`.devcontainer/` builds an image with OpenSesame, PyGaze, Quarto and a desktop (Xvfb + noVNC).
Open the folder in VS Code → *Reopen in Container*, then open port 8080 for the OpenSesame desktop.
`start-desktop.sh` starts the desktop automatically.

```bash
make            # render slides/workshop.html
make preview    # live preview
make site       # build _site/ as served by GitHub Pages
make experiments
/home/ubuntu/venv/bin/python experiments/check_interest_areas.py
```

## Layout

```
.devcontainer/   container configuration
.github/         GitHub Pages workflow
slides/          workshop.qmd, CSS, animations.js (+ vendored GSAP), references.bib, images
experiments/     osexp/, stimulus files, build_osexp.py, check_interest_areas.py
Makefile
```

## Licence and credits

Slide animations use [GSAP](https://gsap.com).
