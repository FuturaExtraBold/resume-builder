#!/bin/bash
# build-resume.sh  —  Builds resume + cover letter
#
# USAGE:
#   ./build-resume.sh          → build once
#   ./build-resume.sh --watch  → rebuild on changes to any .md or resume.css

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
RESUME_INPUT="$SCRIPT_DIR/ResumeMaster.md"
COVER_INPUT="$SCRIPT_DIR/CoverMaster.md"
CSS="$SCRIPT_DIR/resume.css"
REF="$SCRIPT_DIR/reference.docx"
OUT="$SCRIPT_DIR/output"
PDF_OPTIONS='{"format":"Letter","printBackground":true,"margin":{"top":"0","bottom":"0","left":"0","right":"0"}}'

build() {
  echo "Building..."

  # Resume PDF
  md-to-pdf "$RESUME_INPUT" --stylesheet "$CSS" --pdf-options "$PDF_OPTIONS"
  mv "$SCRIPT_DIR/ResumeMaster.pdf" "$OUT/Ben-Hays-Resume.pdf"
  echo "  ✓ output/Ben-Hays-Resume.pdf"

  # Resume DOCX
  pandoc "$RESUME_INPUT" --reference-doc="$REF" -o "$OUT/Ben-Hays-Resume.docx"
  echo "  ✓ output/Ben-Hays-Resume.docx"

  # Cover Letter PDF
  md-to-pdf "$COVER_INPUT" --stylesheet "$CSS" --pdf-options "$PDF_OPTIONS"
  mv "$SCRIPT_DIR/CoverMaster.pdf" "$OUT/Ben-Hays-Cover-Letter.pdf"
  echo "  ✓ output/Ben-Hays-Cover-Letter.pdf"

  echo "Done."
}

if [[ "$1" == "--watch" ]]; then
  echo "Watching .md files and resume.css for changes... (Ctrl+C to stop)"
  build
  nodemon --watch "$RESUME_INPUT" --watch "$COVER_INPUT" --watch "$CSS" --ext md,css --exec "bash $SCRIPT_DIR/build-resume.sh"
else
  build
fi
