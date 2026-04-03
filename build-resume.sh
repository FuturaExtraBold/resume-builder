#!/bin/bash
# build-resume.sh  —  Resume.md → output/Resume.pdf + output/Resume.docx
#
# USAGE:
#   ./build-resume.sh          → build once
#   ./build-resume.sh --watch  → rebuild on changes to Resume.md or resume.css

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
INPUT="$SCRIPT_DIR/Resume.md"
CSS="$SCRIPT_DIR/resume.css"
REF="$SCRIPT_DIR/reference.docx"
OUT="$SCRIPT_DIR/output"
PDF_OUT="$OUT/Resume.pdf"
DOCX_OUT="$OUT/Resume.docx"

build() {
  echo "Building resume..."

  # PDF via md-to-pdf (headless Chrome — outputs next to input, then moved)
  md-to-pdf "$INPUT" \
    --stylesheet "$CSS" \
    --pdf-options '{"format":"Letter","printBackground":true,"margin":{"top":"0","bottom":"0","left":"0","right":"0"}}'

  mv "$SCRIPT_DIR/Resume.pdf" "$PDF_OUT"
  echo "  ✓ output/Resume.pdf"

  # DOCX with reference template for formatting
  pandoc "$INPUT" --reference-doc="$REF" -o "$DOCX_OUT"
  echo "  ✓ output/Resume.docx"

  echo "Done."
}

if [[ "$1" == "--watch" ]]; then
  echo "Watching Resume.md and resume.css for changes... (Ctrl+C to stop)"
  build
  nodemon --watch "$INPUT" --watch "$CSS" --ext md,css --exec "bash $SCRIPT_DIR/build-resume.sh"
else
  build
fi
