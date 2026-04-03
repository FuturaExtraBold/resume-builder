#!/bin/bash
# build-resume.sh  —  ResumeMaster.md → output/Ben-Hays-Resume.pdf + output/Ben-Hays-Resume.docx
#
# USAGE:
#   ./build-resume.sh          → build once
#   ./build-resume.sh --watch  → rebuild on changes to ResumeMaster.md or resume.css

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
INPUT="$SCRIPT_DIR/ResumeMaster.md"
CSS="$SCRIPT_DIR/resume.css"
REF="$SCRIPT_DIR/reference.docx"
OUT="$SCRIPT_DIR/output"
PDF_OUT="$OUT/Ben-Hays-Resume.pdf"
DOCX_OUT="$OUT/Ben-Hays-Resume.docx"

build() {
  echo "Building resume..."

  # PDF via md-to-pdf (headless Chrome — outputs next to input, then moved)
  md-to-pdf "$INPUT" \
    --stylesheet "$CSS" \
    --pdf-options '{"format":"Letter","printBackground":true,"margin":{"top":"0","bottom":"0","left":"0","right":"0"}}'

  mv "$SCRIPT_DIR/ResumeMaster.pdf" "$PDF_OUT"
  echo "  ✓ output/Ben-Hays-Resume.pdf"

  # DOCX with reference template for formatting
  pandoc "$INPUT" --reference-doc="$REF" -o "$DOCX_OUT"
  echo "  ✓ output/Ben-Hays-Resume.docx"

  echo "Done."
}

if [[ "$1" == "--watch" ]]; then
  echo "Watching ResumeMaster.md and resume.css for changes... (Ctrl+C to stop)"
  build
  nodemon --watch "$INPUT" --watch "$CSS" --ext md,css --exec "bash $SCRIPT_DIR/build-resume.sh"
else
  build
fi
