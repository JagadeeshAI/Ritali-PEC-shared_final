#!/usr/bin/env bash
# Installs a LaTeX toolchain sufficient to compile main.tex locally.
set -euo pipefail

sudo apt update
sudo apt install -y \
    texlive-latex-extra \
    texlive-fonts-recommended \
    texlive-bibtex-extra \
    texlive-science \
    latexmk

echo "Done. Compile with: latexmk -pdf main.tex"
