# PEC-Nav: Self-Calibrating Frontier Search for Embodied Question Answering

WACV 2027 submission source (paper ID 637).

## Structure

- `main.tex` — top-level document (WACV two-column style, `wacv.sty`)
- `Sections/` — paper body, included via `\input`
  - `0_abstract.tex`
  - `1_intro.tex`
  - `2_related_work.tex`
  - `3_method.tex`
  - `4_experiments.tex`
  - `5_Discussion.tex`
  - `6_conclusion.tex`
- `references.bib` — bibliography (IEEE `ieee_fullname` style)
- `figures/` — image assets referenced by the paper
- `wacv.sty` — WACV conference style file

## Building

```bash
latexmk -pdf -interaction=nonstopmode main.tex
```

`main.pdf` is the compiled output and is tracked in this repo (see `.gitignore`). Run `latexmk -c main.tex` to remove intermediate build files (`.aux`, `.bbl`, `.blg`, `.log`, `.fls`, `.fdb_latexmk`, etc.) without touching `main.pdf`.
